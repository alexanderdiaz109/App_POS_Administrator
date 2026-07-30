import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_text_styles.dart';

class OnboardingStep extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const OnboardingStep({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 120,
          height: 120,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, size: 56, color: AppColors.primary),
        ),
        const SizedBox(height: AppSizes.xl),
        Text(title, style: AppTextStyles.h1, textAlign: TextAlign.center),
        const SizedBox(height: AppSizes.sm),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSizes.md),
          child: Text(description, style: AppTextStyles.bodySecondary, textAlign: TextAlign.center),
        ),
      ],
    );
  }
}
