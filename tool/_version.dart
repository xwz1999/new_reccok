part of 'grind.dart';

@Task('add minor version number')
void addVersion() async {
  var projectPath = Directory('.').absolute.path;
  var yamlPath = join(projectPath, 'pubspec.yaml');
  var yamlContent = await File(yamlPath).readAsString();
  dynamic content = loadYaml(yamlContent);
  String version = content['version'];
  //rename version
  var resultVersion = VersionTool.fromText(version).nextMinorTag('dev');

  var result = yamlContent.replaceFirst(version, resultVersion.toString());
  await File(yamlPath).writeAsString(result);
}

@Task('add path version number')
void addVersionMajor() async {
  var projectPath = Directory('.').absolute.path;
  var yamlPath = join(projectPath, 'pubspec.yaml');
  var yamlContent = await File(yamlPath).readAsString();
  dynamic content = loadYaml(yamlContent);
  String version = content['version'];
  //rename version
  var resultVersion = VersionTool.fromText(version).nextMajorTag('dev');

  var result = yamlContent.replaceFirst(version, resultVersion.toString());
  await File(yamlPath).writeAsString(result);
}

@Task()
Future<String> getVersion() async {
  var projectPath = Directory('.').absolute.path;
  var yamlPath = join(projectPath, 'pubspec.yaml');
  var yamlContent = await File(yamlPath).readAsString();
  dynamic content = loadYaml(yamlContent);
  String version = content['version'];
  return version;
}
