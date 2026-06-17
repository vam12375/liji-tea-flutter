import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// Circular "+" add-to-cart button used on product cards.
class AddButton extends StatelessWidget {
  const AddButton({super.key, this.onPressed, this.size = 32});

  final VoidCallback? onPressed;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.inkGreen,
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onPressed,
        child: SizedBox(
          width: size,
          height: size,
          child: Icon(Icons.add, color: AppColors.riceWhite, size: size * 0.55),
        ),
      ),
    );
  }
}
