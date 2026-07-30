import 'package:flutter/material.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/widgets/primary_button.dart';

/// Alta de una nueva sucursal bajo la cuenta maestra (Plan Premium).
class BranchFormScreen extends StatefulWidget {
  const BranchFormScreen({super.key});

  @override
  State<BranchFormScreen> createState() => _BranchFormScreenState();
}

class _BranchFormScreenState extends State<BranchFormScreen> {
  bool _loading = false;

  void _handleSave() {
    setState(() => _loading = true);
    // TODO(backend): crear la sucursal en Supabase bajo el store maestro.
    Future.delayed(const Duration(milliseconds: 600), () {
      if (!mounted) return;
      setState(() => _loading = false);
      Navigator.of(context).pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nueva sucursal')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSizes.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const TextField(decoration: InputDecoration(labelText: 'Nombre de la sucursal')),
            const SizedBox(height: AppSizes.md),
            const TextField(decoration: InputDecoration(labelText: 'Dirección')),
            const SizedBox(height: AppSizes.md),
            const TextField(
              decoration: InputDecoration(labelText: 'Teléfono de contacto'),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: AppSizes.lg),
            const Text(
              'Los productos, ventas y corte de caja de esta sucursal se manejan por separado del resto.',
              style: AppTextStyles.bodySecondary,
            ),
            const SizedBox(height: AppSizes.lg),
            PrimaryButton(label: 'Crear sucursal', loading: _loading, onPressed: _handleSave),
          ],
        ),
      ),
    );
  }
}
