// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Product _$ProductFromJson(Map<String, dynamic> json) => _Product(
  id: json['id'] as String,
  storeId: json['store_id'] as String,
  categoriaId: json['categoria_id'] as String?,
  nombre: json['nombre'] as String,
  precioVenta: (json['precio_venta'] as num).toDouble(),
  costoCompra: (json['costo_compra'] as num?)?.toDouble(),
  stockActual: (json['stock_actual'] as num).toInt(),
  stockMinimo: (json['stock_minimo'] as num?)?.toInt(),
  atributos: json['atributos'] as Map<String, dynamic>?,
);

Map<String, dynamic> _$ProductToJson(_Product instance) => <String, dynamic>{
  'id': instance.id,
  'store_id': instance.storeId,
  'categoria_id': instance.categoriaId,
  'nombre': instance.nombre,
  'precio_venta': instance.precioVenta,
  'costo_compra': instance.costoCompra,
  'stock_actual': instance.stockActual,
  'stock_minimo': instance.stockMinimo,
  'atributos': instance.atributos,
};
