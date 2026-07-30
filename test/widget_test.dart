import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:app_pos/main.dart';

void main() {
  testWidgets('App arranca en la pantalla de login', (WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(child: AppPos()));
    await tester.pumpAndSettle();

    expect(find.text('Bienvenido de vuelta'), findsOneWidget);
    expect(find.widgetWithText(ElevatedButton, 'Iniciar sesión'), findsOneWidget);
  });
}
