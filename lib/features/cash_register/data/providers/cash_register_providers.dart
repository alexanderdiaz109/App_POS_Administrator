import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/services/reports_service.dart';
import '../../../../core/utils/date_ranges.dart';
import '../../domain/entities/cash_summary.dart';
import '../../../account/data/providers/store_providers.dart';

part 'cash_register_providers.g.dart';

@riverpod
ReportsService reportsService(Ref ref) => ReportsService();

@riverpod
Future<CashSummary> cashSummaryToday(Ref ref) async {
  final store = await ref.watch(currentStoreProvider.future);
  final service = ref.watch(reportsServiceProvider);
  final range = DateRange.today();
  final result = await service.getResumenVentas(storeId: store.id, inicio: range.inicio, fin: range.fin);
  return result.when(success: (data) => data, failure: (msg) => throw Exception(msg));
}

@riverpod
Future<CashSummary> cashSummaryWeek(Ref ref) async {
  final store = await ref.watch(currentStoreProvider.future);
  final service = ref.watch(reportsServiceProvider);
  final range = DateRange.thisWeek();
  final result = await service.getResumenVentas(storeId: store.id, inicio: range.inicio, fin: range.fin);
  return result.when(success: (data) => data, failure: (msg) => throw Exception(msg));
}
