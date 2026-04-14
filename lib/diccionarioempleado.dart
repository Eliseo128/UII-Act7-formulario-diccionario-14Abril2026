import 'claseempleado.dart';

// Inicializar un diccionario vacío llamado datosempleado
Map<int, Empleado> datosempleado = {};

// Clase de ayuda para hacer el ID autonumérico
class GeneradorId {
  static int _currentId = 1;
  static int get nextId => _currentId++;
}
