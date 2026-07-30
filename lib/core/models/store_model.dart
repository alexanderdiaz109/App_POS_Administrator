import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/plan_limits.dart';

/// Espeja `estado_pago` en la tabla `Tiendas` (sección 2.1). Se agrega
/// `prueba` para el periodo de 15 días gratis (sección 4.1).
enum EstadoPago { prueba, activo, enGracia, suspendido, cancelado }

extension EstadoPagoX on EstadoPago {
  String get etiqueta {
    switch (this) {
      case EstadoPago.prueba:
        return 'Periodo de prueba';
      case EstadoPago.activo:
        return 'Activo';
      case EstadoPago.enGracia:
        return 'En periodo de gracia';
      case EstadoPago.suspendido:
        return 'Suspendido';
      case EstadoPago.cancelado:
        return 'Cancelado';
    }
  }

  Color get color {
    switch (this) {
      case EstadoPago.prueba:
        return AppColors.primary;
      case EstadoPago.activo:
        return AppColors.statusActivo;
      case EstadoPago.enGracia:
        return AppColors.statusGracia;
      case EstadoPago.suspendido:
        return AppColors.statusSuspendido;
      case EstadoPago.cancelado:
        return AppColors.statusCancelado;
    }
  }
}

/// Datos mínimos de tienda/suscripción que necesita el frontend.
/// TODO(backend): reemplazar por el modelo real que venga de Supabase.
class StoreModel {
  final String nombre;
  final PlanLevel nivelPlan;
  final EstadoPago estadoPago;
  final DateTime? fechaProximoCobro;
  final DateTime? fechaFinGracia;
  final DateTime? fechaFinPrueba;

  const StoreModel({
    required this.nombre,
    required this.nivelPlan,
    required this.estadoPago,
    this.fechaProximoCobro,
    this.fechaFinGracia,
    this.fechaFinPrueba,
  });

  int get diasRestantesPrueba {
    if (fechaFinPrueba == null) return 0;
    final diff = fechaFinPrueba!.difference(DateTime.now()).inDays;
    return diff < 0 ? 0 : diff;
  }

  static final StoreModel mockActivo = StoreModel(
    nombre: 'Abarrotes La Esquina',
    nivelPlan: PlanLevel.medio,
    estadoPago: EstadoPago.activo,
    fechaProximoCobro: DateTime.now().add(const Duration(days: 18)),
  );

  // TODO(backend): usar este mock para probar el banner de prueba gratuita.
  static final StoreModel mockPrueba = StoreModel(
    nombre: 'Abarrotes La Esquina',
    nivelPlan: PlanLevel.medio,
    estadoPago: EstadoPago.prueba,
    fechaFinPrueba: DateTime.now().add(const Duration(days: 6)),
  );
}
