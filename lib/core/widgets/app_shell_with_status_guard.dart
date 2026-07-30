import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../routes/route_names.dart';
import 'main_shell.dart';
import '../../features/account/data/providers/store_providers.dart';

/// Envuelve MainShell y vigila el estado de pago de la tienda en todo
/// momento. Si en cualquier punto detecta 'suspendido' (por ejemplo,
/// el cron de gracia vencida corrió mientras la app estaba abierta),
/// redirige automáticamente a la pantalla de bloqueo.
class AppShellWithStatusGuard extends ConsumerWidget {
  const AppShellWithStatusGuard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(currentStoreProvider, (previous, next) {
      next.whenData((store) {
        if (store.estadoPago == 'suspendido') {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.of(context).pushNamedAndRemoveUntil(
              RouteNames.suspended,
              (route) => false,
            );
          });
        }
      });
    });

    return const MainShell();
  }
}
