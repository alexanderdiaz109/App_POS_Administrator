// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'team_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(teamRepository)
final teamRepositoryProvider = TeamRepositoryProvider._();

final class TeamRepositoryProvider
    extends $FunctionalProvider<TeamRepository, TeamRepository, TeamRepository>
    with $Provider<TeamRepository> {
  TeamRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'teamRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$teamRepositoryHash();

  @$internal
  @override
  $ProviderElement<TeamRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  TeamRepository create(Ref ref) {
    return teamRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TeamRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TeamRepository>(value),
    );
  }
}

String _$teamRepositoryHash() => r'4640ebf45c3a130e55bd818bd556dcfc78b47315';

@ProviderFor(TeamListController)
final teamListControllerProvider = TeamListControllerProvider._();

final class TeamListControllerProvider
    extends $AsyncNotifierProvider<TeamListController, List<TeamMember>> {
  TeamListControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'teamListControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$teamListControllerHash();

  @$internal
  @override
  TeamListController create() => TeamListController();
}

String _$teamListControllerHash() =>
    r'eb8f227d8e9dde26d4b12bb4d394d6a5619df0a3';

abstract class _$TeamListController extends $AsyncNotifier<List<TeamMember>> {
  FutureOr<List<TeamMember>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<List<TeamMember>>, List<TeamMember>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<TeamMember>>, List<TeamMember>>,
              AsyncValue<List<TeamMember>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

@ProviderFor(auditLog)
final auditLogProvider = AuditLogProvider._();

final class AuditLogProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<AuditEntry>>,
          List<AuditEntry>,
          FutureOr<List<AuditEntry>>
        >
    with $FutureModifier<List<AuditEntry>>, $FutureProvider<List<AuditEntry>> {
  AuditLogProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'auditLogProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$auditLogHash();

  @$internal
  @override
  $FutureProviderElement<List<AuditEntry>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<AuditEntry>> create(Ref ref) {
    return auditLog(ref);
  }
}

String _$auditLogHash() => r'4aaed479eb771a84dee351f8d7577f6ea3e5b7c6';
