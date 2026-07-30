import '../../../../core/services/supabase_service.dart';
import '../../../../core/utils/result.dart';
import '../../domain/entities/plan.dart';
import '../../domain/repositories/plan_repository.dart';

class SupabasePlanRepository implements PlanRepository {
  @override
  Future<Result<List<Plan>>> getPlans() async {
    try {
      final data = await SupabaseService.client
          .from('planes')
          .select()
          .eq('activo', true)
          .order('id');
      final plans = (data as List).map((e) => Plan.fromJson(e)).toList();
      return Result.success(plans);
    } catch (e) {
      return Result.failure('Error al cargar los planes: $e');
    }
  }
}
