import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/entities/payment.dart';
import '../../domain/repositories/payment_repository.dart';
import '../repositories/supabase_payment_repository.dart';
import 'store_providers.dart';

part 'payment_providers.g.dart';

@riverpod
PaymentRepository paymentRepository(Ref ref) {
  return SupabasePaymentRepository();
}

@riverpod
Future<List<Payment>> paymentHistory(Ref ref) async {
  final store = await ref.watch(currentStoreProvider.future);
  final repo = ref.watch(paymentRepositoryProvider);
  final result = await repo.getPayments(store.id);
  return result.when(success: (data) => data, failure: (msg) => throw Exception(msg));
}
