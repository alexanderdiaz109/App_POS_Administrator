import 'dart:async';
import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../routes/route_names.dart';
import '../../features/account/data/providers/store_providers.dart';
import '../../features/account/data/providers/plan_providers.dart';
import '../../features/account/data/providers/payment_providers.dart';

/// Escucha deep links (posapp://payment-result/...) para detectar cuando
/// el usuario regresa del checkout de Stripe, y refresca el estado real
/// de la tienda sin que tenga que cerrar y volver a abrir la app.
class DeepLinkService {
  final AppLinks _appLinks = AppLinks();
  StreamSubscription<Uri>? _subscription;

  void init(BuildContext context, WidgetRef ref, GlobalKey<NavigatorState> navigatorKey) {
    // Caso 1: la app ya estaba abierta y el usuario regresa por el deep link.
    _subscription = _appLinks.uriLinkStream.listen((uri) {
      _handleUri(uri, ref, navigatorKey);
    });

    // Caso 2: la app estaba cerrada y se abrió por el deep link (cold start).
    _appLinks.getInitialLink().then((uri) {
      if (uri != null) {
        _handleUri(uri, ref, navigatorKey);
      }
    });
  }

  void _handleUri(Uri uri, WidgetRef ref, GlobalKey<NavigatorState> navigatorKey) {
    if (uri.scheme != 'posapp' || uri.host != 'payment-result') return;

    ref.invalidate(currentStoreProvider);
    ref.invalidate(availablePlansProvider);
    ref.invalidate(paymentHistoryProvider);

    final status = uri.queryParameters['status'];
    String message;
    switch (status) {
      case 'success':
        message = '¡Pago procesado! Actualizando tu plan...';
        break;
      case 'portal-closed':
        message = 'Actualizando tu información de pago...';
        break;
      default:
        message = 'Regresaste sin completar la acción.';
    }

    final navigatorState = navigatorKey.currentState;
    if (navigatorState != null) {
      navigatorState.popUntil((route) => route.settings.name == RouteNames.account || route.isFirst);
      ScaffoldMessenger.of(navigatorState.context).showSnackBar(SnackBar(content: Text(message)));
    }
  }

  void dispose() {
    _subscription?.cancel();
  }
}
