// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'purchase_order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PurchaseOrder _$PurchaseOrderFromJson(Map<String, dynamic> json) =>
    _PurchaseOrder(
      id: json['id'] as String,
      storeId: json['store_id'] as String,
      proveedorId: json['proveedor_id'] as String,
      folio: json['folio'] as String,
      estado: json['estado'] as String,
      total: (json['total'] as num).toDouble(),
      creadoEn: DateTime.parse(json['creado_en'] as String),
    );

Map<String, dynamic> _$PurchaseOrderToJson(_PurchaseOrder instance) =>
    <String, dynamic>{
      'id': instance.id,
      'store_id': instance.storeId,
      'proveedor_id': instance.proveedorId,
      'folio': instance.folio,
      'estado': instance.estado,
      'total': instance.total,
      'creado_en': instance.creadoEn.toIso8601String(),
    };
