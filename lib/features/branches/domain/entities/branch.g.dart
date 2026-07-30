// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'branch.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Branch _$BranchFromJson(Map<String, dynamic> json) => _Branch(
  id: json['id'] as String,
  storeId: json['store_id'] as String,
  nombre: json['nombre'] as String,
  direccion: json['direccion'] as String?,
  telefono: json['telefono'] as String?,
  activa: json['activa'] as bool,
);

Map<String, dynamic> _$BranchToJson(_Branch instance) => <String, dynamic>{
  'id': instance.id,
  'store_id': instance.storeId,
  'nombre': instance.nombre,
  'direccion': instance.direccion,
  'telefono': instance.telefono,
  'activa': instance.activa,
};
