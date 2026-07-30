import '../../../../core/services/supabase_service.dart';
import '../../../../core/utils/result.dart';
import '../../domain/entities/payment.dart';
import '../../domain/repositories/payment_repository.dart';

class SupabasePaymentRepository implements PaymentRepository {
  @override
  Future<Result<List<Payment>>> getPayments(String storeId) async {
    try {
      final data = await SupabaseService.client
          .from('pagos')
          .select()
          .eq('store_id', storeId)
          .order('fecha', ascending: false);
      final payments = (data as List).map((e) => Payment.fromJson(e)).toList();
      return Result.success(payments);
    } catch (e) {
      return Result.failure('Error al cargar el historial de pagos: $e');
    }
  }
}
