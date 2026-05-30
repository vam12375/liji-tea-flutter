import 'package:flutter/material.dart';

import '../models/account_models.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';
import '../widgets/primary_button.dart';

/// 新增 / 编辑收货地址 — address form (static demo).
class AddressEditScreen extends StatefulWidget {
  const AddressEditScreen({super.key, this.address});

  final Address? address;

  @override
  State<AddressEditScreen> createState() => _AddressEditScreenState();
}

class _AddressEditScreenState extends State<AddressEditScreen> {
  late final TextEditingController _name;
  late final TextEditingController _phone;
  late final TextEditingController _region;
  late final TextEditingController _detail;
  late bool _default;

  @override
  void initState() {
    super.initState();
    final a = widget.address;
    _name = TextEditingController(text: a?.name ?? '');
    _phone = TextEditingController(text: a?.phone ?? '');
    _region = TextEditingController(text: a?.region ?? '');
    _detail = TextEditingController(text: a?.detail ?? '');
    _default = a?.isDefault ?? false;
  }

  @override
  void dispose() {
    _name.dispose();
    _phone.dispose();
    _region.dispose();
    _detail.dispose();
    super.dispose();
  }

  void _save() {
    Navigator.of(context).pop();
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text('地址已保存', style: AppTypography.sans(size: 14, color: AppColors.riceWhite)),
          backgroundColor: AppColors.inkGreen,
          behavior: SnackBarBehavior.floating,
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    final editing = widget.address != null;
    return Scaffold(
      appBar: AppBar(title: Text(editing ? '编辑地址' : '新增地址', style: AppTypography.h3)),
      body: SafeArea(
        top: false,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(
              AppSpacing.screenMargin, AppSpacing.md, AppSpacing.screenMargin, AppSpacing.xl),
          children: [
            _Field(label: '收货人', controller: _name, hint: '请输入收货人姓名'),
            _Field(label: '手机号', controller: _phone, hint: '请输入手机号', keyboardType: TextInputType.phone),
            _Field(label: '所在地区', controller: _region, hint: '省 / 市 / 区'),
            _Field(label: '详细地址', controller: _detail, hint: '街道、楼牌号等', maxLines: 2),
            const SizedBox(height: AppSpacing.md),
            Row(
              children: [
                Text('设为默认地址', style: AppTypography.sans(size: 14)),
                const Spacer(),
                Switch(
                  value: _default,
                  onChanged: (v) => setState(() => _default = v),
                  activeThumbColor: AppColors.riceWhite,
                  activeTrackColor: AppColors.inkGreen,
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.xl),
            PrimaryButton(label: '保存', expand: true, onPressed: _save),
          ],
        ),
      ),
    );
  }
}

class _Field extends StatelessWidget {
  const _Field({
    required this.label,
    required this.controller,
    required this.hint,
    this.maxLines = 1,
    this.keyboardType,
  });

  final String label;
  final TextEditingController controller;
  final String hint;
  final int maxLines;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: AppTypography.sans(size: 13, color: AppColors.textSecondary)),
          const SizedBox(height: AppSpacing.xs),
          Container(
            decoration: BoxDecoration(
              color: AppColors.cardSurface,
              borderRadius: BorderRadius.circular(AppRadius.image),
              border: Border.all(color: AppColors.divider),
            ),
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
            child: TextField(
              controller: controller,
              maxLines: maxLines,
              keyboardType: keyboardType,
              style: AppTypography.sans(size: 15),
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: AppTypography.sans(size: 15, color: AppColors.textTertiary),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
