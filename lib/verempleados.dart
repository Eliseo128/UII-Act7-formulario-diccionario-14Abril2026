import 'package:flutter/material.dart';
import 'diccionarioempleado.dart';

class VerEmpleados extends StatefulWidget {
  const VerEmpleados({super.key});

  @override
  State<VerEmpleados> createState() => _VerEmpleadosState();
}

class _VerEmpleadosState extends State<VerEmpleados> {
  @override
  Widget build(BuildContext context) {
    // Obtenemos todos los registros del diccionario temporalmente en una lista
    final listaEmpleados = datosempleado.values.toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Empleados', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: Container(
        color: const Color(0xFFF3F4F6),
        child: listaEmpleados.isEmpty
            ? const Center(
                child: Text(
                  'No hay empleados registrados.',
                  style: TextStyle(fontSize: 18, color: Colors.grey, fontStyle: FontStyle.italic),
                ),
              )
            : ListView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: listaEmpleados.length,
                itemBuilder: (context, index) {
                  final empleado = listaEmpleados[index];
                  return Card(
                    elevation: 3,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      leading: CircleAvatar(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        radius: 25,
                        child: Text(
                          empleado.id.toString(),
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      ),
                      title: Text(
                        empleado.nombre,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 5),
                          Row(
                            children: [
                              const Icon(Icons.work, size: 16, color: Colors.grey),
                              const SizedBox(width: 5),
                              Text('Puesto: ${empleado.puesto}'),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Row(
                            children: [
                              const Icon(Icons.attach_money, size: 16, color: Colors.green),
                              const SizedBox(width: 5),
                              Text(
                                'Salario: \$${empleado.salario.toStringAsFixed(2)}',
                                style: const TextStyle(
                                  color: Colors.green, 
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
