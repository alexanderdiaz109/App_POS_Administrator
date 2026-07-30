import 'package:freezed_annotation/freezed_annotation.dart';

part 'product.freezed.dart';
part 'product.g.dart';

@freezed
abstract class Product with _$Product {
  const Product._();

  const factory Product({
    required String id,
    @JsonKey(name: 'store_id') required String storeId,
    @JsonKey(name: 'categoria_id') String? categoriaId,
    required String nombre,
    @JsonKey(name: 'precio_venta') required double precioVenta,
    @JsonKey(name: 'costo_compra') double? costoCompra,
    @JsonKey(name: 'stock_actual') required int stockActual,
    @JsonKey(name: 'stock_minimo') int? stockMinimo,
    Map<String, dynamic>? atributos,
  }) = _Product;

  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);

  bool get tieneStockBajo {
    if (stockMinimo == null) return false;
    return stockActual <= stockMinimo!;
  }

  double? get utilidadPorUnidad {
    if (costoCompra == null) return null;
    return precioVenta - costoCompra!;
  }
}
