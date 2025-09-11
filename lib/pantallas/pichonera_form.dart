import 'package:flutter/material.dart';

class PichoneraForm extends StatefulWidget {
  const PichoneraForm({super.key});

  @override
  State<PichoneraForm> createState() => _PichoneraFormState();
}

class _PichoneraFormState extends State<PichoneraForm> {
  final campoTextoController = TextEditingController();
  final campoAdicionalController = TextEditingController();

  String etiquetaTexto = 'N';
  String etiquetaDerecha = 'P-09';
  String etiquetaAbajo = 'N';
  String? imagenUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 50),
            Row(
              children: [
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
                            decoration: const InputDecoration(labelText: 'Numero de empleado'),
                          ),
                          const SizedBox(height: 12),
                          Text('Nombre: $etiquetaTexto', style: const TextStyle(fontSize: 16)),
                          const SizedBox(height: 12),
                          Container(
                            height: 120,
                            decoration: BoxDecoration(
                              color: Colors.white,
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
                            style: const TextStyle(fontSize: 80, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: campoAdicionalController,
                      decoration: const InputDecoration(labelText: 'Numero empleado guardia'),
                      maxLines: 3,
                    ),
                    const SizedBox(height: 12),
                    Text(' $etiquetaAbajo', style: const TextStyle(fontSize: 16)),
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.camera_alt),
                      label: const Text('Tomar evidencia'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        minimumSize: const Size(double.infinity, 48),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {},
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
