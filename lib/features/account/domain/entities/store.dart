import 'package:freezed_annotation/freezed_annotation.dart';

part 'store.freezed.dart';
part 'store.g.dart';

@freezed
abstract class Store with _$Store {
  const Store._();

  const factory Store({
    required String id,
    required String nombre,
    @JsonKey(name: 'nivel_plan') required int nivelPlan,
    @JsonKey(name: 'estado_pago') required String estadoPago,
    @JsonKey(name: 'fecha_proximo_cobro') DateTime? fechaProximoCobro,
    @JsonKey(name: 'fecha_fin_gracia') DateTime? fechaFinGracia,
    @JsonKey(name: 'fecha_fin_prueba') DateTime? fechaFinPrueba,
  }) = _Store;

  factory Store.fromJson(Map<String, dynamic> json) => _$StoreFromJson(json);

  int get diasRestantesPrueba {
    if (fechaFinPrueba == null) return 0;
    final diff = fechaFinPrueba!.difference(DateTime.now()).inDays;
    return diff < 0 ? 0 : diff;
  }
}
