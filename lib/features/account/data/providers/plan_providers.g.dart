// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plan_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(planRepository)
final planRepositoryProvider = PlanRepositoryProvider._();

final class PlanRepositoryProvider
    extends $FunctionalProvider<PlanRepository, PlanRepository, PlanRepository>
    with $Provider<PlanRepository> {
  PlanRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'planRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$planRepositoryHash();

  @$internal
  @override
  $ProviderElement<PlanRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  PlanRepository create(Ref ref) {
    return planRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PlanRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PlanRepository>(value),
    );
  }
}

String _$planRepositoryHash() => r'0d98eea91640d0b48021467b4883db378ea89247';

@ProviderFor(availablePlans)
final availablePlansProvider = AvailablePlansProvider._();

final class AvailablePlansProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Plan>>,
          List<Plan>,
          FutureOr<List<Plan>>
        >
    with $FutureModifier<List<Plan>>, $FutureProvider<List<Plan>> {
  AvailablePlansProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'availablePlansProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$availablePlansHash();

  @$internal
  @override
  $FutureProviderElement<List<Plan>> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<List<Plan>> create(Ref ref) {
    return availablePlans(ref);
  }
}

String _$availablePlansHash() => r'18a416c5c44c3983b73e5db575d4528bad9d4dc3';
