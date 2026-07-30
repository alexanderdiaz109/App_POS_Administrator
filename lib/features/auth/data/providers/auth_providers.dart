import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/entities/app_user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../repositories/supabase_auth_repository.dart';

part 'auth_providers.g.dart';

@riverpod
AuthRepository authRepository(Ref ref) {
  return SupabaseAuthRepository();
}

/// Estado de sesión global, expuesto como `AsyncValue<AppUser?>`:
/// - loading mientras carga la sesión inicial
/// - data(null) = no autenticado
/// - data(user) = autenticado
/// - error = algo falló al cargar el perfil
@Riverpod(keepAlive: true)
class AuthController extends _$AuthController {
  @override
  Future<AppUser?> build() async {
    final repo = ref.watch(authRepositoryProvider);
    return repo.currentUser();
  }

  Future<String?> signIn(String email, String password) async {
    final repo = ref.read(authRepositoryProvider);
    state = const AsyncLoading();
    final result = await repo.signIn(email: email, password: password);
    if (!ref.mounted) return null;
    return result.when(
      success: (user) {
        state = AsyncData(user);
        return null;
      },
      failure: (message) {
        state = const AsyncData(null);
        return message;
      },
    );
  }

  Future<String?> signUp(String email, String password, String nombreTienda) async {
    final repo = ref.read(authRepositoryProvider);
    state = const AsyncLoading();
    final result = await repo.signUp(email: email, password: password, nombreTienda: nombreTienda);
    if (!ref.mounted) return null;
    return result.when(
      success: (user) {
        state = AsyncData(user);
        return null;
      },
      failure: (message) {
        state = const AsyncData(null);
        return message;
      },
    );
  }

  Future<void> signOut() async {
    final repo = ref.read(authRepositoryProvider);
    await repo.signOut();
    state = const AsyncData(null);
  }
}
