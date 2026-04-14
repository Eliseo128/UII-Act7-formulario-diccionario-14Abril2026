import 'package:flutter/material.dart';

class Inicio extends StatelessWidget {
  const Inicio({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inicio', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
      ),
      body: Container(
        width: double.infinity,
        color: const Color(0xFFF3F4F6), // Un gris claro tipo fondo de aplicación
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.business_center, size: 100, color: Colors.blueAccent),
            const SizedBox(height: 20),
            const Text(
              'Gestión de Empleados',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            const SizedBox(height: 50),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, '/captura');
              },
              icon: const Icon(Icons.person_add),
              label: const Text('Capturar Empleados', style: TextStyle(fontSize: 18)),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                backgroundColor: Colors.blueAccent,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                elevation: 4,
              ),
            ),
            const SizedBox(height: 25),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, '/ver');
              },
              icon: const Icon(Icons.people_alt),
              label: const Text('Ver Empleados', style: TextStyle(fontSize: 18)),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                backgroundColor: Colors.green, // Color verde para diferenciar
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                elevation: 4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
