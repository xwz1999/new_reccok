
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:new_recook/constants/api.dart';
import 'package:new_recook/models/home/wannianli_model.dart';
import 'package:power_logger/power_logger.dart';

class HomeFunc{
  static Future<Response?> getJuHe(String url, String params, String key,
      {bool isList = false}) async {
    return await Dio().get(
        (isList ? API.juHeAPI.juHeMainList : API.juHeAPI.juHeMain) +
            url +
            '?key=' +
            key +
            params,options:Options(method: "post",sendTimeout: 5000,receiveTimeout: 5000,responseType: ResponseType.plain)
    );

      // await HttpManager.netFetchNormal(
      //   (isList ? APIV2.juHeAPI.juHeMainList : APIV2.juHeAPI.juHeMain) +
      //       url +
      //       '?key=' +
      //       key +
      //       params,
      //   null,
      //   null,
      //   Options(method: "post", sendTimeout: 5000, receiveTimeout: 5000));
  }

  ///万年历
  static Future<WanNianLiModel?> getWanNianLiModel(String date) async {
    print(date);
    print(date[5]);
    print(date[8]);
    if(date[5]=='0'){
      date =  date.substring(0,5)  + date.substring(6,10);
      print(date);
      print(date[7]);
      if(date[7]=='0'){
        date =  date.substring(0,7)  + date.substring(8,9);
        print(date);
      }
    }else if(date[8]=='0'){
      date =  date.substring(0,8)  + date.substring(9,10);
      print(date);
    }

    print('处理完成'+date);
    Response? res = await getJuHe(
        API.juHeAPI.wnl, '&date=$date', API.juHeAPI.wnlKey,isList: true);
    if (res == null) {
      return null;
    }
    LoggerData.addData(res);
    Map map = json.decode(res.data.toString());
    WanNianLiModel? model;
    model = WanNianLiModel.fromJson(map['result']['data'] as Map<String, dynamic>);
    return model;
  }
}