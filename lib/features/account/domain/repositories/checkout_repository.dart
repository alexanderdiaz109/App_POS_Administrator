import '../../../../core/utils/result.dart';

abstract interface class CheckoutRepository {
  Future<Result<String>> createCheckoutSession({
    required String storeId,
    required String priceId,
  });

  Future<Result<void>> cancelSubscription(String storeId);
  Future<Result<String>> createPortalSession(String storeId);
  Future<Result<void>> changePlan({required String storeId, required int newPlanId});
}
