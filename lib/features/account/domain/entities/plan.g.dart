// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plan.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Plan _$PlanFromJson(Map<String, dynamic> json) => _Plan(
  id: (json['id'] as num).toInt(),
  nombre: json['nombre'] as String,
  precioMensual: (json['precio_mensual'] as num).toDouble(),
  precioAnual: (json['precio_anual'] as num).toDouble(),
  stripePriceId: json['stripe_price_id'] as String?,
  activo: json['activo'] as bool,
);

Map<String, dynamic> _$PlanToJson(_Plan instance) => <String, dynamic>{
  'id': instance.id,
  'nombre': instance.nombre,
  'precio_mensual': instance.precioMensual,
  'precio_anual': instance.precioAnual,
  'stripe_price_id': instance.stripePriceId,
  'activo': instance.activo,
};
