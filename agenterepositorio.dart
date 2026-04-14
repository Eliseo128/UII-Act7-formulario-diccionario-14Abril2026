import 'dart:io';

void main() async {
  print('=============================================');
  print('🤖 Agente de Repositorio GitHub Iniciado 🤖');
  print('=============================================');

  // 1. Verificar si git está instalado
  if (!await _isGitInstalled()) {
    print('❌ Error: Git no está instalado o no se encuentra en el PATH.');
    return;
  }

  // 2. Inicializar git si no lo está
  final gitDir = Directory('.git');
  if (!gitDir.existsSync()) {
    print('📦 Inicializando repositorio Git...');
    await _runCommand('git', ['init']);
  } else {
    print('📦 Repositorio Git ya inicializado.');
  }

  // 3. Verificar si ya hay un remoto y preguntar por el link de GitHub
  String? remoteUrl = await _getExistingRemote();
  if (remoteUrl != null && remoteUrl.isNotEmpty) {
    print('🔗 Link actual de GitHub detectado: $remoteUrl');
    stdout.write('¿Desea cambiar el link de GitHub (s/N)?: ');
    String? changeRemote = stdin.readLineSync()?.trim().toLowerCase();
    if (changeRemote == 's') {
      await _askAndSetRemote();
    }
  } else {
    await _askAndSetRemote();
  }

  // 4. Agregar archivos (git add)
  print('\n📝 Agregando archivos al área de preparación (git add .)...');
  await _runCommand('git', ['add', '.']);

  // Verificar si hay cambios para comitear
  var statusResult = await Process.run('git', ['status', '--porcelain'], runInShell: true);
  if (statusResult.stdout.toString().trim().isEmpty) {
     print('⚠️ No hay cambios pendientes para hacer commit.');
  } else {
    // 5. Preguntar por el mensaje de commit
    String commitMsg = '';
    while (commitMsg.isEmpty) {
      stdout.write('💬 Ingrese el mensaje del commit: ');
      commitMsg = stdin.readLineSync()?.trim() ?? '';
      if (commitMsg.isEmpty) {
        print('❌ El mensaje de commit no puede estar vacío.');
      }
    }

    // 6. Ejecutar commit
    await _runCommand('git', ['commit', '-m', commitMsg]);
    print('✅ Commit realizado con éxito.');
  }

  // 7. Selección de rama (por defecto main)
  stdout.write('\n🌿 Ingrese la rama a la cual desea enviar (ENTER para "main"): ');
  String branch = stdin.readLineSync()?.trim() ?? '';
  if (branch.isEmpty) {
    branch = 'main';
  }

  // Renombrar la rama actual a la seleccionada
  print('🔄 Estableciendo la rama a "$branch"...');
  await _runCommand('git', ['branch', '-M', branch]);

  // 8. Hacer Push a GitHub
  print('🚀 Enviando al repositorio en $branch (git push)...');
  var pushResult = await Process.run('git', ['push', '-u', 'origin', branch], runInShell: true);
  
  if (pushResult.exitCode == 0) {
    if (pushResult.stdout.toString().isNotEmpty) print(pushResult.stdout);
    if (pushResult.stderr.toString().isNotEmpty) print(pushResult.stderr);
    print('🎉 ¡Cambios enviados exitosamente a GitHub!');
  } else {
    print('❌ Error al enviar los cambios:');
    print(pushResult.stderr);
  }
}

Future<bool> _isGitInstalled() async {
  try {
    var result = await Process.run('git', ['--version'], runInShell: true);
    return result.exitCode == 0;
  } catch (e) {
    return false;
  }
}

Future<String?> _getExistingRemote() async {
  try {
    var result = await Process.run('git', ['remote', 'get-url', 'origin'], runInShell: true);
    if (result.exitCode == 0) {
      return result.stdout.toString().trim();
    }
  } catch (e) {
    // El remoto origin podría no existir, simplemente se ignora y se devuelve null.
  }
  return null;
}

Future<void> _askAndSetRemote() async {
  String githubLink = '';
  while (githubLink.isEmpty) {
    stdout.write('🔗 Ingrese el link del repositorio en GitHub (.git): ');
    githubLink = stdin.readLineSync()?.trim() ?? '';
    if (githubLink.isEmpty) {
      print('❌ El link no puede estar vacío.');
    }
  }

  // Validar si ya existe el remoto para actualizarlo o agregarlo
  var checkRemote = await Process.run('git', ['remote'], runInShell: true);
  if (checkRemote.stdout.toString().contains('origin')) {
    await _runCommand('git', ['remote', 'set-url', 'origin', githubLink]);
  } else {
    await _runCommand('git', ['remote', 'add', 'origin', githubLink]);
  }
  print('✅ Link de GitHub configurado correctamente.');
}

Future<void> _runCommand(String executable, List<String> arguments) async {
  var result = await Process.run(executable, arguments, runInShell: true);
  if (result.exitCode != 0) {
    // Ciertos warnings en git se envían por stderr aunque el proceso sea exitoso.
    // Solo imprimimos si realmente hubo un error para que el usuario no se alarme.
    if (!result.stderr.toString().contains('warning:')) {
      print('⚠️ Mensaje de git $executable ${arguments.join(" ")}:');
      print(result.stderr);
    }
  }
}
