import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/entities/supplier.dart';
import '../../domain/entities/purchase_order.dart';
import '../../domain/repositories/supplier_repository.dart';
import '../repositories/supabase_supplier_repository.dart';
import '../../../account/data/providers/store_providers.dart';

part 'supplier_providers.g.dart';

@riverpod
SupplierRepository supplierRepository(Ref ref) {
  return SupabaseSupplierRepository();
}

@riverpod
class SupplierListController extends _$SupplierListController {
  @override
  Future<List<Supplier>> build() async {
    final store = await ref.watch(currentStoreProvider.future);
    final repo = ref.watch(supplierRepositoryProvider);
    final result = await repo.getSuppliers(store.id);
    return result.when(success: (data) => data, failure: (msg) => throw Exception(msg));
  }

  Future<String?> addSupplier({
    required String nombre,
    String? categoria,
    String? telefono,
    String? correo,
    String? notas,
  }) async {
    final store = await ref.read(currentStoreProvider.future);
    final repo = ref.read(supplierRepositoryProvider);
    final result = await repo.createSupplier(Supplier(
      id: '',
      storeId: store.id,
      nombre: nombre,
      categoria: categoria,
      telefono: telefono,
      correo: correo,
      notas: notas,
    ));
    return result.when(
      success: (_) {
        ref.invalidateSelf();
        return null;
      },
      failure: (msg) => msg,
    );
  }
}

@riverpod
Future<Supplier> supplierDetail(Ref ref, String supplierId) async {
  final repo = ref.watch(supplierRepositoryProvider);
  final result = await repo.getSupplier(supplierId);
  return result.when(success: (data) => data, failure: (msg) => throw Exception(msg));
}

@riverpod
class SupplierOrdersController extends _$SupplierOrdersController {
  @override
  Future<List<PurchaseOrder>> build(String supplierId) async {
    final repo = ref.watch(supplierRepositoryProvider);
    final result = await repo.getOrdersForSupplier(supplierId);
    return result.when(success: (data) => data, failure: (msg) => throw Exception(msg));
  }

  Future<String?> createOrder(double total) async {
    final store = await ref.read(currentStoreProvider.future);
    final repo = ref.read(supplierRepositoryProvider);
    final result = await repo.createOrder(storeId: store.id, proveedorId: supplierId, total: total);
    return result.when(
      success: (_) {
        ref.invalidateSelf();
        return null;
      },
      failure: (msg) => msg,
    );
  }

  Future<String?> markReceived(String orderId) async {
    final repo = ref.read(supplierRepositoryProvider);
    final result = await repo.markOrderReceived(orderId);
    return result.when(
      success: (_) {
        ref.invalidateSelf();
        return null;
      },
      failure: (msg) => msg,
    );
  }
}
