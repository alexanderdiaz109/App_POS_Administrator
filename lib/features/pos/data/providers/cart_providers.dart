import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/entities/cart_item.dart';
import '../../../products/domain/entities/product.dart';

part 'cart_providers.g.dart';

/// Carrito de la venta en curso. Estado local (no persiste en Supabase
/// hasta que se confirma la venta).
@riverpod
class CartController extends _$CartController {
  @override
  List<CartItem> build() => [];

  void addProduct(Product product) {
    final index = state.indexWhere((i) => i.productId == product.id);
    if (index >= 0) {
      final existing = state[index];
      if (existing.cantidad >= existing.stockDisponible) return; // no exceder stock
      state = [
        for (final item in state)
          if (item.productId == product.id) item.copyWith(cantidad: item.cantidad + 1) else item,
      ];
    } else {
      if (product.stockActual <= 0) return;
      state = [
        ...state,
        CartItem(
          productId: product.id,
          nombre: product.nombre,
          precioUnitario: product.precioVenta,
          cantidad: 1,
          stockDisponible: product.stockActual,
        ),
      ];
    }
  }

  void increment(String productId) {
    state = [
      for (final item in state)
        if (item.productId == productId && item.cantidad < item.stockDisponible)
          item.copyWith(cantidad: item.cantidad + 1)
        else
          item,
    ];
  }

  void decrement(String productId) {
    final item = state.firstWhere((i) => i.productId == productId);
    if (item.cantidad <= 1) {
      removeItem(productId);
      return;
    }
    state = [
      for (final i in state)
        if (i.productId == productId) i.copyWith(cantidad: i.cantidad - 1) else i,
    ];
  }

  void removeItem(String productId) {
    state = state.where((i) => i.productId != productId).toList();
  }

  void clear() => state = [];
}

@riverpod
double cartTotal(Ref ref) {
  final items = ref.watch(cartControllerProvider);
  return items.fold(0.0, (sum, i) => sum + i.subtotal);
}
