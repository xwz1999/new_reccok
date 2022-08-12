
import 'dart:ui';

import 'package:intl/intl.dart';
class TextUtils {
  ///判断空字符串
  ///
  ///white 全空格是否算空字符串
  static bool isEmpty(String? str, {bool whiteSpace = false}) {
    if (whiteSpace) {
      return str == null || str.trim().length == 0;
    }
    return str == null || str.length == 0;
  }

  static bool isNotEmpty(String str, {bool whiteSpace = false}) {
    return !isEmpty(str, whiteSpace: whiteSpace);
  }

  static bool verifyPhone(phone) {
    return new RegExp("^^1\\d{10}\$").hasMatch(phone);
  }

  static String? getCount(num number){
    var fotmat;
    if(number>99999999){
      number = 99999999;
      fotmat = NumberFormat('0,000+');
    }else{
      if(number<1000&&number>=100){
        fotmat = NumberFormat('000.00');
      }else if(number<100&&number>=10){
        fotmat = NumberFormat('00.00');
      }else if(number<10){
        fotmat = NumberFormat('0.00');
      }

      else{
        fotmat = NumberFormat('0,000.00');
      }

    }
    return fotmat.format(number);
  }


  static String? getCount1(num number){
    var fotmat;

      if(number<1000&&number>=100){
        fotmat = NumberFormat('000.00');
      }else if(number<100&&number>=10){
        fotmat = NumberFormat('00.00');
      }else if(number<10){
        fotmat = NumberFormat('0.00');
      }

      else{
        fotmat = NumberFormat('0,000.00');
      }


    return fotmat.format(number);
  }
  static Color hexToColor(String? s) {
    // 如果传入的十六进制颜色值不符合要求，返回默认值
    if (s == null || s.length != 7 ||
        int.tryParse(s.substring(1, 7), radix: 16) == null) {
      s = '#999999';
    }
    return new Color(int.parse(s.substring(1, 7), radix: 16) + 0xFF000000);
  }
}
