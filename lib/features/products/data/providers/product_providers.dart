import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';
import '../repositories/supabase_product_repository.dart';
import '../../../account/data/providers/store_providers.dart';

part 'product_providers.g.dart';

@riverpod
ProductRepository productRepository(Ref ref) {
  return SupabaseProductRepository();
}

@riverpod
class ProductListController extends _$ProductListController {
  @override
  Future<List<Product>> build() async {
    final store = await ref.watch(currentStoreProvider.future);
    final repo = ref.watch(productRepositoryProvider);
    final result = await repo.getProducts(store.id);
    return result.when(success: (data) => data, failure: (msg) => throw Exception(msg));
  }

  Future<String?> addProduct(Product product) async {
    final repo = ref.read(productRepositoryProvider);
    final result = await repo.createProduct(product);
    return result.when(
      success: (_) {
        ref.invalidateSelf();
        return null;
      },
      failure: (msg) => msg,
    );
  }

  Future<String?> editProduct(Product product) async {
    final repo = ref.read(productRepositoryProvider);
    final result = await repo.updateProduct(product);
    return result.when(
      success: (_) {
        ref.invalidateSelf();
        return null;
      },
      failure: (msg) => msg,
    );
  }

  Future<String?> removeProduct(String id) async {
    final repo = ref.read(productRepositoryProvider);
    final result = await repo.deleteProduct(id);
    return result.when(
      success: (_) {
        ref.invalidateSelf();
        return null;
      },
      failure: (msg) => msg,
    );
  }
}

/// Detalle de un solo producto, usado en ProductDetailScreen.
@riverpod
Future<Product> productDetail(Ref ref, String productId) async {
  final repo = ref.watch(productRepositoryProvider);
  final result = await repo.getProduct(productId);
  return result.when(success: (data) => data, failure: (msg) => throw Exception(msg));
}
