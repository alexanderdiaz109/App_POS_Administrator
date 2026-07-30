// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cash_summary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CashSummary _$CashSummaryFromJson(Map<String, dynamic> json) => _CashSummary(
  total: (json['total'] as num).toDouble(),
  numVentas: (json['numVentas'] as num).toInt(),
  efectivo: (json['efectivo'] as num).toDouble(),
  tarjeta: (json['tarjeta'] as num).toDouble(),
  transferencia: (json['transferencia'] as num).toDouble(),
  gananciaNeta: (json['gananciaNeta'] as num).toDouble(),
);

Map<String, dynamic> _$CashSummaryToJson(_CashSummary instance) =>
    <String, dynamic>{
      'total': instance.total,
      'numVentas': instance.numVentas,
      'efectivo': instance.efectivo,
      'tarjeta': instance.tarjeta,
      'transferencia': instance.transferencia,
      'gananciaNeta': instance.gananciaNeta,
    };
