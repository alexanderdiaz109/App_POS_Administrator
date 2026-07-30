import '../../../../core/utils/result.dart';
import '../entities/team_member.dart';
import '../entities/audit_entry.dart';

abstract interface class TeamRepository {
  Future<Result<List<TeamMember>>> getTeamMembers(String storeId);
  Future<Result<void>> toggleActive(String userId, bool activo);
  Future<Result<void>> updateRole(String userId, String rol);
  Future<Result<List<AuditEntry>>> getAuditLog(String storeId);
  Future<Result<void>> logAction({
    required String storeId,
    required String usuarioId,
    required String accion,
    String tipo,
  });
}
