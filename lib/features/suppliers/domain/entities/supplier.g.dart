// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'supplier.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Supplier _$SupplierFromJson(Map<String, dynamic> json) => _Supplier(
  id: json['id'] as String,
  storeId: json['store_id'] as String,
  nombre: json['nombre'] as String,
  categoria: json['categoria'] as String?,
  telefono: json['telefono'] as String?,
  correo: json['correo'] as String?,
  notas: json['notas'] as String?,
);

Map<String, dynamic> _$SupplierToJson(_Supplier instance) => <String, dynamic>{
  'id': instance.id,
  'store_id': instance.storeId,
  'nombre': instance.nombre,
  'categoria': instance.categoria,
  'telefono': instance.telefono,
  'correo': instance.correo,
  'notas': instance.notas,
};
