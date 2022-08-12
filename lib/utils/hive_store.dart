import 'package:flutter/foundation.dart';

import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';


class HiveStore {
  static Future initHive() async {
    if (!kIsWeb) {
      var dir = await getApplicationDocumentsDirectory();
      Hive
        ..init(dir.path);
        //..registerAdapter(ChinaRegionModelAdapter());
      _appBox ??= await Hive.openBox('app');
      //_chinaRegionBox ??= await Hive.openBox('china_region');
      _dataBox ??= await Hive.openBox('user_data');
    }
  }

  static Box? _appBox;
  static Box get appBox => _appBox!;
  static Box? _dataBox;
  static Box get dataBox => _dataBox!;

  static _BoxKeys keys = _BoxKeys();
}

class _BoxKeys {
  String get chinaRegion => 'china_region_data';
  String get chinaRegionVersion => 'china_region_version';
}
