import 'package:freezed_annotation/freezed_annotation.dart';

part 'sale_detail.freezed.dart';

@freezed
abstract class SaleDetailItem with _$SaleDetailItem {
  const SaleDetailItem._();

  const factory SaleDetailItem({
    required String nombre,
    required int cantidad,
    required double precioUnitario,
  }) = _SaleDetailItem;

  double get subtotal => precioUnitario * cantidad;
}

@freezed
abstract class SaleDetail with _$SaleDetail {
  const factory SaleDetail({
    required String id,
    required String folio,
    required double total,
    required String metodoPago,
    required DateTime fecha,
    required List<SaleDetailItem> items,
  }) = _SaleDetail;
}
