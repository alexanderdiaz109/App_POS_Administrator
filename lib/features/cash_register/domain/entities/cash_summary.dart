import 'package:freezed_annotation/freezed_annotation.dart';

part 'cash_summary.freezed.dart';
part 'cash_summary.g.dart';

@freezed
abstract class CashSummary with _$CashSummary {
  const factory CashSummary({
    required double total,
    @JsonKey(name: 'numVentas') required int numVentas,
    required double efectivo,
    required double tarjeta,
    required double transferencia,
    @JsonKey(name: 'gananciaNeta') required double gananciaNeta,
  }) = _CashSummary;

  factory CashSummary.fromJson(Map<String, dynamic> json) => _$CashSummaryFromJson(json);
}
