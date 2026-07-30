import '../../../../core/utils/result.dart';
import '../entities/supplier.dart';
import '../entities/purchase_order.dart';

abstract interface class SupplierRepository {
  Future<Result<List<Supplier>>> getSuppliers(String storeId);
  Future<Result<Supplier>> getSupplier(String id);
  Future<Result<Supplier>> createSupplier(Supplier supplier);
  Future<Result<List<PurchaseOrder>>> getOrdersForSupplier(String supplierId);
  Future<Result<Map<String, dynamic>>> createOrder({
    required String storeId,
    required String proveedorId,
    required double total,
  });
  Future<Result<void>> markOrderReceived(String orderId);
}
