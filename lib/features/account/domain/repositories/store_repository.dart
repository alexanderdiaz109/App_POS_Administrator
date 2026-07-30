import '../../../../core/utils/result.dart';
import '../entities/store.dart';

abstract interface class StoreRepository {
  Future<Result<Store>> getStore(String storeId);
  Stream<Store> watchStore(String storeId);
}
