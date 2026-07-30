import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/services/supabase_service.dart';
import '../../../../core/utils/result.dart';
import '../../domain/repositories/checkout_repository.dart';

class SupabaseCheckoutRepository implements CheckoutRepository {
  @override
  Future<Result<String>> createCheckoutSession({
    required String storeId,
    required String priceId,
  }) async {
    try {
      final response = await SupabaseService.client.functions.invoke(
        'create-checkout-session',
        body: {'storeId': storeId, 'priceId': priceId},
      );

      final data = response.data as Map<String, dynamic>;

      if (data['error'] != null) {
        return Result.failure(data['error'] as String);
      }

      final url = data['url'] as String?;
      if (url == null) {
        return const Result.failure('No se recibió una URL de pago válida.');
      }

      return Result.success(url);
    } catch (e) {
      return Result.failure('Error al generar el pago: $e');
    }
  }

  @override
  Future<Result<void>> cancelSubscription(String storeId) async {
    try {
      final response = await SupabaseService.client.functions.invoke(
        'cancel-subscription',
        body: {'storeId': storeId},
      );

      final data = response.data as Map<String, dynamic>;
      if (data['error'] != null) {
        return Result.failure(data['error'] as String);
      }
      return const Result.success(null);
    } catch (e) {
      return Result.failure('Error al cancelar la suscripción: $e');
    }
  }

  @override
  Future<Result<String>> createPortalSession(String storeId) async {
    try {
      final response = await SupabaseService.client.functions.invoke(
        'create-portal-session',
        body: {'storeId': storeId},
      );

      final data = response.data as Map<String, dynamic>;
      if (data['error'] != null) {
        return Result.failure(data['error'] as String);
      }

      final url = data['url'] as String?;
      if (url == null) {
        return const Result.failure('No se recibió una URL de portal válida.');
      }
      return Result.success(url);
    } catch (e) {
      return Result.failure('Error al abrir el portal de pago: $e');
    }
  }

  @override
  Future<Result<void>> changePlan({required String storeId, required int newPlanId}) async {
    try {
      final response = await SupabaseService.client.functions.invoke(
        'change-plan',
        body: {'storeId': storeId, 'newPlanId': newPlanId},
      );

      final data = response.data as Map<String, dynamic>?;

      if (data != null && data['error'] == 'downgrade_blocked') {
        final limites = (data['limites'] as List).map((e) => e.toString()).join('||');
        return Result.failure('downgrade_blocked::$limites');
      }

      if (data != null && data['error'] != null) {
        return Result.failure(data['error'] as String);
      }

      return const Result.success(null);
    } on FunctionException catch (e) {
      // El SDK lanza esta excepción cuando la función responde con un
      // status distinto de 2xx (ej. 422 para downgrade bloqueado). El
      // cuerpo real de la respuesta viene en e.details, no en e.message.
      final details = e.details;
      if (details is Map && details['error'] == 'downgrade_blocked') {
        final limites = (details['limites'] as List).map((x) => x.toString()).join('||');
        return Result.failure('downgrade_blocked::$limites');
      }
      if (details is Map && details['error'] != null) {
        return Result.failure(details['error'] as String);
      }
      return Result.failure('Error al cambiar de plan: ${e.details ?? e.toString()}');
    } catch (e) {
      return Result.failure('Error al cambiar de plan: $e');
    }
  }
}
