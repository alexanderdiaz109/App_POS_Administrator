/// Nombres de ruta como constantes. Nunca usar strings sueltos con
/// Navigator.pushNamed — siempre referenciar esta clase.
class RouteNames {
  RouteNames._();

  // Auth
  static const String login = '/login';
  static const String register = '/register';
  static const String forgotPassword = '/forgot-password';
  static const String onboarding = '/onboarding';

  // Shell principal (bottom nav)
  static const String mainShell = '/home';

  // Dashboard
  static const String dashboard = '/dashboard';

  // POS
  static const String pos = '/pos';
  static const String checkout = '/pos/checkout';
  static const String saleConfirmation = '/pos/confirmation';

  // Products
  static const String productList = '/products';
  static const String productForm = '/products/form';
  static const String productDetail = '/products/detail';

  // Inventory
  static const String inventoryAlerts = '/inventory/alerts';
  static const String categories = '/inventory/categories';

  // Cash register
  static const String cashRegister = '/cash-register';
  static const String cashRegisterDetail = '/cash-register/detail';

  // Reports
  static const String reports = '/reports';

  // Barcode scanner
  static const String scanner = '/scanner';

  // Receipts
  static const String receiptPreview = '/receipts/preview';

  // Suppliers (Premium)
  static const String suppliers = '/suppliers';
  static const String supplierForm = '/suppliers/form';
  static const String supplierDetail = '/suppliers/detail';
  static const String purchaseOrderPreview = '/suppliers/purchase-order';

  // Branches (Premium)
  static const String branches = '/branches';
  static const String branchForm = '/branches/form';

  // Users & roles (Premium)
  static const String usersRoles = '/users-roles';
  static const String userForm = '/users-roles/form';
  static const String auditLog = '/users-roles/audit-log';

  // Account
  static const String account = '/account';
  static const String changePlan = '/account/change-plan';
  static const String paymentHistory = '/account/payment-history';
  static const String suspended = '/account/suspended';
  static const String updatePaymentMethod = '/account/update-payment-method';
  static const String cancellationConfirmed = '/account/cancellation-confirmed';
  static const String notifications = '/account/notifications';
}
