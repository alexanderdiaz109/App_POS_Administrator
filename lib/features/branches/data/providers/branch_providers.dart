import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/entities/branch.dart';
import '../../domain/repositories/branch_repository.dart';
import '../repositories/supabase_branch_repository.dart';
import '../../../account/data/providers/store_providers.dart';

part 'branch_providers.g.dart';

@riverpod
BranchRepository branchRepository(Ref ref) {
  return SupabaseBranchRepository();
}

@riverpod
class BranchListController extends _$BranchListController {
  @override
  Future<List<Branch>> build() async {
    final store = await ref.watch(currentStoreProvider.future);
    final repo = ref.watch(branchRepositoryProvider);
    final result = await repo.getBranches(store.id);
    return result.when(success: (data) => data, failure: (msg) => throw Exception(msg));
  }

  Future<String?> addBranch({required String nombre, String? direccion, String? telefono}) async {
    final store = await ref.read(currentStoreProvider.future);
    final repo = ref.read(branchRepositoryProvider);
    final result = await repo.createBranch(Branch(
      id: '',
      storeId: store.id,
      nombre: nombre,
      direccion: direccion,
      telefono: telefono,
      activa: true,
    ));
    return result.when(
      success: (_) {
        ref.invalidateSelf();
        return null;
      },
      failure: (msg) => msg,
    );
  }

  Future<String?> toggleActive(String id, bool activa) async {
    final repo = ref.read(branchRepositoryProvider);
    final result = await repo.toggleActive(id, activa);
    return result.when(
      success: (_) {
        ref.invalidateSelf();
        return null;
      },
      failure: (msg) => msg,
    );
  }
}
