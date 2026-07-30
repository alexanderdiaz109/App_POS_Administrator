import '../../../../core/utils/result.dart';
import '../entities/product.dart';

abstract interface class ProductRepository {
  Future<Result<List<Product>>> getProducts(String storeId);
  Future<Result<Product>> getProduct(String id);
  Future<Result<Product>> createProduct(Product product);
  Future<Result<Product>> updateProduct(Product product);
  Future<Result<void>> deleteProduct(String id);
  Future<Result<void>> adjustStock({required String productId, required int delta});
}
