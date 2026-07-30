import 'package:freezed_annotation/freezed_annotation.dart';

part 'supplier.freezed.dart';
part 'supplier.g.dart';

@freezed
abstract class Supplier with _$Supplier {
  const factory Supplier({
    required String id,
    @JsonKey(name: 'store_id') required String storeId,
    required String nombre,
    String? categoria,
    String? telefono,
    String? correo,
    String? notas,
  }) = _Supplier;

  factory Supplier.fromJson(Map<String, dynamic> json) => _$SupplierFromJson(json);
}
