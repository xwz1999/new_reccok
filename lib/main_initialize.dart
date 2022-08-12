import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
// import 'package:fluwx/fluwx.dart';
import 'package:get/get.dart';
import 'package:new_recook/utils/hive_store.dart';
import 'package:provider/provider.dart';
import 'package:power_logger/power_logger.dart';
import 'constants/app_theme.dart';

class MainInitialize {


  static initTheme() {
    SystemChrome.setSystemUIOverlayStyle(SystemStyle.initial);
  }

  static Future hive() async {
    await HiveStore.initHive();
  }

  static Future initJPush() async {
    // final JPush jpush = new JPush();
    // if (kIsWeb || Platform.isMacOS) return;
    //
    //
    // try {
    //   jpush.addEventHandler(onReceiveNotification: (message) async {
    //     LoggerData.addData(message, tag: 'onReceiveNotification');
    //     await MessageParser(message).shot();
    //     final appProvider =
    //         Provider.of<AppProvider>(Get.context!, listen: false);
    //     appProvider.getMessageCenter();
    //   }, onOpenNotification: (Map<String, dynamic>? message) async {
    //     LoggerData.addData(message, tag: 'onOpenNotification');
    //   }, onReceiveMessage: (Map<String, dynamic>? message) async {
    //     LoggerData.addData(message, tag: 'onReceiveMessage');
    //   }, onReceiveNotificationAuthorization:
    //       (Map<String, dynamic> message) async {
    //     print("flutter onReceiveNotificationAuthorization: $message");
    //   });
    // } on PlatformException {}
    // jpush.setup(
    //   appKey: "5f42cbb15abcdda6f8aeb925",
    //   channel: "developer-default",
    //   production: false,
    //   debug: true,
    // );
    // // jpush.applyPushAuthority();
    // String? rID;
    // jpush.getRegistrationID().then((rid) {
    //   print("flutter get registration id : $rid");
    //   rID = rid;
    //   LoggerData.addData(rID, tag: 'RegistrationID');
    // });
  }

  static initWechat() {
    if (kIsWeb || Platform.isMacOS) return;
    // registerWxApi(appId: AppConfig.wechatAppId);
  }

}
