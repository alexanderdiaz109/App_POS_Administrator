import '../../../../core/services/supabase_service.dart';
import '../../../../core/utils/result.dart';
import '../../domain/entities/cart_item.dart';
import '../../domain/entities/sale_result.dart';
import '../../domain/entities/sale_detail.dart';
import '../../domain/repositories/sale_repository.dart';

class SupabaseSaleRepository implements SaleRepository {
  @override
  Future<Result<SaleResult>> createSale({
    required String storeId,
    required String usuarioId,
    required String metodoPago,
    required List<CartItem> items,
  }) async {
    try {
      final payload = items
          .map((i) => {
                'producto_id': i.productId,
                'cantidad': i.cantidad,
                'precio_unitario': i.precioUnitario,
              })
          .toList();

      final data = await SupabaseService.client.rpc('crear_venta', params: {
        'p_store_id': storeId,
        'p_usuario_id': usuarioId,
        'p_metodo_pago': metodoPago,
        'p_items': payload,
      });

      return Result.success(SaleResult.fromJson(data as Map<String, dynamic>));
    } catch (e) {
      return Result.failure('Error al registrar la venta: $e');
    }
  }

  @override
  Future<Result<SaleDetail>> getSaleDetail(String saleId) async {
    try {
      final venta = await SupabaseService.client.from('ventas').select().eq('id', saleId).single();

      final itemsData = await SupabaseService.client
          .from('venta_items')
          .select('cantidad, precio_unitario, productos(nombre)')
          .eq('venta_id', saleId);

      final items = (itemsData as List).map((row) {
        return SaleDetailItem(
          nombre: (row['productos'] as Map)['nombre'] as String,
          cantidad: row['cantidad'] as int,
          precioUnitario: (row['precio_unitario'] as num).toDouble(),
        );
      }).toList();

      return Result.success(SaleDetail(
        id: venta['id'] as String,
        folio: venta['folio'] as String,
        total: (venta['total'] as num).toDouble(),
        metodoPago: venta['metodo_pago'] as String,
        fecha: DateTime.parse(venta['creado_en'] as String),
        items: items,
      ));
    } catch (e) {
      return Result.failure('Error al cargar el recibo: $e');
    }
  }
}
