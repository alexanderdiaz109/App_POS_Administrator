import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/entities/plan.dart';
import '../../domain/repositories/plan_repository.dart';
import '../repositories/supabase_plan_repository.dart';

part 'plan_providers.g.dart';

@riverpod
PlanRepository planRepository(Ref ref) {
  return SupabasePlanRepository();
}

@riverpod
Future<List<Plan>> availablePlans(Ref ref) async {
  final repo = ref.watch(planRepositoryProvider);
  final result = await repo.getPlans();
  return result.when(success: (data) => data, failure: (msg) => throw Exception(msg));
}
