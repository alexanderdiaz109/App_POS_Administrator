// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sale_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(saleRepository)
final saleRepositoryProvider = SaleRepositoryProvider._();

final class SaleRepositoryProvider
    extends $FunctionalProvider<SaleRepository, SaleRepository, SaleRepository>
    with $Provider<SaleRepository> {
  SaleRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'saleRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$saleRepositoryHash();

  @$internal
  @override
  $ProviderElement<SaleRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SaleRepository create(Ref ref) {
    return saleRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SaleRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SaleRepository>(value),
    );
  }
}

String _$saleRepositoryHash() => r'2b14370b19329e63f18d4705dd69649467f966d3';

@ProviderFor(SaleController)
final saleControllerProvider = SaleControllerProvider._();

final class SaleControllerProvider
    extends $AsyncNotifierProvider<SaleController, void> {
  SaleControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'saleControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$saleControllerHash();

  @$internal
  @override
  SaleController create() => SaleController();
}

String _$saleControllerHash() => r'e4abbde61d4d4aca1d468fc037652060c42b00e0';

abstract class _$SaleController extends $AsyncNotifier<void> {
  FutureOr<void> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<void>, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<void>, void>,
              AsyncValue<void>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

@ProviderFor(saleDetail)
final saleDetailProvider = SaleDetailFamily._();

final class SaleDetailProvider
    extends
        $FunctionalProvider<
          AsyncValue<SaleDetail>,
          SaleDetail,
          FutureOr<SaleDetail>
        >
    with $FutureModifier<SaleDetail>, $FutureProvider<SaleDetail> {
  SaleDetailProvider._({
    required SaleDetailFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'saleDetailProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$saleDetailHash();

  @override
  String toString() {
    return r'saleDetailProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<SaleDetail> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<SaleDetail> create(Ref ref) {
    final argument = this.argument as String;
    return saleDetail(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is SaleDetailProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$saleDetailHash() => r'37b1fba385ed265869010e6c0cc3580ccfdd4a70';

final class SaleDetailFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<SaleDetail>, String> {
  SaleDetailFamily._()
    : super(
        retry: null,
        name: r'saleDetailProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  SaleDetailProvider call(String saleId) =>
      SaleDetailProvider._(argument: saleId, from: this);

  @override
  String toString() => r'saleDetailProvider';
}

@ProviderFor(receiptPdfService)
final receiptPdfServiceProvider = ReceiptPdfServiceProvider._();

final class ReceiptPdfServiceProvider
    extends
        $FunctionalProvider<
          ReceiptPdfService,
          ReceiptPdfService,
          ReceiptPdfService
        >
    with $Provider<ReceiptPdfService> {
  ReceiptPdfServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'receiptPdfServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$receiptPdfServiceHash();

  @$internal
  @override
  $ProviderElement<ReceiptPdfService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ReceiptPdfService create(Ref ref) {
    return receiptPdfService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ReceiptPdfService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ReceiptPdfService>(value),
    );
  }
}

String _$receiptPdfServiceHash() => r'f42c0a920f13e82b68baa14116c51be603fa05dc';
