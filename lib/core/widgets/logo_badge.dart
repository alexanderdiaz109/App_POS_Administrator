import 'package:flutter/material.dart';
import '../constants/app_sizes.dart';

/// Ícono de marca dentro de un círculo blanco con sombra,
/// usado sobre el AuthHeader.
class LogoBadge extends StatelessWidget {
  final double size;
  const LogoBadge({super.key, this.size = 76});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppSizes.radiusLg),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Icon(Icons.storefront, color: Colors.green.shade700, size: size * 0.5),
    );
  }
}
