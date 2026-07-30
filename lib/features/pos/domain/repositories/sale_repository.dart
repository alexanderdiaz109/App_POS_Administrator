import '../../../../core/utils/result.dart';
import '../entities/cart_item.dart';
import '../entities/sale_result.dart';
import '../entities/sale_detail.dart';

abstract interface class SaleRepository {
  Future<Result<SaleResult>> createSale({
    required String storeId,
    required String usuarioId,
    required String metodoPago,
    required List<CartItem> items,
  });

  Future<Result<SaleDetail>> getSaleDetail(String saleId);
}
