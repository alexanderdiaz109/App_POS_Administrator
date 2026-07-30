import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/constants/plan_limits.dart';
import '../../../../core/models/product_attribute.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../../core/utils/result.dart';
import '../../../../core/widgets/subscription_blocked_dialog.dart';
import '../../../account/data/providers/plan_features_provider.dart';
import '../../../account/data/providers/store_providers.dart';
import '../../../inventory/data/providers/category_providers.dart';
import '../../data/providers/product_providers.dart';
import '../../domain/entities/product.dart';
import '../widgets/dynamic_attributes_editor.dart';

/// Formulario de producto. Si `existingProduct` no es null, es edición;
/// si es null, es alta. Los campos de costo/atributos se ocultan según
/// el plan real de la tienda (sección 1.1).
class ProductFormScreen extends ConsumerStatefulWidget {
  final Product? existingProduct;
  const ProductFormScreen({super.key, this.existingProduct});

  @override
  ConsumerState<ProductFormScreen> createState() => _ProductFormScreenState();
}

class _ProductFormScreenState extends ConsumerState<ProductFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nombreController;
  late final TextEditingController _precioController;
  late final TextEditingController _stockController;
  late final TextEditingController _costoController;
  late final TextEditingController _stockMinimoController;
  String? _categoriaId;
  List<ProductAttribute> _atributos = [];
  bool _loading = false;

  bool get _esEdicion => widget.existingProduct != null;

  @override
  void initState() {
    super.initState();
    final p = widget.existingProduct;
    _nombreController = TextEditingController(text: p?.nombre ?? '');
    _precioController = TextEditingController(text: p?.precioVenta.toString() ?? '');
    _stockController = TextEditingController(text: p?.stockActual.toString() ?? '');
    _costoController = TextEditingController(text: p?.costoCompra?.toString() ?? '');
    _stockMinimoController = TextEditingController(text: p?.stockMinimo?.toString() ?? '');
    _categoriaId = p?.categoriaId;
    if (p?.atributos != null) {
      _atributos = p!.atributos!.entries
          .map((e) => ProductAttribute(
                id: e.key,
                nombre: e.key,
                valor: e.value.toString(),
              ))
          .toList();
    }
  }

  @override
  void dispose() {
    _nombreController.dispose();
    _precioController.dispose();
    _stockController.dispose();
    _costoController.dispose();
    _stockMinimoController.dispose();
    super.dispose();
  }

  Future<void> _handleSave() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _loading = true);
    final store = await ref.read(currentStoreProvider.future);

    final atributosMap = {for (var a in _atributos) if (a.nombre.isNotEmpty) a.nombre: a.valor};

    final product = Product(
      id: widget.existingProduct?.id ?? '',
      storeId: store.id,
      categoriaId: _categoriaId,
      nombre: _nombreController.text.trim(),
      precioVenta: double.parse(_precioController.text),
      costoCompra: _costoController.text.isEmpty ? null : double.parse(_costoController.text),
      stockActual: int.parse(_stockController.text),
      stockMinimo: _stockMinimoController.text.isEmpty ? null : int.parse(_stockMinimoController.text),
      atributos: atributosMap.isEmpty ? null : atributosMap,
    );

    final controller = ref.read(productListControllerProvider.notifier);
    final error = _esEdicion ? await controller.editProduct(product) : await controller.addProduct(product);

    if (!mounted) return;
    setState(() => _loading = false);

    if (error != null) {
      final friendlyError = SubscriptionErrorTranslator.translate(error);
      if (mounted) {
        await SubscriptionBlockedDialog.show(context, friendlyError);
      }
      return;
    }
    Navigator.of(context).pop();
  }

  String? _requiredNumber(String? value) {
    if (value == null || value.trim().isEmpty) return 'Requerido';
    if (double.tryParse(value) == null) return 'Número inválido';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final featuresAsync = ref.watch(currentPlanFeaturesProvider);
    final categoriesAsync = ref.watch(categoryListControllerProvider);

    return Scaffold(
      appBar: AppBar(title: Text(_esEdicion ? 'Editar producto' : 'Nuevo producto')),
      body: featuresAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text('$err')),
        data: (features) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(AppSizes.md),
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    controller: _nombreController,
                    decoration: const InputDecoration(labelText: 'Nombre del producto'),
                    validator: (v) => (v == null || v.trim().isEmpty) ? 'Requerido' : null,
                  ),
                  const SizedBox(height: AppSizes.md),
                  TextFormField(
                    controller: _precioController,
                    decoration: const InputDecoration(labelText: 'Precio de venta'),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    validator: _requiredNumber,
                  ),
                  const SizedBox(height: AppSizes.md),
                  TextFormField(
                    controller: _stockController,
                    decoration: const InputDecoration(labelText: 'Stock actual'),
                    keyboardType: TextInputType.number,
                    validator: _requiredNumber,
                  ),
                  if (features.costosYGanancias) ...[
                    const SizedBox(height: AppSizes.md),
                    TextFormField(
                      controller: _costoController,
                      decoration: const InputDecoration(labelText: 'Costo de compra'),
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    ),
                  ],
                  if (features.alertasStockBajo) ...[
                    const SizedBox(height: AppSizes.md),
                    TextFormField(
                      controller: _stockMinimoController,
                      decoration: const InputDecoration(labelText: 'Stock mínimo (alerta)'),
                      keyboardType: TextInputType.number,
                    ),
                  ],
                  if (features.categoriasPersonalizadas) ...[
                    const SizedBox(height: AppSizes.md),
                    categoriesAsync.when(
                      loading: () => const LinearProgressIndicator(),
                      error: (_, __) => const SizedBox.shrink(),
                      data: (categories) => DropdownButtonFormField<String>(
                        value: _categoriaId,
                        decoration: const InputDecoration(labelText: 'Categoría'),
                        items: categories
                            .map((c) => DropdownMenuItem(value: c.id, child: Text(c.nombre)))
                            .toList(),
                        onChanged: (v) => setState(() => _categoriaId = v),
                      ),
                    ),
                  ],
                  if (features.atributosDinamicos) ...[
                    const SizedBox(height: AppSizes.lg),
                    DynamicAttributesEditor(
                      initialAttributes: _atributos,
                      onChanged: (attrs) => _atributos = attrs,
                    ),
                  ],
                  const SizedBox(height: AppSizes.lg),
                  PrimaryButton(
                    label: _esEdicion ? 'Guardar cambios' : 'Guardar producto',
                    loading: _loading,
                    onPressed: _handleSave,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
