import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../data/providers/auth_providers.dart';

class ForgotPasswordScreen extends ConsumerStatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  ConsumerState<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends ConsumerState<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _controller = TextEditingController();
  bool _loading = false;
  bool _enviado = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _handleSend() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _loading = true);
    final repo = ref.read(authRepositoryProvider);
    final result = await repo.sendPasswordReset(_controller.text.trim());
    if (!mounted) return;
    setState(() => _loading = false);

    result.when(
      success: (_) => setState(() => _enviado = true),
      failure: (message) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message), backgroundColor: AppColors.error),
        );
      },
    );
  }

  String? _validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) return 'Ingresa tu correo';
    final regex = RegExp(r'^[\w.+-]+@[\w-]+\.[\w.-]+$');
    if (!regex.hasMatch(value.trim())) return 'Correo inválido';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Recuperar contraseña')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.lg),
          child: _enviado ? _buildConfirmacion() : _buildFormulario(),
        ),
      ),
    );
  }

  Widget _buildFormulario() {
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Icon(Icons.lock_reset_outlined, size: 56, color: AppColors.primary),
          const SizedBox(height: AppSizes.md),
          Text('¿Olvidaste tu contraseña?', style: AppTextStyles.h1),
          const SizedBox(height: AppSizes.xs),
          Text(
            'Ingresa tu correo y te enviaremos un enlace para restablecerla.',
            style: AppTextStyles.bodySecondary,
          ),
          const SizedBox(height: AppSizes.xl),
          TextFormField(
            controller: _controller,
            decoration: const InputDecoration(
              labelText: 'Correo electrónico',
              prefixIcon: Icon(Icons.mail_outline),
            ),
            keyboardType: TextInputType.emailAddress,
            validator: _validateEmail,
          ),
          const SizedBox(height: AppSizes.lg),
          PrimaryButton(label: 'Enviar enlace', loading: _loading, onPressed: _handleSend),
        ],
      ),
    );
  }

  Widget _buildConfirmacion() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.mark_email_read_outlined, size: 72, color: AppColors.success),
        const SizedBox(height: AppSizes.lg),
        Text('Revisa tu correo', style: AppTextStyles.h1, textAlign: TextAlign.center),
        const SizedBox(height: AppSizes.sm),
        Text(
          'Te enviamos un enlace para restablecer tu contraseña. '
          'Si no lo ves, revisa la carpeta de spam.',
          style: AppTextStyles.bodySecondary,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppSizes.xl),
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Volver a iniciar sesión'),
        ),
      ],
    );
  }
}
