import 'package:freezed_annotation/freezed_annotation.dart';

part 'purchase_order.freezed.dart';
part 'purchase_order.g.dart';

@freezed
abstract class PurchaseOrder with _$PurchaseOrder {
  const factory PurchaseOrder({
    required String id,
    @JsonKey(name: 'store_id') required String storeId,
    @JsonKey(name: 'proveedor_id') required String proveedorId,
    required String folio,
    required String estado, // pendiente, recibida
    required double total,
    @JsonKey(name: 'creado_en') required DateTime creadoEn,
  }) = _PurchaseOrder;

  factory PurchaseOrder.fromJson(Map<String, dynamic> json) => _$PurchaseOrderFromJson(json);
}
