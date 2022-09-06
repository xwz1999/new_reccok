

import 'package:new_recook/widget/calendar/lunar_util.dart';

class HolidayUtil{


  getHoliday(int year,int month,int day){
    print(year);
    print(month);
    print(day);
        List<int> lunar =
    LunarUtil.solarToLunar(year, month,day);
    String holiday = '';
    if(LunarUtil.getSolarTerm(year, month, day).isNotEmpty){
      holiday = LunarUtil.getSolarTerm(year, month, day);
      print(1111111);
      print(holiday);
      return holiday;


    }else if(LunarUtil.getTraditionFestival(lunar[0], lunar[1], lunar[2]).isNotEmpty){
      holiday = LunarUtil.getTraditionFestival(lunar[0], lunar[1], lunar[2]);
      print(2222222);
      print(holiday);
      return holiday;


    }else if(getGregorianFestival(year, month, day).isNotEmpty){

      holiday = getGregorianFestival(year, month, day);
      print(3333333);
      print(holiday);
      return holiday;

    }else{
      holiday = LunarUtil.numToChinese(lunar[1], lunar[2], lunar[3]);
      print(4444444);
      print(holiday);
      return holiday;
    }
  }


  isHoliday(int year,int month,int day){

    List<int> lunar =
    LunarUtil.solarToLunar(year, month,day);
    if(LunarUtil.getSolarTerm(year, month, day).isNotEmpty){

      return true;


    }else if(LunarUtil.getTraditionFestival(lunar[0], lunar[1], lunar[2]).isNotEmpty){
      return true;


    }else if(getGregorianFestival(year, month, day).isNotEmpty){

      return true;

    }else{
      return false;
    }
  }




//
//   List<int> lunar = [];
//   int? year;
//   int? month;
//   int day = 1;
//   ///优先显示传统节假日 节假日 节气 农历日期
//   String get lunarString {
//     if (solarTerm.isNotEmpty) {
//       return solarTerm;
//     } else if (traditionFestival.isNotEmpty) {
//       return traditionFestival;
//     } else if (gregorianFestival.isNotEmpty) {
//       return gregorianFestival;
//     } else {
//       return LunarUtil.numToChinese(lunar[1], lunar[2], lunar[3]);
//     }
//   }
//
//   //24节气
//   String get solarTerm => LunarUtil.getSolarTerm(year, month!, day);
//
//   //公历节日
//   String get gregorianFestival {
//     String result = LunarUtil.gregorianFestival(month!, day);
//     if (result.isNotEmpty == true) {
//       return result;
//     }
//     return LunarUtil.getSpecialFestival(year, month!, day);
//   }
//
  String getGregorianFestival(int year,int month,int day){
    String result = LunarUtil.gregorianFestival(month, day);
    if (result.isNotEmpty == true) {
      return result;
    }
    return LunarUtil.getSpecialFestival(year, month, day);
  }
//
//
// //传统农历节日
//   String get traditionFestival =>
//       LunarUtil.getTraditionFestival(lunarYear, lunarMonth, lunarDay);
//
//   bool? isCurrentMonth; //是否是当前月份
//
//   Object? extraData; //自定义的额外数据
//
//   bool isInRange = false; //是否在范围内,比如可以实现在某个范围外，设置置灰的功能
//   bool? isSelected; //是否被选中，用来实现一些标记或者选择功能
//   bool isCanClick =
//   true; //todo:是否可点击：设置范围外的日历不可点击，或者可以通过自定义拦截点击事件来设置true或者false
//   //是否是周末
//   bool get isWeekend => DateUtil.isWeekend(getDateTime());
//
//   //是否是闰年
//   bool get isLeapYear => DateUtil.isLeapYear(year!);
//
//   //是否是今天
//   bool get isCurrentDay => DateUtil.isCurrentDay(year, month, day);
//
//   int? get lunarYear => lunar[0];
//
//   int? get lunarMonth => lunar[1];
//
//   int? get lunarDay => lunar[2];
//
//   @override
//   String toString() {
//     return 'DateModel{year: $year, month: $month, day: $day}';
//   } //如果是闰月，则返回闰月
//
//   //转化成DateTime格式
//   DateTime getDateTime() {
//     return new DateTime(year!, month!, day);
//   }

  //根据DateTime创建对应的model，并初始化农历和传统节日等信息
//   static DateModel fromDateTime(DateTime dateTime) {
//     DateModel dateModel = new DateModel()
//       ..year = dateTime.year
//       ..month = dateTime.month
//       ..day = dateTime.day;
//     List<int> lunar =
//     LunarUtil.solarToLunar(dateModel.year!, dateModel.month!, dateModel.day);
//     dateModel.lunar = lunar;
//
// //    将数据的初始化放到各个get方法里面进行操作，类似懒加载,不然很浪费
// //    LunarUtil.setupLunarCalendar(dateModel);
//     return dateModel;
//   }
}