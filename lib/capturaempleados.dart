import 'package:flutter/material.dart';
import 'claseempleado.dart';
import 'diccionarioempleado.dart';
import 'guardardatosdiccionario.dart';

class CapturaEmpleados extends StatefulWidget {
  const CapturaEmpleados({super.key});

  @override
  State<CapturaEmpleados> createState() => _CapturaEmpleadosState();
}

class _CapturaEmpleadosState extends State<CapturaEmpleados> {
  final _formKey = GlobalKey<FormState>();
  final _nombreController = TextEditingController();
  final _puestoController = TextEditingController();
  final _salarioController = TextEditingController();

  void _guardarDatos() {
    if (_formKey.currentState!.validate()) {
      // El ID es autonumérico
      int nuevoId = GeneradorId.nextId;

      // Crear instancia con los 4 datos (1 generado y 3 capturados en el form)
      Empleado nuevoEmpleado = Empleado(
        id: nuevoId,
        nombre: _nombreController.text,
        puesto: _puestoController.text,
        salario: double.tryParse(_salarioController.text) ?? 0.0,
      );

      // Usar nuestro agente para guardarlo en el diccionario
      AgenteGuardarDatos.guardar(nuevoEmpleado);

      // Feedback al usuario atractivo
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('✅ Empleado guardado exitosamente (ID: $nuevoId)'),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );

      // Limpiar los campos para nueva captura
      _nombreController.clear();
      _puestoController.clear();
      _salarioController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Capturar Empleado', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
      ),
      body: Container(
        color: const Color(0xFFF3F4F6),
        height: double.infinity,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Icon(Icons.person_add_alt_1, size: 80, color: Colors.blueAccent),
                const SizedBox(height: 20),
                Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _nombreController,
                          decoration: InputDecoration(
                            labelText: 'Nombre del Empleado',
                            prefixIcon: const Icon(Icons.person, color: Colors.blueAccent),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                          validator: (value) => value!.isEmpty ? 'Por favor ingrese el nombre' : null,
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: _puestoController,
                          decoration: InputDecoration(
                            labelText: 'Puesto',
                            prefixIcon: const Icon(Icons.work, color: Colors.blueAccent),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                          validator: (value) => value!.isEmpty ? 'Por favor ingrese el puesto' : null,
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: _salarioController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'Salario',
                            prefixIcon: const Icon(Icons.attach_money, color: Colors.blueAccent),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                          validator: (value) => value!.isEmpty ? 'Por favor ingrese el salario' : null,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                ElevatedButton.icon(
                  onPressed: _guardarDatos,
                  icon: const Icon(Icons.save),
                  label: const Text('Guardar Datos', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    backgroundColor: Colors.blueAccent,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    elevation: 5,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
