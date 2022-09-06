import 'dart:io';

import 'package:common_utils/common_utils.dart';
import 'package:grinder/grinder.dart';
import 'package:path/path.dart';
import 'package:yaml/yaml.dart';

import 'config.dart';
import 'tick_tool.dart';
import 'version_tool.dart';

part '_version.dart';

part 'build_tool.dart';

Future main(args) => grind(args);

@Task()
Future test() => TestRunner().testAsync();

@DefaultTask()
@Depends(genClean)
void build() {}

@Task()
void clean() => defaultClean();

@Task('build runner clean')
void genClean() async {
  await runAsync('fvm', arguments: [
    'flutter',
    'pub',
    'run',
    'build_runner',
    'build',
    '--delete-conflicting-outputs'
  ]);
}

@Task()
void buildApkDev() async {
  buildFunc('dev');
}

@Task()
void buildApkRelease() async {
  buildFunc('release');
}

@Task()
void buildApkLocal() async {
  buildFunc('local');
}

@Task()
void buildIosDev() async {
  final tickTool = TickTool();
  tickTool.start();
  await runAsync(
    'flutter',
    arguments: [
      'build',
      'ios',
      '--dart-define',
      'ENV=dev',
    ],
  );
  tickTool.end();
}

@Task()
void buildIos() async {
  final tickTool = TickTool();
  tickTool.start();
  await runAsync(
    'flutter',
    arguments: [
      'build',
      'ios',
      '--dart-define',
      'ENV=release',
    ],
  );
  tickTool.end();
}

@Task()
void buildIosLocal() async {
  final tickTool = TickTool();
  tickTool.start();
  await runAsync(
    'flutter',
    arguments: [
      'build',
      'ios',
      '--dart-define',
      'ENV=local',
    ],
  );
  tickTool.end();
}
