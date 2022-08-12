import 'package:json_annotation/json_annotation.dart';
part 'home_weather_model.g.dart';

@JsonSerializable()
class HomeWeatherModel {
  final String cityid;
  final String date;
  final String week;
  final String updateTime;
  final String city;
  final String cityEn;
  final String country;
  final String countryEn;
  final String wea;
  final String weaImg;
  final String tem;
  final String tem1;
  final String tem2;
  final String win;
  final String winSpeed;
  final String winMeter;
  final String humidity;
  final String visibility;
  final String pressure;
  final String air;
  final String airPm25;
  final String airLevel;
  final String airTips;
  final Alarm alarm;
  final Aqi aqi;

  factory HomeWeatherModel.fromJson(Map<String, dynamic> json) =>
      _$HomeWeatherModelFromJson(json);
  Map<String, dynamic> toJson() => _$HomeWeatherModelToJson(this);

  const HomeWeatherModel({
    required this.cityid,
    required this.date,
    required this.week,
    required this.updateTime,
    required this.city,
    required this.cityEn,
    required this.country,
    required this.countryEn,
    required this.wea,
    required this.weaImg,
    required this.tem,
    required this.tem1,
    required this.tem2,
    required this.win,
    required this.winSpeed,
    required this.winMeter,
    required this.humidity,
    required this.visibility,
    required this.pressure,
    required this.air,
    required this.airPm25,
    required this.airLevel,
    required this.airTips,
    required this.alarm,
    required this.aqi,
  });
}

@JsonSerializable()
class Alarm {
  final String alarmType;
  final String alarmLevel;
  final String alarmContent;

  factory Alarm.fromJson(Map<String, dynamic> json) => _$AlarmFromJson(json);
  Map<String, dynamic> toJson() => _$AlarmToJson(this);

  const Alarm({
    required this.alarmType,
    required this.alarmLevel,
    required this.alarmContent,
  });
}

@JsonSerializable()
class Aqi {
  final String air;
  final String airLevel;
  final String airTips;
  final String pm25;
  final String pm25Desc;
  final String pm10;
  final String pm10Desc;
  final String o3;
  final String o3Desc;
  final String no2;
  final String no2Desc;
  final String so2;
  final String so2Desc;
  final String kouzhao;
  final String waichu;
  final String kaichuang;
  final String jinghuaqi;
  final String cityid;
  final String city;
  final String cityEn;
  final String country;
  final String countryEn;

  factory Aqi.fromJson(Map<String, dynamic> json) => _$AqiFromJson(json);
  Map<String, dynamic> toJson() => _$AqiToJson(this);

  const Aqi({
    required this.air,
    required this.airLevel,
    required this.airTips,
    required this.pm25,
    required this.pm25Desc,
    required this.pm10,
    required this.pm10Desc,
    required this.o3,
    required this.o3Desc,
    required this.no2,
    required this.no2Desc,
    required this.so2,
    required this.so2Desc,
    required this.kouzhao,
    required this.waichu,
    required this.kaichuang,
    required this.jinghuaqi,
    required this.cityid,
    required this.city,
    required this.cityEn,
    required this.country,
    required this.countryEn,
  });
}
