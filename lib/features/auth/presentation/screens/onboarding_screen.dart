import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/routes/route_names.dart';
import '../../../../core/widgets/primary_button.dart';
import '../widgets/onboarding_step.dart';

/// Primeros pasos tras registrarse. Evita que el dueño llegue directo a un
/// dashboard vacío y confuso — explica en 3 pasos qué puede hacer.
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _controller = PageController();
  int _page = 0;

  static const _steps = [
    OnboardingStep(
      icon: Icons.inventory_2_outlined,
      title: 'Agrega tus productos',
      description: 'Registra tu catálogo con nombre, precio y stock actual para empezar a vender.',
    ),
    OnboardingStep(
      icon: Icons.point_of_sale_outlined,
      title: 'Vende en segundos',
      description: 'Busca el producto, cobra y listo. Todo desde tu celular o tablet en el mostrador.',
    ),
    OnboardingStep(
      icon: Icons.bar_chart_outlined,
      title: 'Consulta tus ventas',
      description: 'Revisa tu corte de caja y tus productos más vendidos, estés o no en la tienda.',
    ),
  ];

  void _next() {
    if (_page == _steps.length - 1) {
      Navigator.of(context).pushNamedAndRemoveUntil(RouteNames.mainShell, (_) => false);
    } else {
      _controller.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: TextButton(
                onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil(RouteNames.mainShell, (_) => false),
                child: const Text('Omitir'),
              ),
            ),
            Expanded(
              child: PageView(
                controller: _controller,
                onPageChanged: (i) => setState(() => _page = i),
                children: _steps
                    .map((step) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: AppSizes.lg),
                          child: step,
                        ))
                    .toList(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(AppSizes.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(_steps.length, (i) {
                      final activo = i == _page;
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: activo ? 20 : 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: activo ? AppColors.primary : AppColors.divider,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: AppSizes.lg),
                  PrimaryButton(
                    label: _page == _steps.length - 1 ? 'Empezar' : 'Siguiente',
                    onPressed: _next,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
