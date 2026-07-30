import '../../../../core/services/supabase_service.dart';
import '../../../../core/utils/result.dart';
import '../../domain/entities/store.dart';
import '../../domain/repositories/store_repository.dart';

class SupabaseStoreRepository implements StoreRepository {
  @override
  Future<Result<Store>> getStore(String storeId) async {
    try {
      final data = await SupabaseService.client
          .from('tiendas')
          .select()
          .eq('id', storeId)
          .single();
      return Result.success(Store.fromJson(data));
    } catch (e) {
      return Result.failure('Error al cargar la tienda: $e');
    }
  }

  @override
  Stream<Store> watchStore(String storeId) {
    // Supabase puede emitir un primer evento vacío antes del snapshot
    // real — lo filtramos para no tronar con rows.first en una lista vacía.
    return SupabaseService.client
        .from('tiendas')
        .stream(primaryKey: ['id'])
        .eq('id', storeId)
        .where((rows) => rows.isNotEmpty)
        .map((rows) => Store.fromJson(rows.first));
  }
}
