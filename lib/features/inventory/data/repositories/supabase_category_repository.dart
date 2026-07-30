import '../../../../core/services/supabase_service.dart';
import '../../../../core/utils/result.dart';
import '../../domain/entities/category.dart';
import '../../domain/repositories/category_repository.dart';

class SupabaseCategoryRepository implements CategoryRepository {
  @override
  Future<Result<List<Category>>> getCategories(String storeId) async {
    try {
      final data = await SupabaseService.client
          .from('categorias')
          .select()
          .eq('store_id', storeId)
          .order('nombre');
      final categories = (data as List).map((e) => Category.fromJson(e)).toList();
      return Result.success(categories);
    } catch (e) {
      return Result.failure('Error al cargar categorías: $e');
    }
  }

  @override
  Future<Result<Category>> createCategory({required String storeId, required String nombre}) async {
    try {
      final data = await SupabaseService.client
          .from('categorias')
          .insert({'store_id': storeId, 'nombre': nombre})
          .select()
          .single();
      return Result.success(Category.fromJson(data));
    } catch (e) {
      return Result.failure('Error al crear categoría: $e');
    }
  }

  @override
  Future<Result<void>> deleteCategory(String id) async {
    try {
      await SupabaseService.client.from('categorias').delete().eq('id', id);
      return const Result.success(null);
    } catch (e) {
      return Result.failure('Error al eliminar categoría: $e');
    }
  }
}
