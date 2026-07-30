import 'package:freezed_annotation/freezed_annotation.dart';

part 'cart_item.freezed.dart';

@freezed
abstract class CartItem with _$CartItem {
  const CartItem._();

  const factory CartItem({
    required String productId,
    required String nombre,
    required double precioUnitario,
    required int cantidad,
    required int stockDisponible,
  }) = _CartItem;

  double get subtotal => precioUnitario * cantidad;
}
