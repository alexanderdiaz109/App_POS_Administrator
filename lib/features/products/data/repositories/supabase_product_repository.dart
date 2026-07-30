import '../../../../core/services/supabase_service.dart';
import '../../../../core/utils/result.dart';
import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';

class SupabaseProductRepository implements ProductRepository {
  @override
  Future<Result<List<Product>>> getProducts(String storeId) async {
    try {
      final data = await SupabaseService.client
          .from('productos')
          .select()
          .eq('store_id', storeId)
          .order('nombre');
      final products = (data as List).map((e) => Product.fromJson(e)).toList();
      return Result.success(products);
    } catch (e) {
      return Result.failure('Error al cargar productos: $e');
    }
  }

  @override
  Future<Result<Product>> getProduct(String id) async {
    try {
      final data = await SupabaseService.client.from('productos').select().eq('id', id).single();
      return Result.success(Product.fromJson(data));
    } catch (e) {
      return Result.failure('Error al cargar el producto: $e');
    }
  }

  @override
  Future<Result<Product>> createProduct(Product product) async {
    try {
      final payload = product.toJson()..remove('id');
      final data = await SupabaseService.client.from('productos').insert(payload).select().single();
      return Result.success(Product.fromJson(data));
    } catch (e) {
      return Result.failure('Error al crear el producto: $e');
    }
  }

  @override
  Future<Result<Product>> updateProduct(Product product) async {
    try {
      final payload = product.toJson()..remove('id')..remove('store_id');
      final data = await SupabaseService.client
          .from('productos')
          .update(payload)
          .eq('id', product.id)
          .select()
          .single();
      return Result.success(Product.fromJson(data));
    } catch (e) {
      return Result.failure('Error al actualizar el producto: $e');
    }
  }

  @override
  Future<Result<void>> deleteProduct(String id) async {
    try {
      await SupabaseService.client.from('productos').delete().eq('id', id);
      return const Result.success(null);
    } catch (e) {
      return Result.failure('Error al eliminar el producto: $e');
    }
  }

  @override
  Future<Result<void>> adjustStock({required String productId, required int delta}) async {
    try {
      // RPC atómica: evita condiciones de carrera si dos ventas
      // descuentan stock del mismo producto casi al mismo tiempo.
      await SupabaseService.client.rpc('ajustar_stock', params: {
        'p_producto_id': productId,
        'p_delta': delta,
      });
      return const Result.success(null);
    } catch (e) {
      return Result.failure('Error al ajustar el stock: $e');
    }
  }
}
