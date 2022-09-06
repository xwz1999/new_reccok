import 'package:new_recook/constants/environment.dart';
import 'package:new_recook/utils/text_utils.dart';

class API {

  static const String domainPro = "https://mallapi.reecook.cn";
  static const String domainDev = "https://testapi.reecook.cn";

  static const String cdnDominPro = "https://mallcdn.reecook.cn";
  static const String cdnDominDev = "https://testcdn.reecook.cn";



  static String get host {
    if (DevEV.instance.dev) {
      return '$domainDev/api';
    } else {
      return '$domainPro/api';
    }
  }

  static String get imageHost {
    if (DevEV.instance.dev) {
      return cdnDominDev;
    } else {
      return cdnDominPro;
    }
  }

  static String? getImgUrl(String? url, {bool isPrint = false}) {
    if (!TextUtils.isEmpty(url) && url!.startsWith("http")) {
      return url;
    }
    if (isPrint) {
      print("$imageHost/static$url");
    }
    return "$imageHost/static$url";
  }
  static _WebAPI webAPI = _WebAPI();
  static JuHeAPI juHeAPI = JuHeAPI();
}

class _WebAPI {
  String get  webPrivacy => "https://mallh5.reecook.cn/privacy.html";//隐私政策
  String get  webAgreement => "https://mallh5.reecook.cn/protocol.html";//用户协议
}

class JuHeAPI{
  ///聚合
  String get juHeMain =>
      'http://apis.juhe.cn/';

  String get juHeMainList =>
      'http://v.juhe.cn/';

  ///国内油价
  String get gnyj =>
      'gnyj/query';
  String get gnyjKey =>
      '42d9fd7e6e92dc078b58b82c7af458c3';

  ///生肖配对
  String get sxpd=>
      'sxpd/query';
  String get sxpdKey =>
      'dd35fd75193b85f1bdf91c7926b29e72';

  ///星座配对
  String get xzpd=>
      'xzpd/query';
  String get xzpdKey =>
      'b66fa089e114d5873d962c61bb62dc28';


  ///基础健康指数
  String get fapigKey =>
      'b96202f114ad5e24ee73f71c72a528a1';
  String get bmr =>
      'fapig/healthy/bmr';
  String get calorie =>
      'fapig/healthy/calorie';
  String get bfr =>
      'fapig/healthy/bfr';
  String get blood =>
      'fapig/healthy/blood';


  ///最佳身材计算器
  String get zjsc=>
      'fapig/stature/query';
  String get zjscKey =>
      '7998578aed7a1f99661b5987a02f1b53';


  ///贷款公积金
  String get dkgjj=>
      'fapig/loanCalc/loan';
  String get dkgjjKey =>
      'f8603b30cf5d9cda588ea4c41fc49b6a';


  ///星座查询
  String get xzcx=>
      'fapig/constellation/query';
  String get xzcxKey =>
      '0da15609606812bb1f2e5b0a692cbd5a';


  ///生肖查询
  String get sxcx=>
      'fapig/zodiac/query';
  String get sxcxKey =>
      '6e2a6eb4eda75a6d97d4de24a5cc9fa6';


  ///心灵鸡汤
  String get xljt=>
      'fapig/soup/query';
  String get xljtKey =>
      '7954bc49f4710609feaa83ca7246e644';


  ///生日花语
  String get srhy=>
      'fapig/birthdayFlower/query';
  String get srhyKey =>
      '923c791edf302d22fbed56fa8732c800';


  ///新闻头条
  String get xwtt=>
      'toutiao/index';
  String get xwttXq=>
      'toutiao/content';

  String get xwttKey =>
      'efd81dcff38f854a0a77b0e6dcb53294';


  ///数独游戏
  String get sdyy=>
      'fapig/sudoku/generate';
  String get sdyyKey =>
      '4ed06fd10ad663d7a8b69f977730a46f';


  ///成语接龙
  String get cyjl=>
      'idiomJie/query';
  String get cyjlKey =>
      '11dfcd6618c7cd2b8c432bacdcbb0d80';


  ///身高体重计算器
  String get sgtz=>
      'fapig/calculator/weight';
  String get sgtzKey =>
      '1880b4d322511fa06eda956181463371';


  ///笑话大全
  String get xhdq=>
      'joke/randJoke.php';
  String get xhdqKey =>
      'f7266254e1f3713c1fbc877cf7fdec48';


  ///足球联赛
  String get zqls=>
      'fapig/football/query';
  String get zqlsRank=>
      'fapig/football/rank';
  String get zqlsKey =>
      '55ac9a2da59be41bd98a3df52ca725f8';


  ///nba
  String get nba=>
      'fapig/nba/query';
  String get nbaRank=>
      'fapig/nba/rank';
  String get nbaKey =>
      '161c5655830d303910127ab4a67fb9c8';


  ///热门视频
  String get rmsp=>
      'fapig/douyin/billboard';
  String get rmspKey =>
      '1f7ed44ac7f75179c5e84986779f492d';


  // ///老黄历
  // String get lhl=>
  //     'laohuangli/d';
  // String get lhlKey =>
  //     'edfd263c72451fd0b50c348259445879';


  ///万年历
  String get wnl=>
      'calendar/day';
  String get wnlKey =>
      '85fb227b9a3c1e9e8937f4f8e52be972';


  String get holiday => '/v2/app/thridapi/holidays';
}
