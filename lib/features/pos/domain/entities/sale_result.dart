import 'package:freezed_annotation/freezed_annotation.dart';

part 'sale_result.freezed.dart';
part 'sale_result.g.dart';

@freezed
abstract class SaleResult with _$SaleResult {
  const factory SaleResult({
    required String id,
    required String folio,
    required double total,
    double? montoRecibido,
    double? cambio,
  }) = _SaleResult;

  factory SaleResult.fromJson(Map<String, dynamic> json) => _$SaleResultFromJson(json);
}
