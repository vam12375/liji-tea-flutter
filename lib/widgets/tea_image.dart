import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// A decorative placeholder standing in for product photography.
///
/// Until real imagery / a CDN is wired up, this renders a soft "ink wash"
/// gradient with a tea-bowl motif so layouts read correctly.
class TeaImage extends StatelessWidget {
  const TeaImage({
    super.key,
    required this.swatch,
    this.icon = Icons.local_cafe,
    this.radius = 12,
    this.iconSize = 40,
  });

  final Color swatch;
  final IconData icon;
  final double radius;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color.lerp(swatch, Colors.white, 0.45)!,
            Color.lerp(swatch, AppColors.riceWhite, 0.15)!,
          ],
        ),
      ),
      child: Center(
        child: Icon(
          icon,
          size: iconSize,
          color: Color.lerp(swatch, AppColors.charcoalBlack, 0.35),
        ),
      ),
    );
  }
}
