// Verifica que los paquetes de `packages/` respeten la regla de dependencia:
//   app -> feature_* -> platform_* -> core_*
// 1. Las dependencias internas declaradas en cada pubspec.yaml deben estar
//    permitidas por [allowed].
// 2. Los imports `package:<interno>/` en `lib/` y `test/` deben estar declarados.
//
// Uso: dart run tool/check_deps.dart

import 'dart:io';

/// Grafo permitido: paquete -> paquetes internos de los que puede depender.
const Map<String, Set<String>> allowed = {
  'core_storage': {},
  'core_network': {'core_storage'},
  'core_ui': {},
  'platform_theme': {'core_ui'},
  'platform_media': {},
  'platform_session': {'core_network', 'core_storage'},
  'feature_onboarding': {'core_storage', 'core_ui'},
  'feature_settings': {'platform_theme', 'core_ui'},
  'feature_home': {'platform_session', 'core_ui'},
  'feature_auth': {'platform_session', 'core_ui'},
  'feature_showcase': {'core_ui', 'platform_media'},
};

final _internalPrefix = RegExp(r'^(core|platform|feature)_[a-z0-9_]+$');

void main() {
  final packagesDir = Directory('packages');
  final errors = <String>[];

  if (!packagesDir.existsSync()) {
    stdout.writeln('check-deps: no hay carpeta packages/, nada que verificar.');
    return;
  }

  final dirs = packagesDir.listSync().whereType<Directory>().toList()
    ..sort((a, b) => a.path.compareTo(b.path));

  for (final dir in dirs) {
    final name = dir.uri.pathSegments.where((s) => s.isNotEmpty).last;
    final pubspec = File('${dir.path}/pubspec.yaml');

    if (!allowed.containsKey(name)) {
      errors.add('$name: paquete fuera del mapa (agregalo a tool/check_deps.dart y al SPEC)');
      continue;
    }
    if (!pubspec.existsSync()) {
      errors.add('$name: falta pubspec.yaml');
      continue;
    }

    final declared = _declaredInternalDeps(pubspec.readAsLinesSync());
    final permitted = allowed[name]!;

    for (final dep in declared) {
      if (!permitted.contains(dep)) {
        errors.add('$name: depende de $dep, no permitido por el grafo '
            '(permitidos: ${permitted.isEmpty ? "ninguno" : permitted.join(", ")})');
      }
    }

    for (final sub in ['lib', 'test']) {
      final root = Directory('${dir.path}/$sub');
      if (!root.existsSync()) continue;
      for (final file in root.listSync(recursive: true).whereType<File>()) {
        if (!file.path.endsWith('.dart')) continue;
        for (final imported in _importedInternal(file.readAsStringSync())) {
          if (imported != name && !declared.contains(imported)) {
            errors.add('${file.path}: importa $imported sin declararlo en pubspec.yaml');
          }
        }
      }
    }
  }

  if (errors.isEmpty) {
    stdout.writeln('check-deps: OK (${dirs.length} paquetes)');
    return;
  }
  stderr.writeln('check-deps: ${errors.length} violacion(es)');
  for (final e in errors) {
    stderr.writeln('  - $e');
  }
  exit(1);
}

/// Dependencias internas (core_/platform_/feature_) en `dependencies:` y
/// `dev_dependencies:` de un pubspec.
Set<String> _declaredInternalDeps(List<String> lines) {
  final result = <String>{};
  var inDeps = false;
  for (final line in lines) {
    if (RegExp(r'^\S').hasMatch(line)) {
      inDeps = line.startsWith('dependencies:') || line.startsWith('dev_dependencies:');
      continue;
    }
    if (!inDeps) continue;
    final match = RegExp(r'^  ([a-z0-9_]+):').firstMatch(line);
    if (match != null && _internalPrefix.hasMatch(match.group(1)!)) {
      result.add(match.group(1)!);
    }
  }
  return result;
}

Iterable<String> _importedInternal(String source) sync* {
  final pattern = RegExp(r'''(?:import|export)\s+['"]package:([a-z0-9_]+)/''');
  for (final m in pattern.allMatches(source)) {
    final pkg = m.group(1)!;
    if (_internalPrefix.hasMatch(pkg)) yield pkg;
  }
}
