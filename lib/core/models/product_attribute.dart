/// Un atributo dinámico de producto (Plan Premium, sección 1.1: "Atributos
/// dinámicos por producto — campos personalizados en JSON, ej. talla,
/// marca, caducidad"). En backend esto se guarda como JSON en el producto.
class ProductAttribute {
  final String id;
  String nombre;
  String valor;

  ProductAttribute({
    required this.id,
    required this.nombre,
    required this.valor,
  });

  Map<String, dynamic> toJson() => {'nombre': nombre, 'valor': valor};
}
