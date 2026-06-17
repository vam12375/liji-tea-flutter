import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_typography.dart';

/// Shows the standard "added to cart" confirmation SnackBar.
void showCartSnack(BuildContext context, String productName) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Text(
          '已将「$productName」加入购物车',
          style: AppTypography.sans(size: 14, color: AppColors.riceWhite),
        ),
        backgroundColor: AppColors.inkGreen,
        behavior: SnackBarBehavior.floating,
      ),
    );
}
