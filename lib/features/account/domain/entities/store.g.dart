// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Store _$StoreFromJson(Map<String, dynamic> json) => _Store(
  id: json['id'] as String,
  nombre: json['nombre'] as String,
  nivelPlan: (json['nivel_plan'] as num).toInt(),
  estadoPago: json['estado_pago'] as String,
  fechaProximoCobro: json['fecha_proximo_cobro'] == null
      ? null
      : DateTime.parse(json['fecha_proximo_cobro'] as String),
  fechaFinGracia: json['fecha_fin_gracia'] == null
      ? null
      : DateTime.parse(json['fecha_fin_gracia'] as String),
  fechaFinPrueba: json['fecha_fin_prueba'] == null
      ? null
      : DateTime.parse(json['fecha_fin_prueba'] as String),
);

Map<String, dynamic> _$StoreToJson(_Store instance) => <String, dynamic>{
  'id': instance.id,
  'nombre': instance.nombre,
  'nivel_plan': instance.nivelPlan,
  'estado_pago': instance.estadoPago,
  'fecha_proximo_cobro': instance.fechaProximoCobro?.toIso8601String(),
  'fecha_fin_gracia': instance.fechaFinGracia?.toIso8601String(),
  'fecha_fin_prueba': instance.fechaFinPrueba?.toIso8601String(),
};
