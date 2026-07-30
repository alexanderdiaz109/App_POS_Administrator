import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/constants/plan_limits.dart';
import 'store_providers.dart';

part 'plan_features_provider.g.dart';

@riverpod
Future<PlanFeatures> currentPlanFeatures(Ref ref) async {
  final store = await ref.watch(currentStoreProvider.future);
  return PlanFeatures.forPlan(store.nivelPlan.toPlanLevel());
}
