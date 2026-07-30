import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/entities/store.dart';
import '../../domain/repositories/store_repository.dart';
import '../repositories/supabase_store_repository.dart';
import '../../../auth/data/providers/auth_providers.dart';

part 'store_providers.g.dart';

@riverpod
StoreRepository storeRepository(Ref ref) {
  return SupabaseStoreRepository();
}

/// TEMPORAL: usando fetch simple en vez de stream para descartar
/// problemas con .stream() de Supabase. Volveremos a la versión con
/// stream una vez confirmado que el fetch básico funciona.
@riverpod
Future<Store> currentStore(Ref ref) async {
  final authState = await ref.watch(authControllerProvider.future);
  if (authState == null) {
    throw Exception('No hay sesión activa');
  }
  final repo = ref.watch(storeRepositoryProvider);
  final result = await repo.getStore(authState.storeId);
  return result.when(
    success: (store) => store,
    failure: (message) => throw Exception(message),
  );
}
