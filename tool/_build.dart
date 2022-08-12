part of './grind.dart';

@Task('打包Android项目')
buildApk() async {
  await runAsync(
    'fvm',
    arguments: [
      'flutter',
      'build',
      'apk',
      '--target-platform=android-arm64',
      '--dart-define',
      'BUILD_TYPE=PRODUCT',
    ],
  );

  String version = await getVersion();
  await runAsync('rm', arguments: ['-rf', Config.apkDir]);
  await runAsync('mkdir', arguments: ['-p', Config.apkDir]);
  await runAsync('mv', arguments: [
    Config.buildPath,
    '${Config.apkDir}/${Config.packageName}_${version}_release.apk'
  ]);
}

@Task('打包Android项目')
buildApkDev() async {
  await runAsync(
    'fvm',
    arguments: [
      'flutter',
      'build',
      'apk',
      '--target-platform=android-arm64',
      '--dart-define',
      'BUILD_TYPE=Dev',
    ],
  );
  // String date = DateUtil.formatDate(DateTime.now(), format: 'yy_MM_dd_HH_mm');
  String version = await getVersion();
  await runAsync('rm', arguments: ['-rf', Config.apkDevDir]);
  await runAsync('mkdir', arguments: ['-p', Config.apkDevDir]);
  await runAsync('mv', arguments: [
    Config.buildPath,
    '${Config.apkDevDir}/${Config.packageName}_${version}_beta.apk'
  ]);
}

@Task('打包iOS项目')
buildIos() async {
  await runAsync(
    'fvm',
    arguments: [
      'flutter',
      'build',
      'ios',
      '--dart-define',
      'BUILD_TYPE=PRODUCT',
    ],
  );
}
