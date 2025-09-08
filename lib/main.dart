import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String username = '';
  String password = '';

  // Para mostrar mensaje de error
  String? errorMessage;


  void _login() {
    if (_formKey.currentState!.validate()) {
      if (username == 'admin' && password == '1234') {
        // Login correcto
        setState(() {
          errorMessage = null;
        });

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      } else {
        // Usuario o contraseña incorrectos
        setState(() {
          errorMessage = 'Usuario o contraseña incorrectos';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title: Text('Login')),
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Usuario'),
                validator: (value) => value == null || value.isEmpty ? 'Ingresa usuario' : null,
                onChanged: (val) => username = val,
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(labelText: 'Contraseña'),
                obscureText: true,
                validator: (value) => value == null || value.isEmpty ? 'Ingresa contraseña' : null,
                onChanged: (val) => password = val,
              ),
              SizedBox(height: 32),
                if (errorMessage != null)
                  Text(
                    errorMessage!,
                    style: TextStyle(color: Colors.red),
                  ),

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
  const HomePage({super.key});
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
    MenuOption('Pichonera', Icons.badge),
    MenuOption('Checklist Unidades', Icons.checklist),
  ];

  String _selectedOption = 'Pichonera';

  void _selectOption(String option) {
    setState(() {
      _selectedOption = option;
    });
    Navigator.pop(context); // Cierra el Drawer
    if (option == 'Pichonera') {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PichoneraForm()),
    );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //title: Text('Menú - $_selectedOption'),
      ),
      drawer: Drawer(
        width: 250,
        child: ListView(
          children: [
            DrawerHeader(
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
          Divider(),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Configuración'),
            onTap: () {
              // Acción para configuración
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Cerrar sesión'),
            onTap: () {
              // Acción para cerrar sesión
            },
          ),
        ],
      ),
    ),
    body: Center(
      child: Text('Bienvenido'),
    ),
  );
 }
}



class PichoneraForm extends StatefulWidget {
  const PichoneraForm({super.key});

  @override
  State<PichoneraForm> createState() => _PichoneraFormState();
  }


class _PichoneraFormState extends State<PichoneraForm> {
  final TextEditingController datoController = TextEditingController();
  final TextEditingController otroCampoController = TextEditingController();
  final TextEditingController textoAbajoController = TextEditingController();

  String nombre = 'Nombre de la pichonera';
  String? imagenUrl; // Aquí podrías cargar una imagen desde red o local

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Formulario de Pichoneras')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Parte superior: dos columnas
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Columna izquierda
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        controller: datoController,
                        decoration: InputDecoration(labelText: 'Dato'),
                      ),
                      SizedBox(height: 16),
                      Text('Nombre: $nombre'),
                      SizedBox(height: 16),
                      Container(
                        width: 100,
                        height: 100,
                        color: Colors.grey[300],
                        child: imagenUrl != null
                            ? Image.network(imagenUrl!)
                            : Icon(Icons.image, size: 48),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 16),
                // Columna derecha
                Expanded(
                  child: TextFormField(
                    controller: otroCampoController,
                    decoration: InputDecoration(labelText: 'Otro campo'),
                  ),
                ),
              ],
            ),
            SizedBox(height: 24),
            // Campo de texto abajo
            TextFormField(
              controller: textoAbajoController,
              decoration: InputDecoration(labelText: 'Datos adicionales'),
              maxLines: 3,
            ),
            SizedBox(height: 24),
            // Botón para tomar foto
            ElevatedButton.icon(
              onPressed: () {
                // Aquí iría la lógica para tomar foto
              },
              icon: Icon(Icons.camera_alt),
              label: Text('Tomar foto'),
            ),
            Spacer(),
            // Botón de guardar
            ElevatedButton(
              onPressed: () {
                // Guardar datos
              },
              child: Text('Guardar'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 48),
              ),
            ),
          ],
        ),
      ),
    );
  }
}