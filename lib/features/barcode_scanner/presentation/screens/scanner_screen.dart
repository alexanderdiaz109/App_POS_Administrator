import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_text_styles.dart';

/// Lector de código de barras/QR con la cámara (Plan Medio+, sección 1.1).
/// La UI se diseña como si la cámara ya estuviera integrada (mobile_scanner);
/// el recuadro central es el "viewfinder" y el buscador manual de abajo es
/// el respaldo para cuando el código no se puede leer.
/// TODO(backend/paquete): conectar mobile_scanner real; hoy es solo el diseño.
class ScannerScreen extends StatelessWidget {
  const ScannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: const Text('Escanear código'),
        actions: [
          IconButton(icon: const Icon(Icons.flash_on_outlined), onPressed: () {}),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              alignment: Alignment.center,
              children: [
                // TODO: reemplazar por el widget de cámara real (MobileScanner).
                Container(color: Colors.black),
                Container(
                  width: 250,
                  height: 250,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 2),
                    borderRadius: BorderRadius.circular(AppSizes.radiusMd),
                  ),
                ),
                Positioned(
                  bottom: 32,
                  child: Text(
                    'Apunta la cámara al código de barras',
                    style: AppTextStyles.body.copyWith(color: Colors.white70),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(AppSizes.md),
            decoration: const BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.vertical(top: Radius.circular(AppSizes.radiusLg)),
            ),
            child: SafeArea(
              top: false,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text('¿No se lee el código?', style: AppTextStyles.h3),
                  const SizedBox(height: AppSizes.sm),
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Escribe el código manualmente',
                      prefixIcon: const Icon(Icons.keyboard_outlined),
                      suffixIcon: TextButton(onPressed: () {}, child: const Text('Buscar')),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppSizes.radiusMd),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
