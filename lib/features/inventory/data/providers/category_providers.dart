import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/entities/category.dart';
import '../../domain/repositories/category_repository.dart';
import '../repositories/supabase_category_repository.dart';
import '../../../account/data/providers/store_providers.dart';

part 'category_providers.g.dart';

@riverpod
CategoryRepository categoryRepository(Ref ref) {
  return SupabaseCategoryRepository();
}

@riverpod
class CategoryListController extends _$CategoryListController {
  @override
  Future<List<Category>> build() async {
    final store = await ref.watch(currentStoreProvider.future);
    final repo = ref.watch(categoryRepositoryProvider);
    final result = await repo.getCategories(store.id);
    return result.when(success: (data) => data, failure: (msg) => throw Exception(msg));
  }

  Future<String?> addCategory(String nombre) async {
    final store = await ref.read(currentStoreProvider.future);
    final repo = ref.read(categoryRepositoryProvider);
    final result = await repo.createCategory(storeId: store.id, nombre: nombre);
    return result.when(
      success: (_) {
        ref.invalidateSelf();
        return null;
      },
      failure: (msg) => msg,
    );
  }

  Future<String?> removeCategory(String id) async {
    final repo = ref.read(categoryRepositoryProvider);
    final result = await repo.deleteCategory(id);
    return result.when(
      success: (_) {
        ref.invalidateSelf();
        return null;
      },
      failure: (msg) => msg,
    );
  }
}
