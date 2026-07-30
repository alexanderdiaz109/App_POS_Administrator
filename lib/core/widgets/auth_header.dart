import 'package:flutter/material.dart';
import '../constants/app_sizes.dart';

/// Header curvo con degradado de marca, usado en las pantallas de auth.
/// El contenido (logo, título) se pasa como children para reutilizarlo
/// entre Login, Registro, etc. con distinto contenido interno.
class AuthHeader extends StatelessWidget {
  final double height;
  final Widget child;

  const AuthHeader({super.key, required this.height, required this.child});

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: _CurvedBottomClipper(),
      child: Container(
        width: double.infinity,
        height: height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF16A34A), Color(0xFF14532D)],
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: AppSizes.lg),
        child: SafeArea(bottom: false, child: child),
      ),
    );
  }
}

class _CurvedBottomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - 40);
    path.quadraticBezierTo(
      size.width / 2,
      size.height + 20,
      size.width,
      size.height - 40,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
