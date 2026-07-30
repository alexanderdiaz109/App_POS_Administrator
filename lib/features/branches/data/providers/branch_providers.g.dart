// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'branch_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(branchRepository)
final branchRepositoryProvider = BranchRepositoryProvider._();

final class BranchRepositoryProvider
    extends
        $FunctionalProvider<
          BranchRepository,
          BranchRepository,
          BranchRepository
        >
    with $Provider<BranchRepository> {
  BranchRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'branchRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$branchRepositoryHash();

  @$internal
  @override
  $ProviderElement<BranchRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  BranchRepository create(Ref ref) {
    return branchRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BranchRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BranchRepository>(value),
    );
  }
}

String _$branchRepositoryHash() => r'abcf2b9ec656e37cdf8c4786505e3fdfe3f00f0c';

@ProviderFor(BranchListController)
final branchListControllerProvider = BranchListControllerProvider._();

final class BranchListControllerProvider
    extends $AsyncNotifierProvider<BranchListController, List<Branch>> {
  BranchListControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'branchListControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$branchListControllerHash();

  @$internal
  @override
  BranchListController create() => BranchListController();
}

String _$branchListControllerHash() =>
    r'7f44221af504409bedc10bc3992e12516b08b0ff';

abstract class _$BranchListController extends $AsyncNotifier<List<Branch>> {
  FutureOr<List<Branch>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<Branch>>, List<Branch>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Branch>>, List<Branch>>,
              AsyncValue<List<Branch>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
