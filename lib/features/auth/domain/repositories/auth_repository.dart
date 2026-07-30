import '../../../../core/utils/result.dart';
import '../entities/app_user.dart';

abstract interface class AuthRepository {
  Future<Result<AppUser>> signIn({required String email, required String password});
  Future<Result<AppUser>> signUp({
    required String email,
    required String password,
    required String nombreTienda,
  });
  Future<Result<void>> signOut();
  Future<Result<void>> sendPasswordReset(String email);
  Future<AppUser?> currentUser();
}
