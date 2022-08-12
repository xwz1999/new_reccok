// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_weather_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeWeatherModel _$HomeWeatherModelFromJson(Map<String, dynamic> json) {
  return HomeWeatherModel(
    cityid: json['cityid'] as String,
    date: json['date'] as String,
    week: json['week'] as String,
    updateTime: json['updateTime'] as String,
    city: json['city'] as String,
    cityEn: json['cityEn'] as String,
    country: json['country'] as String,
    countryEn: json['countryEn'] as String,
    wea: json['wea'] as String,
    weaImg: json['weaImg'] as String,
    tem: json['tem'] as String,
    tem1: json['tem1'] as String,
    tem2: json['tem2'] as String,
    win: json['win'] as String,
    winSpeed: json['winSpeed'] as String,
    winMeter: json['winMeter'] as String,
    humidity: json['humidity'] as String,
    visibility: json['visibility'] as String,
    pressure: json['pressure'] as String,
    air: json['air'] as String,
    airPm25: json['airPm25'] as String,
    airLevel: json['airLevel'] as String,
    airTips: json['airTips'] as String,
    alarm: Alarm.fromJson(json['alarm'] as Map<String, dynamic>),
    aqi: Aqi.fromJson(json['aqi'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$HomeWeatherModelToJson(HomeWeatherModel instance) =>
    <String, dynamic>{
      'cityid': instance.cityid,
      'date': instance.date,
      'week': instance.week,
      'updateTime': instance.updateTime,
      'city': instance.city,
      'cityEn': instance.cityEn,
      'country': instance.country,
      'countryEn': instance.countryEn,
      'wea': instance.wea,
      'weaImg': instance.weaImg,
      'tem': instance.tem,
      'tem1': instance.tem1,
      'tem2': instance.tem2,
      'win': instance.win,
      'winSpeed': instance.winSpeed,
      'winMeter': instance.winMeter,
      'humidity': instance.humidity,
      'visibility': instance.visibility,
      'pressure': instance.pressure,
      'air': instance.air,
      'airPm25': instance.airPm25,
      'airLevel': instance.airLevel,
      'airTips': instance.airTips,
      'alarm': instance.alarm,
      'aqi': instance.aqi,
    };

Alarm _$AlarmFromJson(Map<String, dynamic> json) {
  return Alarm(
    alarmType: json['alarmType'] as String,
    alarmLevel: json['alarmLevel'] as String,
    alarmContent: json['alarmContent'] as String,
  );
}

Map<String, dynamic> _$AlarmToJson(Alarm instance) => <String, dynamic>{
      'alarmType': instance.alarmType,
      'alarmLevel': instance.alarmLevel,
      'alarmContent': instance.alarmContent,
    };

Aqi _$AqiFromJson(Map<String, dynamic> json) {
  return Aqi(
    air: json['air'] as String,
    airLevel: json['airLevel'] as String,
    airTips: json['airTips'] as String,
    pm25: json['pm25'] as String,
    pm25Desc: json['pm25Desc'] as String,
    pm10: json['pm10'] as String,
    pm10Desc: json['pm10Desc'] as String,
    o3: json['o3'] as String,
    o3Desc: json['o3Desc'] as String,
    no2: json['no2'] as String,
    no2Desc: json['no2Desc'] as String,
    so2: json['so2'] as String,
    so2Desc: json['so2Desc'] as String,
    kouzhao: json['kouzhao'] as String,
    waichu: json['waichu'] as String,
    kaichuang: json['kaichuang'] as String,
    jinghuaqi: json['jinghuaqi'] as String,
    cityid: json['cityid'] as String,
    city: json['city'] as String,
    cityEn: json['cityEn'] as String,
    country: json['country'] as String,
    countryEn: json['countryEn'] as String,
  );
}

Map<String, dynamic> _$AqiToJson(Aqi instance) => <String, dynamic>{
      'air': instance.air,
      'airLevel': instance.airLevel,
      'airTips': instance.airTips,
      'pm25': instance.pm25,
      'pm25Desc': instance.pm25Desc,
      'pm10': instance.pm10,
      'pm10Desc': instance.pm10Desc,
      'o3': instance.o3,
      'o3Desc': instance.o3Desc,
      'no2': instance.no2,
      'no2Desc': instance.no2Desc,
      'so2': instance.so2,
      'so2Desc': instance.so2Desc,
      'kouzhao': instance.kouzhao,
      'waichu': instance.waichu,
      'kaichuang': instance.kaichuang,
      'jinghuaqi': instance.jinghuaqi,
      'cityid': instance.cityid,
      'city': instance.city,
      'cityEn': instance.cityEn,
      'country': instance.country,
      'countryEn': instance.countryEn,
    };
