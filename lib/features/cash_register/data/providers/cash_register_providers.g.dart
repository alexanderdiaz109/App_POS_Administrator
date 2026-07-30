// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cash_register_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(reportsService)
final reportsServiceProvider = ReportsServiceProvider._();

final class ReportsServiceProvider
    extends $FunctionalProvider<ReportsService, ReportsService, ReportsService>
    with $Provider<ReportsService> {
  ReportsServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'reportsServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$reportsServiceHash();

  @$internal
  @override
  $ProviderElement<ReportsService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ReportsService create(Ref ref) {
    return reportsService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ReportsService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ReportsService>(value),
    );
  }
}

String _$reportsServiceHash() => r'5fa0e3052c193d24f1375b4cd4a3935f6a72f524';

@ProviderFor(cashSummaryToday)
final cashSummaryTodayProvider = CashSummaryTodayProvider._();

final class CashSummaryTodayProvider
    extends
        $FunctionalProvider<
          AsyncValue<CashSummary>,
          CashSummary,
          FutureOr<CashSummary>
        >
    with $FutureModifier<CashSummary>, $FutureProvider<CashSummary> {
  CashSummaryTodayProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'cashSummaryTodayProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$cashSummaryTodayHash();

  @$internal
  @override
  $FutureProviderElement<CashSummary> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<CashSummary> create(Ref ref) {
    return cashSummaryToday(ref);
  }
}

String _$cashSummaryTodayHash() => r'fa0ccb78f44bd3eee6dc5121232bdb17339317dc';

@ProviderFor(cashSummaryWeek)
final cashSummaryWeekProvider = CashSummaryWeekProvider._();

final class CashSummaryWeekProvider
    extends
        $FunctionalProvider<
          AsyncValue<CashSummary>,
          CashSummary,
          FutureOr<CashSummary>
        >
    with $FutureModifier<CashSummary>, $FutureProvider<CashSummary> {
  CashSummaryWeekProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'cashSummaryWeekProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$cashSummaryWeekHash();

  @$internal
  @override
  $FutureProviderElement<CashSummary> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<CashSummary> create(Ref ref) {
    return cashSummaryWeek(ref);
  }
}

String _$cashSummaryWeekHash() => r'f863c313e5320ee9f8434c5d07c42b2ebe4b5e7a';
