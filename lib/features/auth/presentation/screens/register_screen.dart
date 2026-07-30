import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/routes/route_names.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../data/providers/auth_providers.dart';

/// Alta de una tienda nueva (sección 4.1): crea `tiendas` con
/// estado_pago = 'prueba' y el usuario administrador, vía el RPC
/// crear_tienda_y_usuario.
class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _storeNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _loading = false;

  @override
  void dispose() {
    _storeNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleRegister() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _loading = true);
    final controller = ref.read(authControllerProvider.notifier);
    final error = await controller.signUp(
      _emailController.text.trim(),
      _passwordController.text,
      _storeNameController.text.trim(),
    );
    if (!mounted) return;
    setState(() => _loading = false);

    if (error != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error), backgroundColor: AppColors.error),
      );
      return;
    }

    Navigator.of(context).pushNamedAndRemoveUntil(RouteNames.onboarding, (_) => false);
  }

  String? _validateStoreName(String? value) {
    if (value == null || value.trim().isEmpty) return 'Ingresa el nombre de tu tienda';
    if (value.trim().length < 3) return 'Mínimo 3 caracteres';
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) return 'Ingresa tu correo';
    final regex = RegExp(r'^[\w.+-]+@[\w-]+\.[\w.-]+$');
    if (!regex.hasMatch(value.trim())) return 'Correo inválido';
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'Ingresa una contraseña';
    if (value.length < 6) return 'Mínimo 6 caracteres';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Crear cuenta')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSizes.lg),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text('Crea tu tienda', style: AppTextStyles.h1),
                const SizedBox(height: AppSizes.xs),
                Text(
                  '15 días de prueba gratis, sin tarjeta requerida',
                  style: AppTextStyles.bodySecondary,
                ),
                const SizedBox(height: AppSizes.xl),
                TextFormField(
                  controller: _storeNameController,
                  decoration: const InputDecoration(labelText: 'Nombre de la tienda'),
                  validator: _validateStoreName,
                ),
                const SizedBox(height: AppSizes.md),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: 'Correo electrónico'),
                  keyboardType: TextInputType.emailAddress,
                  validator: _validateEmail,
                ),
                const SizedBox(height: AppSizes.md),
                TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(labelText: 'Contraseña'),
                  obscureText: true,
                  validator: _validatePassword,
                ),
                const SizedBox(height: AppSizes.lg),
                PrimaryButton(label: 'Crear cuenta', loading: _loading, onPressed: _handleRegister),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
