import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// Renders product imagery. When [assetPath] is supplied the real photograph
/// is shown; otherwise a soft "ink wash" placeholder stands in for it.
class TeaImage extends StatelessWidget {
  const TeaImage({
    super.key,
    required this.swatch,
    this.assetPath,
    this.icon = Icons.local_cafe,
    this.radius = 12,
    this.iconSize = 40,
    this.fit = BoxFit.cover,
  });

  final Color swatch;
  final String? assetPath;
  final IconData icon;
  final double radius;
  final double iconSize;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    if (assetPath != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: Image.asset(assetPath!, fit: fit),
      );
    }
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
