// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:sp_movil/main.dart';


void main() {
  testWidgets('Login exitoso navega a HomePage', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());

    // Verifica que estamos en la pantalla de Login
    expect(find.text('Login'), findsOneWidget);

    // Ingresa texto en los campos de usuario y contraseña
    await tester.enterText(find.byType(TextFormField).at(0), 'usuario');
    await tester.enterText(find.byType(TextFormField).at(1), 'contraseña');

    // Toca el botón "Entrar"
    await tester.tap(find.text('Entrar'));
    await tester.pumpAndSettle(); // Espera animaciones y navegación

    // Verifica que estamos en la pantalla Home
    expect(find.textContaining('Has seleccionado'), findsOneWidget);
  });
}