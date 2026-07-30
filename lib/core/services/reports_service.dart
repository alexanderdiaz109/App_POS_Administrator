import '../services/supabase_service.dart';
import '../utils/result.dart';
import '../../features/cash_register/domain/entities/cash_summary.dart';
import '../../features/reports/domain/entities/top_product.dart';

class ReportsService {
  Future<Result<CashSummary>> getResumenVentas({
    required String storeId,
    required DateTime inicio,
    required DateTime fin,
  }) async {
    try {
      final data = await SupabaseService.client.rpc('resumen_ventas', params: {
        'p_store_id': storeId,
        'p_fecha_inicio': inicio.toIso8601String(),
        'p_fecha_fin': fin.toIso8601String(),
      });
      return Result.success(CashSummary.fromJson(data as Map<String, dynamic>));
    } catch (e) {
      return Result.failure('Error al cargar el resumen: $e');
    }
  }

  Future<Result<List<TopProduct>>> getTopProductos({
    required String storeId,
    required DateTime inicio,
    required DateTime fin,
    int limite = 5,
  }) async {
    try {
      final data = await SupabaseService.client.rpc('top_productos', params: {
        'p_store_id': storeId,
        'p_fecha_inicio': inicio.toIso8601String(),
        'p_fecha_fin': fin.toIso8601String(),
        'p_limite': limite,
      });
      final productos = (data as List).map((e) => TopProduct.fromJson(e as Map<String, dynamic>)).toList();
      return Result.success(productos);
    } catch (e) {
      return Result.failure('Error al cargar el top de productos: $e');
    }
  }
}
