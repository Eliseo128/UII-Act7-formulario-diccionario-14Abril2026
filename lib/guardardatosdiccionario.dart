import 'claseempleado.dart';
import 'diccionarioempleado.dart';

// Agente encargado de modificar el archivo diccionarioempleado.dart (la variable en memoria)
class AgenteGuardarDatos {
  static void guardar(Empleado empleado) {
    // Se guarda el empleado dentro del diccionario usando su ID generado como clave
    datosempleado[empleado.id] = empleado;
  }
}
