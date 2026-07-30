import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/widgets/icon_chip.dart';

class QuickAccessItem {
  final String label;
  final IconData icon;
  final Color color;
  final Color background;
  final VoidCallback onTap;

  const QuickAccessItem({
    required this.label,
    required this.icon,
    required this.color,
    required this.background,
    required this.onTap,
  });
}

/// Grid de accesos rápidos del Dashboard. Cada acceso tiene su propio
/// color de acento (no todos verdes) para diferenciarse visualmente.
class QuickAccessGrid extends StatelessWidget {
  final List<QuickAccessItem> items;

  const QuickAccessGrid({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: AppSizes.sm,
        crossAxisSpacing: AppSizes.sm,
        childAspectRatio: 0.95,
      ),
      itemBuilder: (context, i) {
        final item = items[i];
        return Card(
          child: InkWell(
            borderRadius: BorderRadius.circular(AppSizes.radiusMd),
            onTap: item.onTap,
            child: Padding(
              padding: const EdgeInsets.all(AppSizes.sm),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconChip(icon: item.icon, color: item.color, background: item.background),
                  const SizedBox(height: AppSizes.xs),
                  Text(
                    item.label,
                    style: AppTextStyles.caption.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
