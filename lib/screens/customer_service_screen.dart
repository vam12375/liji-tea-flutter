import 'package:flutter/material.dart';

import '../data/account_data.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';

/// 在线客服 — chat-style customer support (static demo).
class CustomerServiceScreen extends StatefulWidget {
  const CustomerServiceScreen({super.key});

  @override
  State<CustomerServiceScreen> createState() => _CustomerServiceScreenState();
}

class _Message {
  const _Message({required this.text, required this.fromUser});
  final String text;
  final bool fromUser;
}

class _CustomerServiceScreenState extends State<CustomerServiceScreen> {
  final List<_Message> _messages = [
    const _Message(text: '您好,我是李记茶小蜜 🍵 很高兴为您服务,请问有什么可以帮您?', fromUser: false),
  ];
  final TextEditingController _input = TextEditingController();
  final ScrollController _scroll = ScrollController();

  static const Map<String, String> _answers = {
    '如何查询物流?': '您可在「我的-我的订单」中找到对应订单,点击「查看物流」即可实时查看包裹状态。',
    '可以开发票吗?': '支持开具电子发票,订单完成后在订单详情页点击「申请开票」填写抬头即可,约 1 个工作日开出。',
    '怎么申请退换货?': '在「我的-退款/售后」中选择对应订单,填写售后类型与原因提交即可,我们会在 24 小时内处理。',
    '茶叶如何保存?': '建议密封、避光、防潮、防异味保存;绿茶可冷藏,普洱等可常温存放于通风干燥处。',
  };

  @override
  void dispose() {
    _input.dispose();
    _scroll.dispose();
    super.dispose();
  }

  void _send(String text) {
    final t = text.trim();
    if (t.isEmpty) return;
    setState(() {
      _messages.add(_Message(text: t, fromUser: true));
      _messages.add(_Message(text: _answers[t] ?? '已收到您的问题,客服稍后会进一步为您解答,感谢您的耐心等待。', fromUser: false));
      _input.clear();
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scroll.hasClients) {
        _scroll.animateTo(_scroll.position.maxScrollExtent,
            duration: const Duration(milliseconds: 250), curve: Curves.easeOut);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('在线客服', style: AppTypography.h3)),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                controller: _scroll,
                padding: const EdgeInsets.all(AppSpacing.screenMargin),
                children: [
                  for (final m in _messages) _Bubble(message: m),
                  const SizedBox(height: AppSpacing.sm),
                  _quickQuestions(),
                ],
              ),
            ),
            _inputBar(),
          ],
        ),
      ),
    );
  }

  Widget _quickQuestions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('猜你想问', style: AppTypography.caption),
        const SizedBox(height: AppSpacing.xs),
        Wrap(
          spacing: AppSpacing.sm,
          runSpacing: AppSpacing.sm,
          children: [
            for (final q in AccountData.serviceQuickQuestions)
              GestureDetector(
                onTap: () => _send(q),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.xs),
                  decoration: BoxDecoration(
                    color: AppColors.cardSurface,
                    borderRadius: BorderRadius.circular(AppRadius.chip),
                    border: Border.all(color: AppColors.divider),
                  ),
                  child: Text(q, style: AppTypography.sans(size: 13, color: AppColors.inkGreen)),
                ),
              ),
          ],
        ),
      ],
    );
  }

  Widget _inputBar() {
    return Container(
      padding: EdgeInsets.fromLTRB(
        AppSpacing.screenMargin,
        AppSpacing.sm,
        AppSpacing.screenMargin,
        AppSpacing.sm + MediaQuery.of(context).padding.bottom,
      ),
      decoration: const BoxDecoration(
        color: AppColors.riceWhite,
        border: Border(top: BorderSide(color: AppColors.divider)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.cardSurface,
                borderRadius: BorderRadius.circular(AppRadius.chip),
                border: Border.all(color: AppColors.divider),
              ),
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
              child: TextField(
                controller: _input,
                style: AppTypography.sans(size: 15),
                onSubmitted: _send,
                decoration: InputDecoration(
                  hintText: '请输入您的问题…',
                  hintStyle: AppTypography.sans(size: 15, color: AppColors.textTertiary),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
                ),
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          GestureDetector(
            onTap: () => _send(_input.text),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.sm),
              decoration: BoxDecoration(
                color: AppColors.inkGreen,
                borderRadius: BorderRadius.circular(AppRadius.chip),
              ),
              child: Text('发送', style: AppTypography.sans(size: 14, color: AppColors.riceWhite)),
            ),
          ),
        ],
      ),
    );
  }
}

class _Bubble extends StatelessWidget {
  const _Bubble({required this.message});

  final _Message message;

  @override
  Widget build(BuildContext context) {
    final user = message.fromUser;
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      child: Row(
        mainAxisAlignment: user ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!user) ...[
            const _Avatar(),
            const SizedBox(width: AppSpacing.xs),
          ],
          Flexible(
            child: Container(
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: user ? AppColors.inkGreen : AppColors.cardSurface,
                borderRadius: BorderRadius.circular(AppRadius.image),
                border: user ? null : Border.all(color: AppColors.divider),
              ),
              child: Text(
                message.text,
                style: AppTypography.sans(
                  size: 14,
                  height: 1.6,
                  color: user ? AppColors.riceWhite : AppColors.textPrimary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Avatar extends StatelessWidget {
  const _Avatar();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 32,
      height: 32,
      decoration: const BoxDecoration(color: AppColors.inkGreen, shape: BoxShape.circle),
      child: Center(
        child: Text('茶', style: AppTypography.serif(size: 14, color: AppColors.gold)),
      ),
    );
  }
}
