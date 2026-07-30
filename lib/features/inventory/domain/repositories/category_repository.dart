import '../../../../core/utils/result.dart';
import '../entities/category.dart';

abstract interface class CategoryRepository {
  Future<Result<List<Category>>> getCategories(String storeId);
  Future<Result<Category>> createCategory({required String storeId, required String nombre});
  Future<Result<void>> deleteCategory(String id);
}
