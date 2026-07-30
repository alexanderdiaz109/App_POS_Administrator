import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/services/supabase_service.dart';
import '../../domain/entities/team_member.dart';
import '../../domain/entities/audit_entry.dart';
import '../../domain/repositories/team_repository.dart';
import '../repositories/supabase_team_repository.dart';
import '../../../account/data/providers/store_providers.dart';
import '../../../../core/utils/result.dart';

part 'team_providers.g.dart';

@riverpod
TeamRepository teamRepository(Ref ref) {
  return SupabaseTeamRepository();
}

@riverpod
class TeamListController extends _$TeamListController {
  @override
  Future<List<TeamMember>> build() async {
    final store = await ref.watch(currentStoreProvider.future);
    final repo = ref.watch(teamRepositoryProvider);
    final result = await repo.getTeamMembers(store.id);
    return result.when(success: (data) => data, failure: (msg) => throw Exception(msg));
  }

  Future<String?> linkUserByEmail({required String correo, required String rol}) async {
    final store = await ref.read(currentStoreProvider.future);
    try {
      final data = await SupabaseService.client.rpc('vincular_usuario_a_tienda', params: {
        'p_correo': correo,
        'p_store_id': store.id,
        'p_rol': rol,
      });
      final nombre = (data as Map<String, dynamic>)['nombre'] as String;

      final repo = ref.read(teamRepositoryProvider);
      await repo.logAction(
        storeId: store.id,
        usuarioId: SupabaseService.client.auth.currentUser!.id, // TODO: usar el id del admin actual cuando esté disponible aquí
        accion: 'Agregó a $nombre como $rol',
        tipo: 'critico',
      );

      ref.invalidateSelf();
      return null;
    } catch (e) {
      return 'Error: $e';
    }
  }

  Future<String?> toggleActive(String userId, bool activo) async {
    final repo = ref.read(teamRepositoryProvider);
    final result = await repo.toggleActive(userId, activo);
    return result.when(
      success: (_) {
        ref.invalidateSelf();
        return null;
      },
      failure: (msg) => msg,
    );
  }

  Future<String?> updateRole(String userId, String rol) async {
    final repo = ref.read(teamRepositoryProvider);
    final result = await repo.updateRole(userId, rol);
    return result.when(
      success: (_) {
        ref.invalidateSelf();
        return null;
      },
      failure: (msg) => msg,
    );
  }
}

@riverpod
Future<List<AuditEntry>> auditLog(Ref ref) async {
  final store = await ref.watch(currentStoreProvider.future);
  final repo = ref.watch(teamRepositoryProvider);
  final result = await repo.getAuditLog(store.id);
  return result.when(success: (data) => data, failure: (msg) => throw Exception(msg));
}
