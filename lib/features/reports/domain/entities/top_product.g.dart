// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'top_product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TopProduct _$TopProductFromJson(Map<String, dynamic> json) => _TopProduct(
  productoId: json['producto_id'] as String,
  nombre: json['nombre'] as String,
  unidades: (json['unidades'] as num).toInt(),
);

Map<String, dynamic> _$TopProductToJson(_TopProduct instance) =>
    <String, dynamic>{
      'producto_id': instance.productoId,
      'nombre': instance.nombre,
      'unidades': instance.unidades,
    };
