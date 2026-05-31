import 'package:flutter/material.dart';

/// Renders one of the brand's custom line icons from `assets/icons/`.
///
/// The source PNGs are single-color (墨绿 #2D5016) line icons on a
/// transparent background, so an optional [color] re-tints every opaque
/// pixel via [BlendMode.srcIn] to fit different surfaces (light, dark,
/// selected states, etc.).
class AppIcon extends StatelessWidget {
  const AppIcon(this.name, {super.key, this.size = 24, this.color});

  /// File name without extension, e.g. `'cart'`, `'search'`.
  final String name;
  final double size;
  final Color? color;

  // Available custom icons under assets/icons/.
  static const String cart = 'cart';
  static const String favorite = 'favorite';
  static const String filter = 'filter';
  static const String location = 'location';
  static const String message = 'message';
  static const String search = 'search';
  static const String settings = 'settings';
  static const String share = 'share';

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/icons/$name.png',
      width: size,
      height: size,
      color: color,
      colorBlendMode: color != null ? BlendMode.srcIn : null,
    );
  }
}
