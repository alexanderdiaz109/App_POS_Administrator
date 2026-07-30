import '../../../../core/utils/result.dart';
import '../entities/branch.dart';

abstract interface class BranchRepository {
  Future<Result<List<Branch>>> getBranches(String storeId);
  Future<Result<Branch>> createBranch(Branch branch);
  Future<Result<Branch>> toggleActive(String id, bool activa);
}
