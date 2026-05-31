import 'package:flutter/material.dart';

import '../data/account_data.dart';
import '../models/account_models.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';
import '../widgets/app_icon.dart';
import '../widgets/primary_button.dart';
import '../widgets/soft_card.dart';
import '../widgets/status_view.dart';
import 'address_edit_screen.dart';

/// 收货地址 — address list with edit / add entries.
class AddressScreen extends StatelessWidget {
  const AddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final addresses = AccountData.addresses;
    return Scaffold(
      appBar: AppBar(title: Text('收货地址', style: AppTypography.h3)),
      body: SafeArea(
        top: false,
        child: addresses.isEmpty
            ? Center(
                child: StatusView(
                  icon: Icons.location_off_outlined,
                  title: '还没有收货地址',
                  subtitle: '添加地址,下单更方便',
                ),
              )
            : ListView(
                padding: const EdgeInsets.fromLTRB(
                    AppSpacing.screenMargin, AppSpacing.md, AppSpacing.screenMargin, AppSpacing.md),
                children: [for (final a in addresses) _AddressCard(address: a)],
              ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.fromLTRB(
          AppSpacing.screenMargin,
          AppSpacing.md,
          AppSpacing.screenMargin,
          AppSpacing.md + MediaQuery.of(context).padding.bottom,
        ),
        decoration: const BoxDecoration(
          color: AppColors.riceWhite,
          border: Border(top: BorderSide(color: AppColors.divider)),
        ),
        child: PrimaryButton(
          label: '新增收货地址',
          expand: true,
          onPressed: () => Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => const AddressEditScreen())),
        ),
      ),
    );
  }
}

class _AddressCard extends StatelessWidget {
  const _AddressCard({required this.address});

  final Address address;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      child: SoftCard(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 2),
              child: AppIcon(AppIcon.location, size: 22, color: AppColors.pineGreen),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(address.name, style: AppTypography.sans(size: 15, weight: FontWeight.w600)),
                      const SizedBox(width: AppSpacing.sm),
                      Text(address.phone, style: AppTypography.body),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (address.isDefault) _Tag(label: '默认', filled: true),
                      if (address.tag != null) _Tag(label: address.tag!),
                      Expanded(
                        child: Text('${address.region} ${address.detail}',
                            style: AppTypography.sans(size: 13, height: 1.5)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.edit_outlined, size: 20, color: AppColors.textTertiary),
              onPressed: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => AddressEditScreen(address: address))),
            ),
          ],
        ),
      ),
    );
  }
}

class _Tag extends StatelessWidget {
  const _Tag({required this.label, this.filled = false});

  final String label;
  final bool filled;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: AppSpacing.xs),
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xs, vertical: 1),
      decoration: BoxDecoration(
        color: filled ? AppColors.inkGreen : Colors.transparent,
        borderRadius: BorderRadius.circular(AppRadius.chip),
        border: Border.all(color: filled ? AppColors.inkGreen : AppColors.gold),
      ),
      child: Text(
        label,
        style: AppTypography.sans(
          size: 11,
          color: filled ? AppColors.riceWhite : AppColors.gold,
        ),
      ),
    );
  }
}
