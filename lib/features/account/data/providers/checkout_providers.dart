import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/repositories/checkout_repository.dart';
import '../repositories/supabase_checkout_repository.dart';

part 'checkout_providers.g.dart';

@riverpod
CheckoutRepository checkoutRepository(Ref ref) {
  return SupabaseCheckoutRepository();
}
