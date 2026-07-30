import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/utils/date_ranges.dart';
import '../../domain/entities/top_product.dart';
import '../../../account/data/providers/store_providers.dart';
import '../../../cash_register/data/providers/cash_register_providers.dart';
import '../services/export_service.dart';

part 'reports_providers.g.dart';

enum ReportPeriod { last7Days, last30Days }

@riverpod
Future<List<TopProduct>> topProducts(Ref ref, ReportPeriod period) async {
  final store = await ref.watch(currentStoreProvider.future);
  final service = ref.watch(reportsServiceProvider);
  final range = period == ReportPeriod.last7Days ? DateRange.lastNDays(7) : DateRange.lastNDays(30);
  final result = await service.getTopProductos(storeId: store.id, inicio: range.inicio, fin: range.fin);
  return result.when(success: (data) => data, failure: (msg) => throw Exception(msg));
}

@riverpod
Future<List<TopProduct>> topProductsToday(Ref ref) async {
  final store = await ref.watch(currentStoreProvider.future);
  final service = ref.watch(reportsServiceProvider);
  final range = DateRange.today();
  final result = await service.getTopProductos(storeId: store.id, inicio: range.inicio, fin: range.fin, limite: 5);
  return result.when(success: (data) => data, failure: (msg) => throw Exception(msg));
}

@riverpod
Future<List<TopProduct>> topProductsThisMonth(Ref ref) async {
  final store = await ref.watch(currentStoreProvider.future);
  final service = ref.watch(reportsServiceProvider);
  final now = DateTime.now();
  final inicio = DateTime(now.year, now.month, 1);
  final fin = DateTime(now.year, now.month + 1, 1);
  final result = await service.getTopProductos(storeId: store.id, inicio: inicio, fin: fin, limite: 5);
  return result.when(success: (data) => data, failure: (msg) => throw Exception(msg));
}

@riverpod
ExportService exportService(Ref ref) => ExportService();
