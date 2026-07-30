// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plan_features_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(currentPlanFeatures)
final currentPlanFeaturesProvider = CurrentPlanFeaturesProvider._();

final class CurrentPlanFeaturesProvider
    extends
        $FunctionalProvider<
          AsyncValue<PlanFeatures>,
          PlanFeatures,
          FutureOr<PlanFeatures>
        >
    with $FutureModifier<PlanFeatures>, $FutureProvider<PlanFeatures> {
  CurrentPlanFeaturesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'currentPlanFeaturesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$currentPlanFeaturesHash();

  @$internal
  @override
  $FutureProviderElement<PlanFeatures> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<PlanFeatures> create(Ref ref) {
    return currentPlanFeatures(ref);
  }
}

String _$currentPlanFeaturesHash() =>
    r'b1661a3f6f6e4e301090a3dfbc5e921520de5c37';
