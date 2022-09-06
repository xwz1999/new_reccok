import 'package:amap_flutter_location/amap_flutter_location.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:new_recook/constants/config.dart';
import 'package:new_recook/constants/constants.dart';
import 'package:new_recook/constants/environment.dart';
import 'package:new_recook/pages/shop/shop_home_page.dart';
import 'package:new_recook/utils/headers.dart';
import 'package:new_recook/utils/hive_store.dart';
import 'package:package_info/package_info.dart';
import 'launch_privacy_dialog.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Constants.initial(context);
    var env = const String.fromEnvironment('ENV', defaultValue: 'dev');
    if (kDebugMode) {
      print('env :$env');
    }
    DevEV.instance.setEnvironment(
      context,
      environment: env == 'dev',
    );

    //等动态图标运行完以后再进行网络请求
    WidgetsBinding.instance.addPostFrameCallback((callback) async {
      var privacy = await HiveStore.appBox.get('privacy_init') ?? false;
      if (!privacy) {
        bool agreeResult = (await launchPrivacyDialog(context));
        if (!agreeResult) {
          //第1次不同意
          bool secondAgree = (await launchPrivacySecondDialog(context));
          //第2次不同意
          if (!secondAgree)
            SystemNavigator.pop();
          else {
            HiveStore.appBox.put('privacy_init', true);
            initDate();
          }
        } else {
          HiveStore.appBox.put('privacy_init', true);
          initDate();
        }
      } else {
        initDate();
      }
    });
  }

  initDate() async {
    //获取apk包的信息(版本)
    PackageInfo _packageInfo = await PackageInfo.fromPlatform();
    AppConfig.versionNumber = _packageInfo.buildNumber;
    Get.offAll(ShopHomePage());
  }

  @override
  Widget build(BuildContext context, {store}) {
    return Scaffold(
      body: Image.asset(
        R.ASSETS_WEBP_RECOOK_SPLASH_WEBP,
        fit: BoxFit.cover,
      ),
    );
  }
}
