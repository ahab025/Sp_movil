import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sp_Movil',
      theme: ThemeData(
        primaryColor: Color(0xFF2A348F),
      ),
      home: LoginPage(),
    );
  }
}

// Página de Login sencilla
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String username = '';
  String password = '';

  void _login() {
    if (_formKey.currentState!.validate()) {
      // Aquí puedes poner lógica real de login
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Usuario'),
                validator: (value) => value!.isEmpty ? 'Ingresa usuario' : null,
                onChanged: (val) => username = val,
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(labelText: 'Contraseña'),
                obscureText: true,
                validator: (value) => value!.isEmpty ? 'Ingresa contraseña' : null,
                onChanged: (val) => password = val,
              ),
              SizedBox(height: 32),
              ElevatedButton(
                onPressed: _login,
                child: Text('Entrar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Página Home con Drawer (menú hamburguesa)
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

// Opciones del menú
class MenuOption {
  final String title;
  final IconData icon;
  MenuOption(this.title, this.icon);
}

class _HomePageState extends State<HomePage> {
  // Lista de opciones del Drawer
  List<MenuOption> options = [
    MenuOption('Opción 1', Icons.home),
    MenuOption('Opción 2', Icons.settings),
  ];

  String _selectedOption = 'Opción 1';

  void _selectOption(String option) {
    setState(() {
      _selectedOption = option;
    });
    Navigator.pop(context); // Cierra el Drawer
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menú - $_selectedOption'),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text(
                'Menú',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ...options.map((option) {
              return ListTile(
                leading: Icon(option.icon),
                title: Text(option.title),
                selected: _selectedOption == option.title,
                onTap: () => _selectOption(option.title),
              );
            }).toList(),
            Divider(),
            ListTile(
              leading: Icon(Icons.add),
              title: Text('Agregar opción'),
              onTap: () {
                // Aquí mostramos un diálogo para agregar opción
                _showAddOptionDialog();
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Text(
          'Has seleccionado: $_selectedOption',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }

  void _showAddOptionDialog() {
    String newOption = '';
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Agregar nueva opción'),
        content: TextField(
          autofocus: true,
          decoration: InputDecoration(hintText: 'Nombre de la opción'),
          onChanged: (value) {
            newOption = value;
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context), // Cerrar diálogo
            child: Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              if (newOption.trim().isNotEmpty) {
                setState(() {
                  options.add(MenuOption(newOption.trim(), Icons.star));
                });
                Navigator.pop(context);
              }
            },
            child: Text('Agregar'),
          ),
        ],
      ),
    );
  }
}
