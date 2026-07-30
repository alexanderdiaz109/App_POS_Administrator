import 'package:freezed_annotation/freezed_annotation.dart';

part 'plan.freezed.dart';
part 'plan.g.dart';

@freezed
abstract class Plan with _$Plan {
  const factory Plan({
    required int id,
    required String nombre,
    @JsonKey(name: 'precio_mensual') required double precioMensual,
    @JsonKey(name: 'precio_anual') required double precioAnual,
    @JsonKey(name: 'stripe_price_id') String? stripePriceId,
    required bool activo,
  }) = _Plan;

  factory Plan.fromJson(Map<String, dynamic> json) => _$PlanFromJson(json);
}
