/// Niveles de suscripción disponibles.
enum PlanLevel { basico, medio, premium }

extension PlanLevelX on PlanLevel {
  String get nombre {
    switch (this) {
      case PlanLevel.basico:
        return 'Básico';
      case PlanLevel.medio:
        return 'Medio';
      case PlanLevel.premium:
        return 'Premium';
    }
  }

  /// Usado para comparar planes (p. ej. detectar un downgrade) sin
  /// depender del orden de declaración del enum.
  int get valorNumerico {
    switch (this) {
      case PlanLevel.basico:
        return 0;
      case PlanLevel.medio:
        return 1;
      case PlanLevel.premium:
        return 2;
    }
  }
}

/// Feature flags por plan. Cada pantalla que dependa de una limitación de
/// negocio debe leer esto en vez de hardcodear el nivel del plan — así toda
/// la lógica de "qué se ve según el plan" vive en un solo lugar.
class PlanFeatures {
  final bool costosYGanancias;
  final bool alertasStockBajo;
  final bool categoriasPersonalizadas;
  final bool atributosDinamicos;
  final bool lectorCodigoBarras;
  final bool reportesAvanzados;
  final bool exportacionDatos;
  final bool proveedoresYCompras;
  final bool sucursales;
  final bool multiusuario;

  const PlanFeatures({
    required this.costosYGanancias,
    required this.alertasStockBajo,
    required this.categoriasPersonalizadas,
    required this.atributosDinamicos,
    required this.lectorCodigoBarras,
    required this.reportesAvanzados,
    required this.exportacionDatos,
    required this.proveedoresYCompras,
    required this.sucursales,
    required this.multiusuario,
  });

  static const _basico = PlanFeatures(
    costosYGanancias: false,
    alertasStockBajo: false,
    categoriasPersonalizadas: false,
    atributosDinamicos: false,
    lectorCodigoBarras: false,
    reportesAvanzados: false,
    exportacionDatos: false,
    proveedoresYCompras: false,
    sucursales: false,
    multiusuario: false,
  );

  static const _medio = PlanFeatures(
    costosYGanancias: true,
    alertasStockBajo: true,
    categoriasPersonalizadas: true,
    atributosDinamicos: false,
    lectorCodigoBarras: true,
    reportesAvanzados: true,
    exportacionDatos: false,
    proveedoresYCompras: false,
    sucursales: false,
    multiusuario: false,
  );

  static const _premium = PlanFeatures(
    costosYGanancias: true,
    alertasStockBajo: true,
    categoriasPersonalizadas: true,
    atributosDinamicos: true,
    lectorCodigoBarras: true,
    reportesAvanzados: true,
    exportacionDatos: true,
    proveedoresYCompras: true,
    sucursales: true,
    multiusuario: true,
  );

  static PlanFeatures forPlan(PlanLevel nivel) {
    switch (nivel) {
      case PlanLevel.basico:
        return _basico;
      case PlanLevel.medio:
        return _medio;
      case PlanLevel.premium:
        return _premium;
    }
  }
}

extension PlanLevelFromInt on int {
  PlanLevel toPlanLevel() {
    switch (this) {
      case 3:
        return PlanLevel.premium;
      case 2:
        return PlanLevel.medio;
      default:
        return PlanLevel.basico;
    }
  }
}

