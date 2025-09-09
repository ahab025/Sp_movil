import 'package:flutter/material.dart';
import 'package:flutter/services.dart';



//void main() {
  //runApp(MyApp());
//}
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
  final TextEditingController campoTextoController = TextEditingController();
  final TextEditingController campoAdicionalController = TextEditingController();

  String etiquetaTexto = 'Nombre de la pichonera';
  String etiquetaDerecha = 'Código: P-09';
  String etiquetaAbajo = 'Observaciones generales';
  String? imagenUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Formulario de Pichoneras'), centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // 🔷 Dos Cards en la parte superior
            Row(
              children: [
                // Card izquierda
                Expanded(
                  child: Card(
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextFormField(
                            controller: campoTextoController,
                            decoration: const InputDecoration(labelText: 'Dato'),
                          ),
                          const SizedBox(height: 12),
                          Text('Etiqueta: $etiquetaTexto', style: const TextStyle(fontSize: 16)),
                          const SizedBox(height: 12),
                          Container(
                            height: 120,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: imagenUrl != null
                                ? Image.network(imagenUrl!, fit: BoxFit.cover)
                                : const Icon(Icons.image, size: 48),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                // Card derecha
                Expanded(
                  child: Card(
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            etiquetaDerecha,
                            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // 🔶 Card inferior con campos adicionales
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: campoAdicionalController,
                      decoration: const InputDecoration(labelText: 'Datos adicionales'),
                      maxLines: 3,
                    ),
                    const SizedBox(height: 12),
                    Text('Etiqueta: $etiquetaAbajo', style: const TextStyle(fontSize: 16)),
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      onPressed: () {
                        // lógica para tomar evidencia
                      },
                      icon: const Icon(Icons.camera_alt),
                      label: const Text('Tomar evidencia'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        foregroundColor: Colors.white,
                        minimumSize: const Size(double.infinity, 48),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            // ✅ Botón de guardar
            ElevatedButton(
              onPressed: () {
                // lógica para guardar
              },
              child: const Text('Guardar'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 48),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
