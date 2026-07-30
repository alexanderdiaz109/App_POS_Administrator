import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/models/product_attribute.dart';

/// Editor de campos personalizados (Plan Premium). Permite agregar pares
/// nombre/valor libres (ej. Talla → "M", Marca → "Nike", Caducidad →
/// "12/2026") sin depender de columnas fijas en la base de datos.
class DynamicAttributesEditor extends StatefulWidget {
  final List<ProductAttribute> initialAttributes;
  final ValueChanged<List<ProductAttribute>>? onChanged;

  const DynamicAttributesEditor({
    super.key,
    this.initialAttributes = const [],
    this.onChanged,
  });

  @override
  State<DynamicAttributesEditor> createState() => _DynamicAttributesEditorState();
}

class _DynamicAttributesEditorState extends State<DynamicAttributesEditor> {
  late List<ProductAttribute> _attributes;

  @override
  void initState() {
    super.initState();
    _attributes = List.of(widget.initialAttributes);
  }

  void _notifyChange() => widget.onChanged?.call(_attributes);

  void _addAttribute() {
    setState(() {
      _attributes.add(
        ProductAttribute(id: DateTime.now().microsecondsSinceEpoch.toString(), nombre: '', valor: ''),
      );
    });
    _notifyChange();
  }

  void _removeAttribute(String id) {
    setState(() => _attributes.removeWhere((a) => a.id == id));
    _notifyChange();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const Text('Atributos personalizados', style: AppTextStyles.h3),
                const SizedBox(width: 6),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: AppColors.secondary.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(AppSizes.radiusSm),
                  ),
                  child: const Text('Premium', style: AppTextStyles.caption),
                ),
              ],
            ),
            TextButton.icon(
              onPressed: _addAttribute,
              icon: const Icon(Icons.add, size: 18),
              label: const Text('Agregar'),
            ),
          ],
        ),
        const SizedBox(height: AppSizes.xs),
        const Text(
          'Ej. Talla, Marca, Caducidad — lo que necesites para este producto.',
          style: AppTextStyles.bodySecondary,
        ),
        const SizedBox(height: AppSizes.sm),
        if (_attributes.isEmpty)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(AppSizes.md),
            decoration: BoxDecoration(
              color: AppColors.surfaceAlt,
              borderRadius: BorderRadius.circular(AppSizes.radiusMd),
            ),
            child: const Text(
              'Sin atributos agregados todavía.',
              style: AppTextStyles.bodySecondary,
              textAlign: TextAlign.center,
            ),
          )
        else
          Column(
            children: _attributes.map((attr) {
              return Padding(
                padding: const EdgeInsets.only(bottom: AppSizes.sm),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2,
                      child: TextFormField(
                        initialValue: attr.nombre,
                        decoration: const InputDecoration(labelText: 'Nombre'),
                        onChanged: (v) {
                          attr.nombre = v;
                          _notifyChange();
                        },
                      ),
                    ),
                    const SizedBox(width: AppSizes.sm),
                    Expanded(
                      flex: 3,
                      child: TextFormField(
                        initialValue: attr.valor,
                        decoration: const InputDecoration(labelText: 'Valor'),
                        onChanged: (v) {
                          attr.valor = v;
                          _notifyChange();
                        },
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete_outline, color: AppColors.error),
                      onPressed: () => _removeAttribute(attr.id),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
      ],
    );
  }
}
