import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'pantallas/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sp_Movil',
      theme: ThemeData(
        primaryColor: const Color(0xFF2A348F),
      ),
      home: const LoginPage(),
    );
  }
}
