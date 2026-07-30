import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/widgets/error_state.dart';
import '../../data/providers/branch_providers.dart';

class BranchSwitcherSheet extends ConsumerWidget {
  const BranchSwitcherSheet({super.key});

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppSizes.radiusLg)),
      ),
      builder: (_) => const BranchSwitcherSheet(),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final branchesAsync = ref.watch(branchListControllerProvider);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.lg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Sucursales', style: AppTextStyles.h2),
            const SizedBox(height: AppSizes.md),
            branchesAsync.when(
              loading: () => const Padding(
                padding: EdgeInsets.all(AppSizes.md),
                child: Center(child: CircularProgressIndicator()),
              ),
              error: (err, _) => ErrorState(message: '$err'),
              data: (branches) {
                if (branches.isEmpty) {
                  return Padding(
                    padding: const EdgeInsets.all(AppSizes.md),
                    child: Text(
                      'Aún no tienes sucursales adicionales.',
                      style: AppTextStyles.bodySecondary,
                    ),
                  );
                }
                return Column(
                  children: branches.map((b) {
                    return ListTile(
                      contentPadding: EdgeInsets.zero,
                      enabled: b.activa,
                      leading: Icon(
                        Icons.store_mall_directory_outlined,
                        color: b.activa ? AppColors.primary : AppColors.textSecondary,
                      ),
                      title: Text(b.nombre, style: AppTextStyles.body),
                      subtitle: !b.activa
                          ? Text('Inactiva', style: AppTextStyles.caption)
                          : null,
                      onTap: b.activa ? () => Navigator.pop(context) : null,
                    );
                  }).toList(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
