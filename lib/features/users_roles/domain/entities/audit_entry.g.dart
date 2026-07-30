// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'audit_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AuditEntry _$AuditEntryFromJson(Map<String, dynamic> json) => _AuditEntry(
  id: json['id'] as String,
  usuarioNombre: json['usuarioNombre'] as String,
  accion: json['accion'] as String,
  tipo: json['tipo'] as String,
  fecha: DateTime.parse(json['fecha'] as String),
);

Map<String, dynamic> _$AuditEntryToJson(_AuditEntry instance) =>
    <String, dynamic>{
      'id': instance.id,
      'usuarioNombre': instance.usuarioNombre,
      'accion': instance.accion,
      'tipo': instance.tipo,
      'fecha': instance.fecha.toIso8601String(),
    };
