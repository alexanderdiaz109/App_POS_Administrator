import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/widgets/empty_state.dart';
import '../../../../core/widgets/error_state.dart';
import '../../data/providers/team_providers.dart';

class AuditLogScreen extends ConsumerWidget {
  const AuditLogScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final logAsync = ref.watch(auditLogProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Auditoría')),
      body: logAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => ErrorState(message: '$err', onRetry: () => ref.invalidate(auditLogProvider)),
        data: (entries) => entries.isEmpty
            ? const EmptyState(icon: Icons.history, title: 'Sin actividad registrada')
            : ListView.separated(
                padding: const EdgeInsets.all(AppSizes.md),
                itemCount: entries.length,
                separatorBuilder: (_, __) => const Divider(height: 1),
                itemBuilder: (context, i) {
                  final e = entries[i];
                  final critico = e.tipo == 'critico';
                  return ListTile(
                    leading: Icon(
                      critico ? Icons.report_gmailerrorred_outlined : Icons.check_circle_outline,
                      color: critico ? AppColors.warning : AppColors.textSecondary,
                    ),
                    title: Text(e.accion, style: AppTextStyles.body),
                    subtitle: Text(
                      '${e.usuarioNombre} · ${e.fecha.day}/${e.fecha.month} ${e.fecha.hour.toString().padLeft(2, '0')}:${e.fecha.minute.toString().padLeft(2, '0')}',
                      style: AppTextStyles.bodySecondary,
                    ),
                  );
                },
              ),
      ),
    );
  }
}
