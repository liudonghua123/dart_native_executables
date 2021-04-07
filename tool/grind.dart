import 'dart:io';

import 'package:grinder/grinder.dart';

Future main(args) => grind(args);

@Task()
Future test() => TestRunner().testAsync();

@DefaultTask()
@Depends(test)
void build() {
  // create build directory if it doesn't exist.
  Directory('build').createSync();
  // run dart compile exe bin/app_launcher.dart -o build/app_launcher.exe
  Process.runSync('dart', [
    'compile',
    'exe',
    'bin/dart_native_executables.dart',
    '-o',
    'build/dart_native_executables-${Platform.operatingSystem}${Platform.isWindows ? '.exe' : ''}'
  ]);
}

@Task()
void clean() => defaultClean();
