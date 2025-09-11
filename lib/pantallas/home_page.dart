import 'package:flutter/material.dart';
import '../modelos/menu_option.dart';
import 'pichonera_form.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<MenuOption> options = [
    MenuOption('Pichonera', Icons.badge),
    MenuOption('Checklist Unidades', Icons.checklist),
  ];

  String _selectedOption = 'Pichonera';

  void _selectOption(String option) {
    setState(() {
      _selectedOption = option;
    });
    Navigator.pop(context);

    if (option == 'Pichonera') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const PichoneraForm()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: Drawer(
        width: 250,
        child: ListView(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Color(0xFF2A348F)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.key, color: Colors.white, size: 48),
                  SizedBox(height: 8),
                ],
              ),
            ),
            ...options.map((option) => ListTile(
                  leading: Icon(option.icon),
                  title: Text(option.title),
                  onTap: () => _selectOption(option.title),
                )),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Configuración'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Cerrar sesión'),
              onTap: () {},
            ),
          ],
        ),
      ),
      body: const Center(
        child: Text('Bienvenido'),
      ),
    );
  }
}
