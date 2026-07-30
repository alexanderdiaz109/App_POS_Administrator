// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(authRepository)
final authRepositoryProvider = AuthRepositoryProvider._();

final class AuthRepositoryProvider
    extends $FunctionalProvider<AuthRepository, AuthRepository, AuthRepository>
    with $Provider<AuthRepository> {
  AuthRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authRepositoryHash();

  @$internal
  @override
  $ProviderElement<AuthRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AuthRepository create(Ref ref) {
    return authRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AuthRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AuthRepository>(value),
    );
  }
}

String _$authRepositoryHash() => r'441b94f208778134226f4c69971f75fec1f333a4';

/// Estado de sesión global, expuesto como `AsyncValue<AppUser?>`:
/// - loading mientras carga la sesión inicial
/// - data(null) = no autenticado
/// - data(user) = autenticado
/// - error = algo falló al cargar el perfil

@ProviderFor(AuthController)
final authControllerProvider = AuthControllerProvider._();

/// Estado de sesión global, expuesto como `AsyncValue<AppUser?>`:
/// - loading mientras carga la sesión inicial
/// - data(null) = no autenticado
/// - data(user) = autenticado
/// - error = algo falló al cargar el perfil
final class AuthControllerProvider
    extends $AsyncNotifierProvider<AuthController, AppUser?> {
  /// Estado de sesión global, expuesto como `AsyncValue<AppUser?>`:
  /// - loading mientras carga la sesión inicial
  /// - data(null) = no autenticado
  /// - data(user) = autenticado
  /// - error = algo falló al cargar el perfil
  AuthControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authControllerHash();

  @$internal
  @override
  AuthController create() => AuthController();
}

String _$authControllerHash() => r'1596f686285b6e83ef717ce8fd53ee603248788e';

/// Estado de sesión global, expuesto como `AsyncValue<AppUser?>`:
/// - loading mientras carga la sesión inicial
/// - data(null) = no autenticado
/// - data(user) = autenticado
/// - error = algo falló al cargar el perfil

abstract class _$AuthController extends $AsyncNotifier<AppUser?> {
  FutureOr<AppUser?> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<AppUser?>, AppUser?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<AppUser?>, AppUser?>,
              AsyncValue<AppUser?>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
