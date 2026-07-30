// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AppUser _$AppUserFromJson(Map<String, dynamic> json) => _AppUser(
  id: json['id'] as String,
  storeId: json['store_id'] as String,
  nombre: json['nombre'] as String,
  correo: json['correo'] as String,
  rol: json['rol'] as String,
  activo: json['activo'] as bool,
);

Map<String, dynamic> _$AppUserToJson(_AppUser instance) => <String, dynamic>{
  'id': instance.id,
  'store_id': instance.storeId,
  'nombre': instance.nombre,
  'correo': instance.correo,
  'rol': instance.rol,
  'activo': instance.activo,
};
