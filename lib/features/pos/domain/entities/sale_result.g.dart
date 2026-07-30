// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sale_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SaleResult _$SaleResultFromJson(Map<String, dynamic> json) => _SaleResult(
  id: json['id'] as String,
  folio: json['folio'] as String,
  total: (json['total'] as num).toDouble(),
  montoRecibido: (json['montoRecibido'] as num?)?.toDouble(),
  cambio: (json['cambio'] as num?)?.toDouble(),
);

Map<String, dynamic> _$SaleResultToJson(_SaleResult instance) =>
    <String, dynamic>{
      'id': instance.id,
      'folio': instance.folio,
      'total': instance.total,
      'montoRecibido': instance.montoRecibido,
      'cambio': instance.cambio,
    };
