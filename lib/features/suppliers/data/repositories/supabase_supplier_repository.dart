import '../../../../core/services/supabase_service.dart';
import '../../../../core/utils/result.dart';
import '../../domain/entities/supplier.dart';
import '../../domain/entities/purchase_order.dart';
import '../../domain/repositories/supplier_repository.dart';

class SupabaseSupplierRepository implements SupplierRepository {
  @override
  Future<Result<List<Supplier>>> getSuppliers(String storeId) async {
    try {
      final data = await SupabaseService.client
          .from('proveedores')
          .select()
          .eq('store_id', storeId)
          .order('nombre');
      final suppliers = (data as List).map((e) => Supplier.fromJson(e)).toList();
      return Result.success(suppliers);
    } catch (e) {
      return Result.failure('Error al cargar proveedores: $e');
    }
  }

  @override
  Future<Result<Supplier>> getSupplier(String id) async {
    try {
      final data = await SupabaseService.client.from('proveedores').select().eq('id', id).single();
      return Result.success(Supplier.fromJson(data));
    } catch (e) {
      return Result.failure('Error al cargar el proveedor: $e');
    }
  }

  @override
  Future<Result<Supplier>> createSupplier(Supplier supplier) async {
    try {
      final payload = supplier.toJson()..remove('id');
      final data = await SupabaseService.client.from('proveedores').insert(payload).select().single();
      return Result.success(Supplier.fromJson(data));
    } catch (e) {
      return Result.failure('Error al crear el proveedor: $e');
    }
  }

  @override
  Future<Result<List<PurchaseOrder>>> getOrdersForSupplier(String supplierId) async {
    try {
      final data = await SupabaseService.client
          .from('ordenes_compra')
          .select()
          .eq('proveedor_id', supplierId)
          .order('creado_en', ascending: false);
      final orders = (data as List).map((e) => PurchaseOrder.fromJson(e)).toList();
      return Result.success(orders);
    } catch (e) {
      return Result.failure('Error al cargar órdenes de compra: $e');
    }
  }

  @override
  Future<Result<Map<String, dynamic>>> createOrder({
    required String storeId,
    required String proveedorId,
    required double total,
  }) async {
    try {
      final data = await SupabaseService.client.rpc('crear_orden_compra', params: {
        'p_store_id': storeId,
        'p_proveedor_id': proveedorId,
        'p_total': total,
      });
      return Result.success(data as Map<String, dynamic>);
    } catch (e) {
      return Result.failure('Error al crear la orden: $e');
    }
  }

  @override
  Future<Result<void>> markOrderReceived(String orderId) async {
    try {
      await SupabaseService.client.from('ordenes_compra').update({'estado': 'recibida'}).eq('id', orderId);
      return const Result.success(null);
    } catch (e) {
      return Result.failure('Error al actualizar la orden: $e');
    }
  }
}
