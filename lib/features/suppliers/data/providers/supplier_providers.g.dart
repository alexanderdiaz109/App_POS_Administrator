// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'supplier_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(supplierRepository)
final supplierRepositoryProvider = SupplierRepositoryProvider._();

final class SupplierRepositoryProvider
    extends
        $FunctionalProvider<
          SupplierRepository,
          SupplierRepository,
          SupplierRepository
        >
    with $Provider<SupplierRepository> {
  SupplierRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'supplierRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$supplierRepositoryHash();

  @$internal
  @override
  $ProviderElement<SupplierRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SupplierRepository create(Ref ref) {
    return supplierRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SupplierRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SupplierRepository>(value),
    );
  }
}

String _$supplierRepositoryHash() =>
    r'8380da20b7e580407a5d80494223a69227905dd0';

@ProviderFor(SupplierListController)
final supplierListControllerProvider = SupplierListControllerProvider._();

final class SupplierListControllerProvider
    extends $AsyncNotifierProvider<SupplierListController, List<Supplier>> {
  SupplierListControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'supplierListControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$supplierListControllerHash();

  @$internal
  @override
  SupplierListController create() => SupplierListController();
}

String _$supplierListControllerHash() =>
    r'd14ead3c859b2d72fc03b320badc201f8a16d1a6';

abstract class _$SupplierListController extends $AsyncNotifier<List<Supplier>> {
  FutureOr<List<Supplier>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<Supplier>>, List<Supplier>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Supplier>>, List<Supplier>>,
              AsyncValue<List<Supplier>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

@ProviderFor(supplierDetail)
final supplierDetailProvider = SupplierDetailFamily._();

final class SupplierDetailProvider
    extends
        $FunctionalProvider<AsyncValue<Supplier>, Supplier, FutureOr<Supplier>>
    with $FutureModifier<Supplier>, $FutureProvider<Supplier> {
  SupplierDetailProvider._({
    required SupplierDetailFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'supplierDetailProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$supplierDetailHash();

  @override
  String toString() {
    return r'supplierDetailProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<Supplier> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Supplier> create(Ref ref) {
    final argument = this.argument as String;
    return supplierDetail(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is SupplierDetailProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$supplierDetailHash() => r'f6f6f1fed4d67228ecd01453a50b8aa98e0899f1';

final class SupplierDetailFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<Supplier>, String> {
  SupplierDetailFamily._()
    : super(
        retry: null,
        name: r'supplierDetailProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  SupplierDetailProvider call(String supplierId) =>
      SupplierDetailProvider._(argument: supplierId, from: this);

  @override
  String toString() => r'supplierDetailProvider';
}

@ProviderFor(SupplierOrdersController)
final supplierOrdersControllerProvider = SupplierOrdersControllerFamily._();

final class SupplierOrdersControllerProvider
    extends
        $AsyncNotifierProvider<SupplierOrdersController, List<PurchaseOrder>> {
  SupplierOrdersControllerProvider._({
    required SupplierOrdersControllerFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'supplierOrdersControllerProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$supplierOrdersControllerHash();

  @override
  String toString() {
    return r'supplierOrdersControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  SupplierOrdersController create() => SupplierOrdersController();

  @override
  bool operator ==(Object other) {
    return other is SupplierOrdersControllerProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$supplierOrdersControllerHash() =>
    r'fcacb1268f2aaf9b7301a7c22b1344aa59a1e9da';

final class SupplierOrdersControllerFamily extends $Family
    with
        $ClassFamilyOverride<
          SupplierOrdersController,
          AsyncValue<List<PurchaseOrder>>,
          List<PurchaseOrder>,
          FutureOr<List<PurchaseOrder>>,
          String
        > {
  SupplierOrdersControllerFamily._()
    : super(
        retry: null,
        name: r'supplierOrdersControllerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  SupplierOrdersControllerProvider call(String supplierId) =>
      SupplierOrdersControllerProvider._(argument: supplierId, from: this);

  @override
  String toString() => r'supplierOrdersControllerProvider';
}

abstract class _$SupplierOrdersController
    extends $AsyncNotifier<List<PurchaseOrder>> {
  late final _$args = ref.$arg as String;
  String get supplierId => _$args;

  FutureOr<List<PurchaseOrder>> build(String supplierId);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<List<PurchaseOrder>>, List<PurchaseOrder>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<PurchaseOrder>>, List<PurchaseOrder>>,
              AsyncValue<List<PurchaseOrder>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args));
  }
}
