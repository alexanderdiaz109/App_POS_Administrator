import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';

class PlaceholderScreen extends StatelessWidget {
  final String title;
  final IconData icon;
  final String? note;

  const PlaceholderScreen({
    super.key,
    required this.title,
    required this.icon,
    this.note,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 56, color: AppColors.textSecondary),
              const SizedBox(height: 16),
              Text(title, style: AppTextStyles.h2, textAlign: TextAlign.center),
              if (note != null) ...[
                const SizedBox(height: 8),
                Text(note!, style: AppTextStyles.bodySecondary, textAlign: TextAlign.center),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
