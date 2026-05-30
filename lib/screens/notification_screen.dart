import 'package:flutter/material.dart';

import '../data/account_data.dart';
import '../models/account_models.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';
import '../widgets/soft_card.dart';
import '../widgets/status_view.dart';

/// 消息通知 — notification centre.
class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  late List<AppNotification> _items = List.of(AccountData.notifications);

  bool get _hasUnread => _items.any((n) => n.unread);

  void _markAllRead() {
    setState(() {
      _items = [for (final n in _items) n.copyWith(unread: false)];
    });
  }

  @override
  Widget build(BuildContext context) {
    final items = _items;
    return Scaffold(
      appBar: AppBar(
        title: Text('消息通知', style: AppTypography.h3),
        actions: [
          TextButton(
            onPressed: _hasUnread ? _markAllRead : null,
            child: Text('全部已读', style: AppTypography.sans(size: 13, color: AppColors.textSecondary)),
          ),
        ],
      ),
      body: SafeArea(
        top: false,
        child: items.isEmpty
            ? Center(
                child: StatusView(icon: Icons.notifications_none, title: '暂无新消息'),
              )
            : ListView(
                padding: const EdgeInsets.fromLTRB(
                    AppSpacing.screenMargin, AppSpacing.md, AppSpacing.screenMargin, AppSpacing.xl),
                children: [for (final n in items) _NotificationCard(item: n)],
              ),
      ),
    );
  }
}

class _NotificationCard extends StatelessWidget {
  const _NotificationCard({required this.item});

  final AppNotification item;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      child: SoftCard(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.inkGreen.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(AppRadius.image),
              ),
              child: Icon(item.icon, size: 20, color: AppColors.inkGreen),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(item.title, style: AppTypography.sans(size: 14, weight: FontWeight.w600)),
                      const SizedBox(width: AppSpacing.xs),
                      if (item.unread)
                        Container(
                          width: 7,
                          height: 7,
                          decoration: const BoxDecoration(color: AppColors.gold, shape: BoxShape.circle),
                        ),
                      const Spacer(),
                      Text(item.time, style: AppTypography.caption),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.xxs),
                  Text(item.body, style: AppTypography.sans(size: 13, height: 1.6, color: AppColors.textSecondary)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
