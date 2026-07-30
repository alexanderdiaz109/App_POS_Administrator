import 'package:flutter/material.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_text_styles.dart';

class AccountSectionCard extends StatelessWidget {
  final String title;
  final Widget child;
  final Widget? trailing;

  const AccountSectionCard({
    super.key,
    required this.title,
    required this.child,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title, style: AppTextStyles.h3),
                ?trailing,
              ],
            ),
            const SizedBox(height: AppSizes.sm),
            child,
          ],
        ),
      ),
    );
  }
}
