import '../../../../core/services/supabase_service.dart';
import '../../../../core/utils/result.dart';
import '../../domain/entities/team_member.dart';
import '../../domain/entities/audit_entry.dart';
import '../../domain/repositories/team_repository.dart';

class SupabaseTeamRepository implements TeamRepository {
  @override
  Future<Result<List<TeamMember>>> getTeamMembers(String storeId) async {
    try {
      final data = await SupabaseService.client
          .from('usuarios')
          .select()
          .eq('store_id', storeId)
          .order('nombre');
      final members = (data as List).map((e) => TeamMember.fromJson(e)).toList();
      return Result.success(members);
    } catch (e) {
      return Result.failure('Error al cargar el equipo: $e');
    }
  }

  @override
  Future<Result<void>> toggleActive(String userId, bool activo) async {
    try {
      await SupabaseService.client.from('usuarios').update({'activo': activo}).eq('id', userId);
      return const Result.success(null);
    } catch (e) {
      return Result.failure('Error al actualizar el usuario: $e');
    }
  }

  @override
  Future<Result<void>> updateRole(String userId, String rol) async {
    try {
      await SupabaseService.client.from('usuarios').update({'rol': rol}).eq('id', userId);
      return const Result.success(null);
    } catch (e) {
      return Result.failure('Error al actualizar el rol: $e');
    }
  }

  @override
  Future<Result<List<AuditEntry>>> getAuditLog(String storeId) async {
    try {
      final data = await SupabaseService.client
          .from('auditoria')
          .select('id, accion, tipo, creado_en, usuarios(nombre)')
          .eq('store_id', storeId)
          .order('creado_en', ascending: false)
          .limit(50);

      final entries = (data as List).map((row) {
        return AuditEntry(
          id: row['id'] as String,
          usuarioNombre: (row['usuarios'] as Map?)?['nombre'] as String? ?? 'Usuario eliminado',
          accion: row['accion'] as String,
          tipo: row['tipo'] as String,
          fecha: DateTime.parse(row['creado_en'] as String),
        );
      }).toList();

      return Result.success(entries);
    } catch (e) {
      return Result.failure('Error al cargar la auditoría: $e');
    }
  }

  @override
  Future<Result<void>> logAction({
    required String storeId,
    required String usuarioId,
    required String accion,
    String tipo = 'normal',
  }) async {
    try {
      await SupabaseService.client.from('auditoria').insert({
        'store_id': storeId,
        'usuario_id': usuarioId,
        'accion': accion,
        'tipo': tipo,
      });
      return const Result.success(null);
    } catch (e) {
      return Result.failure('Error al registrar auditoría: $e');
    }
  }
}
