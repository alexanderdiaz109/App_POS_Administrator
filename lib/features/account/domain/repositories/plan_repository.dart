import '../../../../core/utils/result.dart';
import '../entities/plan.dart';

abstract interface class PlanRepository {
  Future<Result<List<Plan>>> getPlans();
}
