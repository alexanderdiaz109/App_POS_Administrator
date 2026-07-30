import 'package:flutter/material.dart';
import '../../features/account/presentation/screens/notifications_screen.dart';
import '../../features/account/presentation/screens/account_screen.dart';
import '../../features/account/presentation/screens/cancellation_confirmed_screen.dart';
import '../../features/account/presentation/screens/change_plan_screen.dart';
import '../../features/account/presentation/screens/payment_history_screen.dart';
import '../../features/account/presentation/screens/suspended_screen.dart';
import '../../features/account/presentation/screens/update_payment_method_screen.dart';
import '../../features/auth/presentation/screens/forgot_password_screen.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/onboarding_screen.dart';
import '../../features/auth/presentation/screens/register_screen.dart';
import '../../features/barcode_scanner/presentation/screens/scanner_screen.dart';
import '../../features/branches/presentation/screens/branches_screen.dart';
import '../../features/cash_register/presentation/screens/cash_register_detail_screen.dart';
import '../../features/cash_register/presentation/screens/cash_register_screen.dart';
import '../../features/dashboard/presentation/screens/dashboard_screen.dart';
import '../../features/inventory/presentation/screens/categories_screen.dart';
import '../../features/inventory/presentation/screens/inventory_alerts_screen.dart';
import '../../features/pos/presentation/screens/checkout_screen.dart';
import '../../features/pos/presentation/screens/pos_screen.dart';
import '../../features/pos/domain/entities/sale_result.dart';
import '../../features/pos/presentation/screens/sale_confirmation_screen.dart';
import '../../features/products/domain/entities/product.dart';
import '../../features/products/presentation/screens/product_detail_screen.dart';
import '../../features/products/presentation/screens/product_form_screen.dart';
import '../../features/products/presentation/screens/product_list_screen.dart';
import '../../features/receipts/presentation/screens/receipt_preview_screen.dart';
import '../../features/reports/presentation/screens/reports_screen.dart';
import '../../features/suppliers/presentation/screens/supplier_detail_screen.dart';
import '../../features/suppliers/presentation/screens/suppliers_screen.dart';
import '../../features/users_roles/presentation/screens/audit_log_screen.dart';
import '../../features/users_roles/presentation/screens/users_roles_screen.dart';
import '../widgets/app_shell_with_status_guard.dart';
import '../widgets/main_shell.dart';
import 'route_names.dart';

/// onGenerateRoute centralizado. Ninguna pantalla navega con MaterialPageRoute
/// directo — todo pasa por RouteNames + este router.
class AppRouter {
  AppRouter._();

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.login:
        return _route(const LoginScreen());
      case RouteNames.register:
        return _route(const RegisterScreen());
      case RouteNames.forgotPassword:
        return _route(const ForgotPasswordScreen());
      case RouteNames.onboarding:
        return _route(const OnboardingScreen());

      case RouteNames.mainShell:
        return _route(const AppShellWithStatusGuard());

      case RouteNames.dashboard:
        return _route(const DashboardScreen());

      case RouteNames.pos:
        return _route(const PosScreen());
      case RouteNames.checkout:
        return _route(const CheckoutScreen());
      case RouteNames.saleConfirmation:
        final result = settings.arguments as SaleResult;
        return _route(SaleConfirmationScreen(result: result));

      case RouteNames.productList:
        return _route(const ProductListScreen());
      case RouteNames.productForm:
        final product = settings.arguments as Product?;
        return _route(ProductFormScreen(existingProduct: product));
      case RouteNames.productDetail:
        final productId = settings.arguments as String;
        return _route(ProductDetailScreen(productId: productId));

      case RouteNames.inventoryAlerts:
        return _route(const InventoryAlertsScreen());
      case RouteNames.categories:
        return _route(const CategoriesScreen());

      case RouteNames.cashRegister:
        return _route(const CashRegisterScreen());
      case RouteNames.cashRegisterDetail:
        return _route(const CashRegisterDetailScreen());

      case RouteNames.reports:
        return _route(const ReportsScreen());

      case RouteNames.scanner:
        return _route(const ScannerScreen());

      case RouteNames.receiptPreview:
        final saleId = settings.arguments as String;
        return _route(ReceiptPreviewScreen(saleId: saleId));

      case RouteNames.suppliers:
        return _route(const SuppliersScreen());
      case RouteNames.supplierDetail:
        final supplierId = settings.arguments as String;
        return _route(SupplierDetailScreen(supplierId: supplierId));

      case RouteNames.branches:
        return _route(const BranchesScreen());

      case RouteNames.usersRoles:
        return _route(const UsersRolesScreen());
      case RouteNames.auditLog:
        return _route(const AuditLogScreen());

      case RouteNames.account:
        return _route(const AccountScreen());
      case RouteNames.changePlan:
        return _route(const ChangePlanScreen());
      case RouteNames.paymentHistory:
        return _route(const PaymentHistoryScreen());
      case RouteNames.suspended:
        return _route(const SuspendedScreen());
      case RouteNames.updatePaymentMethod:
        return _route(const UpdatePaymentMethodScreen());
      case RouteNames.cancellationConfirmed:
        return _route(const CancellationConfirmedScreen());
      case RouteNames.notifications:
        return _route(const NotificationsScreen());

      default:
        // Cuando la app se abre fría desde un deep link (posapp://...),
        // Flutter puede recibir la URL completa como ruta inicial en vez
        // de pasar por SessionGate. La detectamos aquí y mandamos a Home.
        if (settings.name != null && settings.name!.contains('status=')) {
          return _route(const AppShellWithStatusGuard());
        }
        return _route(
          Scaffold(
            body: Center(child: Text('Ruta no encontrada: ${settings.name}')),
          ),
        );
    }
  }

  static MaterialPageRoute<void> _route(Widget screen) {
    return MaterialPageRoute(builder: (_) => screen);
  }
}
