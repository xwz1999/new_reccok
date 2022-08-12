import 'dart:io';

import 'package:amap_flutter_location/amap_flutter_location.dart';
import 'package:amap_flutter_location/amap_location_option.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:new_recook/constants/config.dart';
import 'package:power_logger/power_logger.dart';

class AppProvider extends ChangeNotifier {



  Map<String, dynamic>? _location;

  Map<String, dynamic>? get location => _location;
  late AMapFlutterLocation _aMapFlutterLocation;

  startLocation() {
    if (kIsWeb || Platform.isMacOS) {
      getWeather();
      return;
    }
    _aMapFlutterLocation = AMapFlutterLocation();

    _aMapFlutterLocation.onLocationChanged().listen((event) {
      _location = event;
      if (_location != null) {
        getWeather();
        stopLocation();
      }
    });
    _aMapFlutterLocation
        .setLocationOption(AMapLocationOption(onceLocation: true));
    _aMapFlutterLocation.startLocation();
  }

  stopLocation() {
    if (kIsWeb || Platform.isMacOS) return;
    _aMapFlutterLocation.stopLocation();
    _aMapFlutterLocation.destroy();
  }

  getWeather() async {
    late num longitude;
    late num latitude;
    if (kIsWeb || Platform.isMacOS) {
      longitude = 116.46;
      latitude = 39.92;
    } else {
      longitude = _location?['longitude'] ?? 116.46;
      latitude = _location?['latitude'] ?? 39.92;
    }

    Response response = await Dio().get(
      'https://api.caiyunapp.com/v2.5/${AppConfig.caiYunAPI}/$longitude,$latitude/realtime.json',
    );
    LoggerData.addData(response);
    //_weatherModel = RealTimeWeatherModel.fromJson(response.data);
    notifyListeners();
  }

}
