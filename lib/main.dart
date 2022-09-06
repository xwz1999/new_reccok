import 'package:bot_toast/bot_toast.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:new_recook/pages/splash/splash_page.dart';
import 'package:new_recook/provider/app_provider.dart';
import 'package:new_recook/provider/sign_up_provider.dart';
import 'package:new_recook/provider/user_provider.dart';
import 'package:new_recook/utils/developer_util.dart';
import 'package:provider/provider.dart';
import 'package:new_recook/utils/headers.dart';
import 'constants/app_theme.dart';
import 'main_initialize.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  const buildType = const String.fromEnvironment('BUILD_TYPE');
  DeveloperUtil.setDev(!(buildType.contains('PRODUCT')));
  WidgetsFlutterBinding.ensureInitialized();


  MainInitialize.initTheme();
  MainInitialize.initWechat();
  await MainInitialize.hive();
  await MainInitialize.initJPush();


  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserProvider()),
        ChangeNotifierProvider(create: (context) => AppProvider()),
        ChangeNotifierProvider(create: (context) => SignUpProvider()),
      ],
      child: GestureDetector(
        onTap: () {
          //点击输入框外部隐藏键盘⌨️
          //只能响应点击非手势识别的组件
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus &&
              currentFocus.focusedChild != null) {
            FocusManager.instance.primaryFocus!.unfocus();
          }
        },
        child: ScreenUtilInit(
          designSize: Size(750, 1334),
          builder: (context,widget) => GetMaterialApp(
            debugShowCheckedModeBanner: false,
            theme: AppTheme.theme,
            //themeMode: ThemeMode.light,//选择高亮模式和黑暗模式
            home: SplashPage(),
            //国际化支持
            localizationsDelegates: [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: [const Locale('zh')],
            locale: Locale('zh'),
            //builder: BotToastInit(),
            builder: (context, child) {
              return MediaQuery(
                //设置文字大小不随系统设置改变
                data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                child: BotToastInit().call(context, child),
              );
            },
            navigatorObservers: [BotToastNavigatorObserver()],
          ),
        ),
      ),
    );
  }
}
