import '../../../../core/utils/result.dart';
import '../entities/payment.dart';

abstract interface class PaymentRepository {
  Future<Result<List<Payment>>> getPayments(String storeId);
}
