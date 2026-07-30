import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/entities/sale_result.dart';
import '../../domain/entities/sale_detail.dart';
import '../../domain/repositories/sale_repository.dart';
import '../repositories/supabase_sale_repository.dart';
import 'cart_providers.dart';
import '../../../account/data/providers/store_providers.dart';
import '../../../auth/data/providers/auth_providers.dart';
import '../../../cash_register/data/providers/cash_register_providers.dart';
import '../../../products/data/providers/product_providers.dart';
import '../../../reports/data/providers/reports_providers.dart';
import '../../../receipts/data/services/receipt_pdf_service.dart';

part 'sale_providers.g.dart';

@riverpod
SaleRepository saleRepository(Ref ref) {
  return SupabaseSaleRepository();
}

@Riverpod(keepAlive: true)
class SaleController extends _$SaleController {
  @override
  FutureOr<void> build() {}

  /// Confirma la venta con el carrito actual. Al éxito, limpia el
  /// carrito y refresca la lista de productos (para reflejar el stock
  /// nuevo). Regresa el SaleResult o null si falló (el error queda en
  /// el estado del provider como AsyncError).
  Future<SaleResult?> confirmSale(String metodoPago) async {
    state = const AsyncLoading();

    try {
      final store = await ref.read(currentStoreProvider.future);
      final user = await ref.read(authControllerProvider.future);
      final items = ref.read(cartControllerProvider);
      final repo = ref.read(saleRepositoryProvider);

      if (user == null) {
        state = AsyncError('No hay sesión activa', StackTrace.current);
        return null;
      }
      if (items.isEmpty) {
        state = AsyncError('El carrito está vacío', StackTrace.current);
        return null;
      }

      final result = await repo.createSale(
        storeId: store.id,
        usuarioId: user.id,
        metodoPago: metodoPago,
        items: items,
      );

      return result.when(
        success: (saleResult) {
          ref.read(cartControllerProvider.notifier).clear();
          ref.invalidate(productListControllerProvider);
          ref.invalidate(cashSummaryTodayProvider);
          ref.invalidate(cashSummaryWeekProvider);
          ref.invalidate(topProductsThisMonthProvider);
          state = const AsyncData(null);
          return saleResult;
        },
        failure: (message) {
          state = AsyncError(message, StackTrace.current);
          return null;
        },
      );
    } catch (e, st) {
      state = AsyncError('Error inesperado: $e', st);
      return null;
    }
  }
}

@riverpod
Future<SaleDetail> saleDetail(Ref ref, String saleId) async {
  final repo = ref.watch(saleRepositoryProvider);
  final result = await repo.getSaleDetail(saleId);
  return result.when(success: (data) => data, failure: (msg) => throw Exception(msg));
}

@riverpod
ReceiptPdfService receiptPdfService(Ref ref) => ReceiptPdfService();
