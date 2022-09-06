import 'dart:async';
import 'dart:io';
import 'package:amap_flutter_location/amap_flutter_location.dart';
import 'package:amap_flutter_location/amap_location_option.dart';
import 'package:new_recook/constants/config.dart';
import 'package:permission_handler/permission_handler.dart';

/*
//使用

    locationUtil.getCurrentLocation((Map result){
      print('接收到result:$result');
    }).catchError((err){
      Fluttertoast.showToast(msg: err);
    });

*/

class LocationUtil {
  StreamSubscription<Map<String, Object>>? _locationListener;
  final AMapFlutterLocation _locationPlugin = AMapFlutterLocation();
  PermissionStatus? status;

  LocationUtil(){
    AMapFlutterLocation.setApiKey(
        AppConfig.MAP_ANDROID_KEY, AppConfig.MAP_IOS_KEY);

    //高德地图隐私协议 在用户同意隐私协议后更新
    AMapFlutterLocation.updatePrivacyShow(true, true);
    AMapFlutterLocation.updatePrivacyAgree(true);

  }


  Future<void> getCurrentLocation(Function(Map result) onLocationChanged,{once=true}) async {
      ///注册定位结果监听
      _locationListener = _locationPlugin.onLocationChanged().listen((Map<String, Object> result) {
        onLocationChanged(result);
        if (result['longitude'] != null) {
          //print("当前位置：$result");
          if(once) _stopLocation();
        }
      });
      _startLocation();
  }

  ///设置定位参数
  void _setLocationOption() {
    AMapLocationOption locationOption = AMapLocationOption();

    ///将定位参数设置给定位插件
    _locationPlugin.setLocationOption(locationOption);
  }

  ///开始定位
  void _startLocation() {
    _setLocationOption();
    _locationPlugin.startLocation();
  }

  ///停止定位
  void _stopLocation() {
    _locationPlugin.stopLocation();
  }


  void cancel() {
    if (null != _locationListener) {
      _locationListener?.cancel(); // 停止定位
    }
  }
}