import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/services/supabase_service.dart';
import '../../../../core/utils/result.dart';
import '../../domain/entities/app_user.dart';
import '../../domain/repositories/auth_repository.dart';

class SupabaseAuthRepository implements AuthRepository {
  SupabaseClient get _client => SupabaseService.client;

  @override
  Future<Result<AppUser>> signIn({required String email, required String password}) async {
    try {
      final res = await _client.auth.signInWithPassword(email: email, password: password);
      if (res.user == null) return const Result.failure('No se pudo iniciar sesión.');
      final profile = await _fetchProfile(res.user!.id);
      return Result.success(profile);
    } on AuthException catch (e) {
      return Result.failure(_mapAuthError(e));
    } catch (e) {
      return Result.failure('Error: $e');
    }
  }

  @override
  Future<Result<AppUser>> signUp({
    required String email,
    required String password,
    required String nombreTienda,
  }) async {
    try {
      final authRes = await _client.auth.signUp(email: email, password: password);
      final userId = authRes.user?.id;
      if (userId == null) return const Result.failure('No se pudo crear la cuenta.');

      // Sección 4.1: crea la tienda con estado_pago = 'prueba' y el
      // perfil de usuario administrador, en una sola llamada RPC atómica.
      await _client.rpc('crear_tienda_y_usuario', params: {
        'p_user_id': userId,
        'p_nombre_tienda': nombreTienda,
        'p_correo': email,
      });

      // Intentamos cargar el perfil. Si falla (e.g. correo sin confirmar
      // con RLS activo), devolvemos un AppUser mínimo para no bloquear
      // la navegación al onboarding.
      AppUser profile;
      try {
        profile = await _fetchProfile(userId);
      } catch (e) {
        debugPrint('⚠️ signUp: _fetchProfile falló después del RPC (probablemente RLS / email sin confirmar): $e');
        profile = AppUser(
          id: userId,
          correo: email,
          storeId: '',
          nombre: email.split('@').first,
          rol: 'administrador',
          activo: true,
        );
      }

      return Result.success(profile);
    } on AuthException catch (e) {
      return Result.failure(_mapAuthError(e));
    } catch (e, st) {
      debugPrint('❌ signUp error: $e\n$st');
      return Result.failure('Error al crear la cuenta: $e');
    }
  }

  @override
  Future<Result<void>> signOut() async {
    try {
      await _client.auth.signOut();
      return const Result.success(null);
    } catch (e) {
      return Result.failure('Error: $e');
    }
  }

  @override
  Future<Result<void>> sendPasswordReset(String email) async {
    try {
      await _client.auth.resetPasswordForEmail(email);
      return const Result.success(null);
    } on AuthException catch (e) {
      return Result.failure(_mapAuthError(e));
    }
  }

  @override
  Future<AppUser?> currentUser() async {
    final session = _client.auth.currentSession;
    if (session == null) return null;
    try {
      return await _fetchProfile(session.user.id);
    } catch (e) {
      debugPrint('⚠️ currentUser: _fetchProfile falló: $e');
      return null;
    }
  }

  Future<AppUser> _fetchProfile(String userId) async {
    final data = await _client.from('usuarios').select().eq('id', userId).single();
    return AppUser.fromJson(data);
  }

  String _mapAuthError(AuthException e) {
    if (e.message.contains('Invalid login credentials')) {
      return 'Correo o contraseña incorrectos.';
    }
    if (e.message.contains('already registered')) {
      return 'Ya existe una cuenta con este correo.';
    }
    return e.message;
  }
}

