import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'splash_screen.dart';
import '../routes/route_names.dart';
import '../../features/auth/data/providers/auth_providers.dart';
import '../../features/account/data/providers/store_providers.dart';

class SessionGate extends ConsumerWidget {
  const SessionGate({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authControllerProvider);

    return authState.when(
      loading: () => const SplashScreen(),
      error: (_, __) => const _RedirectTo(RouteNames.login),
      data: (user) {
        if (user == null) return const _RedirectTo(RouteNames.login);
        return const _StoreStatusCheck();
      },
    );
  }
}

class _StoreStatusCheck extends ConsumerWidget {
  const _StoreStatusCheck();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final storeAsync = ref.watch(currentStoreProvider);

    return storeAsync.when(
      loading: () => const SplashScreen(),
      error: (_, __) => const _RedirectTo(RouteNames.mainShell),
      data: (store) {
        if (store.estadoPago == 'suspendido') {
          return const _RedirectTo(RouteNames.suspended);
        }
        return const _RedirectTo(RouteNames.mainShell);
      },
    );
  }
}

class _RedirectTo extends StatefulWidget {
  final String route;
  const _RedirectTo(this.route);

  @override
  State<_RedirectTo> createState() => _RedirectToState();
}

class _RedirectToState extends State<_RedirectTo> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.of(context).pushReplacementNamed(widget.route);
    });
  }

  @override
  Widget build(BuildContext context) {
    return const SplashScreen();
  }
}
