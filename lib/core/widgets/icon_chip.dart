import 'package:flutter/material.dart';
import '../constants/app_sizes.dart';

/// Ícono dentro de un círculo/cuadro de color pastel. Da variedad visual
/// sin depender solo del verde de marca — cada módulo puede tener su
/// propio color de acento (azul para Vender, morado para Escanear, etc.)
class IconChip extends StatelessWidget {
  final IconData icon;
  final Color color;
  final Color background;
  final double size;

  const IconChip({
    super.key,
    required this.icon,
    required this.color,
    required this.background,
    this.size = 44,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(AppSizes.radiusMd),
      ),
      child: Icon(icon, color: color, size: size * 0.5),
    );
  }
}
