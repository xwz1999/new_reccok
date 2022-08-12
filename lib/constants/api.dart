class API {
  ///HOST
  static const String host = 'http://shop.kaidalai.cn';

  ///接口基础地址
  static const String baseURL = '$host/api/app';

  ///静态资源路径
  static String get resource => '$host/static';

  static String image(String? path) => '$resource$path';

  static String file(String? path) => '$resource$path';

  static const int networkTimeOut = 10000;
  static _Login login = _Login();
  static _Web web = _Web();
}

class _Login {

}


class _Web {

  ///获取隐私政策
  String get privacy => "https://h5.reecook.cn/privacy.html";

  ///获取用户协议
  String get agreement => "https://h5.reecook.cn/protocol.html";
}


