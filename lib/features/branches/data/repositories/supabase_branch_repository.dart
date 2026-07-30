import '../../../../core/services/supabase_service.dart';
import '../../../../core/utils/result.dart';
import '../../domain/entities/branch.dart';
import '../../domain/repositories/branch_repository.dart';

class SupabaseBranchRepository implements BranchRepository {
  @override
  Future<Result<List<Branch>>> getBranches(String storeId) async {
    try {
      final data = await SupabaseService.client
          .from('sucursales')
          .select()
          .eq('store_id', storeId)
          .order('nombre');
      final branches = (data as List).map((e) => Branch.fromJson(e as Map<String, dynamic>)).toList();
      return Result.success(branches);
    } catch (e) {
      return Result.failure('Error al cargar sucursales: $e');
    }
  }

  @override
  Future<Result<Branch>> createBranch(Branch branch) async {
    try {
      final payload = branch.toJson()..remove('id');
      final data = await SupabaseService.client
          .from('sucursales')
          .insert(payload)
          .select()
          .single();
      return Result.success(Branch.fromJson(data));
    } catch (e) {
      return Result.failure('Error al crear la sucursal: $e');
    }
  }

  @override
  Future<Result<Branch>> toggleActive(String id, bool activa) async {
    try {
      final data = await SupabaseService.client
          .from('sucursales')
          .update({'activa': activa})
          .eq('id', id)
          .select()
          .single();
      return Result.success(Branch.fromJson(data));
    } catch (e) {
      return Result.failure('Error al actualizar la sucursal: $e');
    }
  }
}
