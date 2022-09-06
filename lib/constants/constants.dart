import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:new_recook/extensions/num_ext.dart';

class Constants {
  Constants.initial(BuildContext context) {
    DeviceInfo.initial();
  }
}

extension SeparateExt on List<Widget> {
  List<Widget> sepWidget({Widget? separate}) {
    if (this.length <= 1) return this;
    return List.generate(this.length * 2 - 1, (index) {
      if (index.isEven)
        return this[index ~/ 2];
      else
        return separate ?? 10.wb;
    });
  }
}


class AppStrings {
  static const String key_user = "user_json_save";

  static const String key_province_city_json = "province_city_json";
}

class AppPaths {
  static const String path_province_city_json = "/provinceCityJson.json";
}

class DeviceInfo {
  static double? screenHeight;
  static double? screenWidth;
  static double? statusBarHeight;
  static double? bottomBarHeight;
  static double? devicePixelRatio;
  static double appBarHeight = 56;

  DeviceInfo.initial() {
    MediaQueryData data = MediaQueryData.fromWindow(window);
    screenHeight = data.size.height;
    screenWidth = data.size.width;
    statusBarHeight = data.padding.top;
    bottomBarHeight = data.padding.bottom;
    devicePixelRatio = data.devicePixelRatio;
  }
}

