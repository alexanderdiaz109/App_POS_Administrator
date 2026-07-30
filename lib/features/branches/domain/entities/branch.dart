import 'package:freezed_annotation/freezed_annotation.dart';

part 'branch.freezed.dart';
part 'branch.g.dart';

@freezed
abstract class Branch with _$Branch {
  const factory Branch({
    required String id,
    @JsonKey(name: 'store_id') required String storeId,
    required String nombre,
    String? direccion,
    String? telefono,
    required bool activa,
  }) = _Branch;

  factory Branch.fromJson(Map<String, dynamic> json) => _$BranchFromJson(json);
}
