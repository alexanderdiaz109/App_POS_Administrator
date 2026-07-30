import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_sizes.dart';
import '../constants/app_text_styles.dart';
import '../routes/route_names.dart';

/// Se muestra en lugar de una función bloqueada por plan, en vez de
/// simplemente ocultarla. Convierte el límite en una oportunidad de
/// upsell claro hacia change_plan_screen.
class LockedFeatureCard extends StatelessWidget {
  final String title;
  final String requiredPlan;
  final IconData icon;

  const LockedFeatureCard({
    super.key,
    required this.title,
    required this.requiredPlan,
    this.icon = Icons.lock_outline,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSizes.md),
      decoration: BoxDecoration(
        color: AppColors.surfaceAlt,
        borderRadius: BorderRadius.circular(AppSizes.radiusMd),
        border: Border.all(color: AppColors.divider),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.textSecondary),
          const SizedBox(width: AppSizes.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTextStyles.body.copyWith(fontWeight: FontWeight.w600)),
                Text('Disponible en Plan $requiredPlan', style: AppTextStyles.caption),
              ],
            ),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pushNamed(RouteNames.changePlan),
            child: const Text('Mejorar'),
          ),
        ],
      ),
    );
  }
}
