import 'dart:io';
import 'dart:typed_data';
import 'package:csv/csv.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:file_saver/file_saver.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import '../../domain/entities/top_product.dart';

/// Genera reportes en CSV y PDF, y ofrece dos acciones: compartir (menú
/// nativo) o descargar directo al dispositivo (Descargas/Files).
class ExportService {
  // ---------- CSV ----------

  Future<Uint8List> _buildCsvBytes(List<TopProduct> productos) async {
    final rows = <List<dynamic>>[
      ['Posición', 'Producto', 'Unidades vendidas'],
      for (var i = 0; i < productos.length; i++) [i + 1, productos[i].nombre, productos[i].unidades],
    ];
    // BOM de UTF-8 al inicio para que Excel/Sheets muestren bien los acentos.
    final csv = '\uFEFF${const ListToCsvConverter().convert(rows)}';
    return Uint8List.fromList(csv.codeUnits);
  }

  Future<void> shareTopProductsCsv({
    required List<TopProduct> productos,
    required String periodo,
  }) async {
    final bytes = await _buildCsvBytes(productos);
    final file = await _writeTempBytes('reporte_top_productos_$periodo.csv', bytes);
    await Share.shareXFiles(
      [XFile(file.path)], 
      subject: 'Reporte de productos más vendidos',
    );
  }

  Future<String> downloadTopProductsCsv({
    required List<TopProduct> productos,
    required String periodo,
  }) async {
    final bytes = await _buildCsvBytes(productos);
    final path = await FileSaver.instance.saveFile(
      name: 'reporte_top_productos_$periodo',
      bytes: bytes,
      ext: 'csv',
      mimeType: MimeType.csv,
    );
    return path;
  }

  // ---------- PDF ----------

  Future<Uint8List> _buildPdfBytes({
    required List<TopProduct> productos,
    required String tiendaNombre,
    required String periodoLabel,
  }) async {
    final doc = pw.Document();
    final fecha = DateTime.now();
    final fechaTexto = '${fecha.day}/${fecha.month}/${fecha.year}';

    doc.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(32),
        build: (context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(tiendaNombre, style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 4),
              pw.Text('Reporte de productos más vendidos', style: const pw.TextStyle(fontSize: 14)),
              pw.Text(
                'Periodo: $periodoLabel · Generado el $fechaTexto',
                style: pw.TextStyle(fontSize: 10, color: PdfColors.grey600),
              ),
              pw.SizedBox(height: 20),
              pw.Table(
                border: pw.TableBorder.all(color: PdfColors.grey300, width: 0.5),
                columnWidths: const {
                  0: pw.FlexColumnWidth(1),
                  1: pw.FlexColumnWidth(4),
                  2: pw.FlexColumnWidth(2),
                },
                children: [
                  pw.TableRow(
                    decoration: const pw.BoxDecoration(color: PdfColors.green50),
                    children: [
                      _cell('#', bold: true),
                      _cell('Producto', bold: true),
                      _cell('Unidades', bold: true, align: pw.TextAlign.right),
                    ],
                  ),
                  for (var i = 0; i < productos.length; i++)
                    pw.TableRow(
                      children: [
                        _cell('${i + 1}'),
                        _cell(productos[i].nombre),
                        _cell('${productos[i].unidades}', align: pw.TextAlign.right),
                      ],
                    ),
                ],
              ),
              pw.SizedBox(height: 24),
              pw.Text(
                'Total de productos en el ranking: ${productos.length}',
                style: pw.TextStyle(fontSize: 10, color: PdfColors.grey600),
              ),
            ],
          );
        },
      ),
    );

    return doc.save();
  }

  Future<void> shareTopProductsPdf({
    required List<TopProduct> productos,
    required String tiendaNombre,
    required String periodoLabel,
  }) async {
    final bytes = await _buildPdfBytes(productos: productos, tiendaNombre: tiendaNombre, periodoLabel: periodoLabel);
    final file = await _writeTempBytes('reporte_top_productos_$periodoLabel.pdf', bytes);
    await Share.shareXFiles(
      [XFile(file.path)], 
      subject: 'Reporte de productos más vendidos',
    );
  }

  Future<String> downloadTopProductsPdf({
    required List<TopProduct> productos,
    required String tiendaNombre,
    required String periodoLabel,
  }) async {
    final bytes = await _buildPdfBytes(productos: productos, tiendaNombre: tiendaNombre, periodoLabel: periodoLabel);
    final path = await FileSaver.instance.saveFile(
      name: 'reporte_top_productos_$periodoLabel',
      bytes: bytes,
      ext: 'pdf',
      mimeType: MimeType.pdf,
    );
    return path;
  }

  pw.Widget _cell(String text, {bool bold = false, pw.TextAlign align = pw.TextAlign.left}) {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      child: pw.Text(
        text,
        textAlign: align,
        style: pw.TextStyle(fontSize: 11, fontWeight: bold ? pw.FontWeight.bold : pw.FontWeight.normal),
      ),
    );
  }

  Future<File> _writeTempBytes(String filename, Uint8List bytes) async {
    final dir = await getTemporaryDirectory();
    final file = File('${dir.path}/$filename');
    return file.writeAsBytes(bytes);
  }
}
