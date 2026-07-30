/// Resultado explícito de una operación: éxito con datos, o falla con
/// un mensaje. Evita try/catch disperso en la UI — cada repositorio
/// regresa un Result y el provider decide qué hacer con cada caso.
sealed class Result<T> {
  const Result();

  const factory Result.success(T data) = Success<T>;
  const factory Result.failure(String message) = Failure<T>;

  R when<R>({
    required R Function(T data) success,
    required R Function(String message) failure,
  }) {
    return switch (this) {
      Success<T>(data: final data) => success(data),
      Failure<T>(message: final message) => failure(message),
    };
  }
}

final class Success<T> extends Result<T> {
  final T data;
  const Success(this.data);
}

final class Failure<T> extends Result<T> {
  final String message;
  const Failure(this.message);
}

/// Detecta si un error viene de un bloqueo de suscripción (RLS o
/// validación en un RPC) y lo traduce a un mensaje que el dueño de la
/// tienda entienda, en vez del error técnico de Postgres.
class SubscriptionErrorTranslator {
  SubscriptionErrorTranslator._();

  static String translate(String rawMessage) {
    final lower = rawMessage.toLowerCase();

    final esBloqueoRLS = lower.contains('row-level security') || lower.contains('42501');
    final esBloqueoRPC = lower.contains('la suscripción está');

    if (esBloqueoRPC) {
      if (lower.contains('suspendido')) {
        return 'Tu suscripción está suspendida por falta de pago. Actualiza tu método de pago para seguir vendiendo.';
      }
      if (lower.contains('cancelado')) {
        return 'Tu suscripción fue cancelada. Reactívala desde Mi Cuenta para seguir usando la app.';
      }
      return 'Tu suscripción no está activa. Ve a Mi Cuenta para regularizar tu pago.';
    }

    if (esBloqueoRLS) {
      return 'No puedes hacer esto en este momento. Tu suscripción podría estar suspendida — revisa Mi Cuenta.';
    }

    return rawMessage;
  }
}
