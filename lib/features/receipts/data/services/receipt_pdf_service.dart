import 'dart:io';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:file_saver/file_saver.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import '../../../pos/domain/entities/sale_detail.dart';

/// Genera el recibo de una venta como PDF real, con el mismo formato de
/// ticket que ya se muestra en pantalla (ReceiptPreviewScreen).
class ReceiptPdfService {
  Future<Uint8List> _buildBytes({
    required SaleDetail sale,
    required String tiendaNombre,
  }) async {
    final doc = pw.Document();

    doc.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.roll80, // formato angosto tipo ticket
        margin: const pw.EdgeInsets.all(16),
        build: (context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.center,
            children: [
              pw.Text(tiendaNombre, style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 4),
              pw.Text(
                '${sale.fecha.day}/${sale.fecha.month}/${sale.fecha.year} '
                '${sale.fecha.hour.toString().padLeft(2, '0')}:${sale.fecha.minute.toString().padLeft(2, '0')}',
                style: const pw.TextStyle(fontSize: 9),
              ),
              pw.Text('Folio ${sale.folio}', style: const pw.TextStyle(fontSize: 9)),
              pw.SizedBox(height: 8),
              pw.Divider(borderStyle: pw.BorderStyle.dashed),
              pw.SizedBox(height: 4),
              pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.stretch,
                children: sale.items.map((item) {
                  return pw.Padding(
                    padding: const pw.EdgeInsets.symmetric(vertical: 2),
                    child: pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Expanded(
                          child: pw.Text(
                            '${item.cantidad}x ${item.nombre}',
                            style: const pw.TextStyle(fontSize: 9),
                          ),
                        ),
                        pw.Text('\$${item.subtotal.toStringAsFixed(2)}', style: const pw.TextStyle(fontSize: 9)),
                      ],
                    ),
                  );
                }).toList(),
              ),
              pw.SizedBox(height: 4),
              pw.Divider(borderStyle: pw.BorderStyle.dashed),
              pw.SizedBox(height: 4),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text('TOTAL', style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold)),
                  pw.Text(
                    '\$${sale.total.toStringAsFixed(2)}',
                    style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold),
                  ),
                ],
              ),
              pw.SizedBox(height: 4),
              pw.Text(
                'Método de pago: ${_metodoLabel(sale.metodoPago)}',
                style: const pw.TextStyle(fontSize: 8),
              ),
              pw.SizedBox(height: 12),
              pw.Text('¡Gracias por tu compra!', style: const pw.TextStyle(fontSize: 9)),
            ],
          );
        },
      ),
    );

    return doc.save();
  }

  String _metodoLabel(String metodo) {
    switch (metodo) {
      case 'efectivo':
        return 'Efectivo';
      case 'tarjeta':
        return 'Tarjeta';
      case 'transferencia':
        return 'Transferencia';
      default:
        return metodo;
    }
  }

  Future<void> share({required SaleDetail sale, required String tiendaNombre}) async {
    final bytes = await _buildBytes(sale: sale, tiendaNombre: tiendaNombre);
    final dir = await getTemporaryDirectory();
    final file = File('${dir.path}/recibo_${sale.folio}.pdf');
    await file.writeAsBytes(bytes);
    
    await Share.shareXFiles(
      [XFile(file.path)], 
      subject: 'Recibo ${sale.folio}',
    );
  }

  Future<String> download({required SaleDetail sale, required String tiendaNombre}) async {
    final bytes = await _buildBytes(sale: sale, tiendaNombre: tiendaNombre);
    return FileSaver.instance.saveFile(
      name: 'recibo_${sale.folio}',
      bytes: bytes,
      ext: 'pdf',
      mimeType: MimeType.pdf,
    );
  }
}
