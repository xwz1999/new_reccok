part of 'grind.dart';

void buildFunc(String environment) async {
  final tickTool = TickTool();
  tickTool.start();
  await runAsync(
    'fvm',
    arguments: [
      'flutter',
      'build',
      'apk',
      '--target-platform=android-arm64',
      '--dart-define',
      'ENV=$environment',
    ],
  );

  var date = DateUtil.formatDate(DateTime.now(), format: 'MM_dd_HH_mm');
  var version = await getVersion();
  await runAsync('rm',
      arguments: ['-rf', '${Config.apkDir}/$environment']);
  await runAsync('mkdir',
      arguments: ['-p', '${Config.apkDir}/$environment']);
  await runAsync('mv', arguments: [
    Config.buildPath,
    '${Config.apkDir}/$environment/${Config.packageName}_${version}_${environment}_$date.apk'
  ]);
  tickTool.end();
  log('BUILD DONE 💪');
}
