import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../data/account_data.dart';
import '../models/account_models.dart';
import '../models/tea_product.dart';
import '../navigation/app_router.dart';
import '../state/app_state.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';
import '../widgets/segment_control.dart';
import '../widgets/soft_card.dart';
import '../widgets/status_view.dart';
import '../widgets/tea_image.dart';

/// 我的订单 — order list with status tabs.
class OrderListScreen extends StatefulWidget {
  const OrderListScreen({super.key, this.initialStatus});

  final OrderStatus? initialStatus;

  @override
  State<OrderListScreen> createState() => _OrderListScreenState();
}

class _OrderListScreenState extends State<OrderListScreen> {
  static const List<(String, OrderStatus?)> _tabs = [
    ('全部', null),
    ('待付款', OrderStatus.pendingPay),
    ('待发货', OrderStatus.pendingShip),
    ('待收货', OrderStatus.pendingReceive),
    ('待评价', OrderStatus.pendingReview),
  ];

  late int _tab;

  @override
  void initState() {
    super.initState();
    _tab = widget.initialStatus == null
        ? 0
        : _tabs.indexWhere((t) => t.$2 == widget.initialStatus).clamp(0, _tabs.length - 1);
  }

  @override
  Widget build(BuildContext context) {
    final orders = AccountData.ordersByStatus(_tabs[_tab].$2);
    return Scaffold(
      appBar: AppBar(title: Text('我的订单', style: AppTypography.h3)),
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(AppSpacing.screenMargin),
              child: SegmentControl(
                segments: [for (final t in _tabs) t.$1],
                selected: _tab,
                onSelected: (i) => setState(() => _tab = i),
              ),
            ),
            Expanded(
              child: orders.isEmpty
                  ? Center(
                      child: StatusView(
                        icon: Icons.receipt_long_outlined,
                        title: '暂无相关订单',
                        subtitle: '快去挑选心仪的好茶吧',
                      ),
                    )
                  : ListView(
                      padding: const EdgeInsets.fromLTRB(
                          AppSpacing.screenMargin, 0, AppSpacing.screenMargin, AppSpacing.xl),
                      children: [for (final o in orders) _OrderCard(order: o)],
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OrderCard extends StatelessWidget {
  const _OrderCard({required this.order});

  final OrderEntry order;

  int get _count => order.items.fold(0, (sum, it) => sum + it.quantity);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      child: SoftCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text('订单号 ${order.id}', style: AppTypography.caption),
                const Spacer(),
                Text(order.status.label,
                    style: AppTypography.sans(
                        size: 13, weight: FontWeight.w600, color: AppColors.inkGreen)),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            for (final item in order.items) _OrderItemRow(item: item),
            const Divider(color: AppColors.divider, height: AppSpacing.lg),
            Row(
              children: [
                Text('共 $_count 件', style: AppTypography.caption),
                const Spacer(),
                Text('合计 ', style: AppTypography.caption),
                Text('¥${order.total}',
                    style: AppTypography.serif(
                        size: 18, weight: FontWeight.w700, color: AppColors.inkGreen)),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: _actions(context),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _actions(BuildContext context) {
    final buttons = <Widget>[];
    void add(String label, {required bool primary, required VoidCallback onTap}) {
      buttons.add(_OrderActionButton(label: label, primary: primary, onTap: onTap));
      buttons.add(const SizedBox(width: AppSpacing.sm));
    }

    switch (order.status) {
      case OrderStatus.pendingPay:
        add('取消订单', primary: false, onTap: () => _toast(context, '订单已取消'));
        add('去付款',
            primary: true,
            onTap: () => context.pushNamed(
              AppRoutes.payment,
              pathParameters: {'total': '${order.total}'},
            ));
      case OrderStatus.pendingShip:
        add('提醒发货', primary: false, onTap: () => _toast(context, '已提醒商家尽快发货'));
      case OrderStatus.pendingReceive:
        add('查看物流',
            primary: false,
            onTap: () => context.pushNamed(AppRoutes.logistics));
        add('确认收货', primary: true, onTap: () => _toast(context, '已确认收货,感谢您的购买'));
      case OrderStatus.pendingReview:
        add('去评价',
            primary: true,
            onTap: () => context.pushNamed(
              AppRoutes.reviews,
              pathParameters: {'productName': order.items.first.product.name},
            ));
      case OrderStatus.completed:
        add('再次购买', primary: false, onTap: () {
          final appState = AppStateScope.of(context);
          for (final item in order.items) {
            appState.addToCart(item.product, item.spec, quantity: item.quantity);
          }
          _toast(context, '已为你加入购物车');
        });
    }
    if (buttons.isNotEmpty) buttons.removeLast(); // trailing spacer
    return buttons;
  }

  void _toast(BuildContext context, String msg) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(msg, style: AppTypography.sans(size: 14, color: AppColors.riceWhite)),
          backgroundColor: AppColors.inkGreen,
          behavior: SnackBarBehavior.floating,
        ),
      );
  }
}

class _OrderItemRow extends StatelessWidget {
  const _OrderItemRow({required this.item});

  final CartItem item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Row(
        children: [
          SizedBox(
            width: 56,
            height: 56,
            child: TeaImage(swatch: item.product.swatch, radius: AppRadius.image, iconSize: 24),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.product.name, style: AppTypography.sans(size: 14, weight: FontWeight.w600)),
                const SizedBox(height: 2),
                Text(item.spec, style: AppTypography.caption),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('¥${item.product.price}', style: AppTypography.sans(size: 14, weight: FontWeight.w600)),
              const SizedBox(height: 2),
              Text('×${item.quantity}', style: AppTypography.caption),
            ],
          ),
        ],
      ),
    );
  }
}

class _OrderActionButton extends StatelessWidget {
  const _OrderActionButton({required this.label, required this.primary, required this.onTap});

  final String label;
  final bool primary;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.xs),
        decoration: BoxDecoration(
          color: primary ? AppColors.inkGreen : Colors.transparent,
          borderRadius: BorderRadius.circular(AppRadius.chip),
          border: Border.all(color: primary ? AppColors.inkGreen : AppColors.divider),
        ),
        child: Text(
          label,
          style: AppTypography.sans(
            size: 13,
            weight: FontWeight.w500,
            color: primary ? AppColors.riceWhite : AppColors.textSecondary,
          ),
        ),
      ),
    );
  }
}
