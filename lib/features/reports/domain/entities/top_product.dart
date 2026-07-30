import 'package:freezed_annotation/freezed_annotation.dart';

part 'top_product.freezed.dart';
part 'top_product.g.dart';

@freezed
abstract class TopProduct with _$TopProduct {
  const factory TopProduct({
    @JsonKey(name: 'producto_id') required String productoId,
    required String nombre,
    required int unidades,
  }) = _TopProduct;

  factory TopProduct.fromJson(Map<String, dynamic> json) => _$TopProductFromJson(json);
}
