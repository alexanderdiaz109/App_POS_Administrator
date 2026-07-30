// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Payment _$PaymentFromJson(Map<String, dynamic> json) => _Payment(
  id: json['id'] as String,
  monto: (json['monto'] as num).toDouble(),
  estado: json['estado'] as String,
  fecha: DateTime.parse(json['fecha'] as String),
);

Map<String, dynamic> _$PaymentToJson(_Payment instance) => <String, dynamic>{
  'id': instance.id,
  'monto': instance.monto,
  'estado': instance.estado,
  'fecha': instance.fecha.toIso8601String(),
};
