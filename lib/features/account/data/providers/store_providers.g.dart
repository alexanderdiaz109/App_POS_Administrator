// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(storeRepository)
final storeRepositoryProvider = StoreRepositoryProvider._();

final class StoreRepositoryProvider
    extends
        $FunctionalProvider<StoreRepository, StoreRepository, StoreRepository>
    with $Provider<StoreRepository> {
  StoreRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'storeRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$storeRepositoryHash();

  @$internal
  @override
  $ProviderElement<StoreRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  StoreRepository create(Ref ref) {
    return storeRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(StoreRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<StoreRepository>(value),
    );
  }
}

String _$storeRepositoryHash() => r'00b68baec31af732975acfe40cbaf37f9b245d1c';

/// TEMPORAL: usando fetch simple en vez de stream para descartar
/// problemas con .stream() de Supabase. Volveremos a la versión con
/// stream una vez confirmado que el fetch básico funciona.

@ProviderFor(currentStore)
final currentStoreProvider = CurrentStoreProvider._();

/// TEMPORAL: usando fetch simple en vez de stream para descartar
/// problemas con .stream() de Supabase. Volveremos a la versión con
/// stream una vez confirmado que el fetch básico funciona.

final class CurrentStoreProvider
    extends $FunctionalProvider<AsyncValue<Store>, Store, FutureOr<Store>>
    with $FutureModifier<Store>, $FutureProvider<Store> {
  /// TEMPORAL: usando fetch simple en vez de stream para descartar
  /// problemas con .stream() de Supabase. Volveremos a la versión con
  /// stream una vez confirmado que el fetch básico funciona.
  CurrentStoreProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'currentStoreProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$currentStoreHash();

  @$internal
  @override
  $FutureProviderElement<Store> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Store> create(Ref ref) {
    return currentStore(ref);
  }
}

String _$currentStoreHash() => r'77498e3f8fc07c925439a3ec4abd91b6e8208e05';
