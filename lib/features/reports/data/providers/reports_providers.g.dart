// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reports_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(topProducts)
final topProductsProvider = TopProductsFamily._();

final class TopProductsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<TopProduct>>,
          List<TopProduct>,
          FutureOr<List<TopProduct>>
        >
    with $FutureModifier<List<TopProduct>>, $FutureProvider<List<TopProduct>> {
  TopProductsProvider._({
    required TopProductsFamily super.from,
    required ReportPeriod super.argument,
  }) : super(
         retry: null,
         name: r'topProductsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$topProductsHash();

  @override
  String toString() {
    return r'topProductsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<TopProduct>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<TopProduct>> create(Ref ref) {
    final argument = this.argument as ReportPeriod;
    return topProducts(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is TopProductsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$topProductsHash() => r'1bbab7325c54b11b2965beda37437602d1026dcb';

final class TopProductsFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<TopProduct>>, ReportPeriod> {
  TopProductsFamily._()
    : super(
        retry: null,
        name: r'topProductsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  TopProductsProvider call(ReportPeriod period) =>
      TopProductsProvider._(argument: period, from: this);

  @override
  String toString() => r'topProductsProvider';
}

@ProviderFor(topProductsToday)
final topProductsTodayProvider = TopProductsTodayProvider._();

final class TopProductsTodayProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<TopProduct>>,
          List<TopProduct>,
          FutureOr<List<TopProduct>>
        >
    with $FutureModifier<List<TopProduct>>, $FutureProvider<List<TopProduct>> {
  TopProductsTodayProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'topProductsTodayProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$topProductsTodayHash();

  @$internal
  @override
  $FutureProviderElement<List<TopProduct>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<TopProduct>> create(Ref ref) {
    return topProductsToday(ref);
  }
}

String _$topProductsTodayHash() => r'643a95f0c836251db398a3257a046a73c472aa59';

@ProviderFor(topProductsThisMonth)
final topProductsThisMonthProvider = TopProductsThisMonthProvider._();

final class TopProductsThisMonthProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<TopProduct>>,
          List<TopProduct>,
          FutureOr<List<TopProduct>>
        >
    with $FutureModifier<List<TopProduct>>, $FutureProvider<List<TopProduct>> {
  TopProductsThisMonthProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'topProductsThisMonthProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$topProductsThisMonthHash();

  @$internal
  @override
  $FutureProviderElement<List<TopProduct>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<TopProduct>> create(Ref ref) {
    return topProductsThisMonth(ref);
  }
}

String _$topProductsThisMonthHash() =>
    r'aeaf7b987e62dfe284f9166cbef34c23eaa333ae';

@ProviderFor(exportService)
final exportServiceProvider = ExportServiceProvider._();

final class ExportServiceProvider
    extends $FunctionalProvider<ExportService, ExportService, ExportService>
    with $Provider<ExportService> {
  ExportServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'exportServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$exportServiceHash();

  @$internal
  @override
  $ProviderElement<ExportService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ExportService create(Ref ref) {
    return exportService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ExportService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ExportService>(value),
    );
  }
}

String _$exportServiceHash() => r'1ad1ab4c9dedadf438237492e14472b491c1cdad';
