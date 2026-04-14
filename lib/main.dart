import 'package:flutter/material.dart';
import 'inicio.dart';
import 'capturaempleados.dart';
import 'verempleados.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Datos de Empleado',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const Inicio(),
        '/captura': (context) => const CapturaEmpleados(),
        '/ver': (context) => const VerEmpleados(),
      },
    );
  }
}
