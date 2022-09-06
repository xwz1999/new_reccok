import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_recook/constants/constants.dart';
import 'package:new_recook/constants/styles.dart';
import 'package:new_recook/extensions/num_ext.dart';
import 'package:new_recook/gen/assets.gen.dart';
import 'package:new_recook/models/home/home_weather_model.dart';
import 'package:new_recook/utils/alert.dart';
import 'package:new_recook/widget/recook_back_button.dart';
import 'package:velocity_x/velocity_x.dart';

class HomeWeatherDetailPage extends StatefulWidget {
  final HomeWeatherModel? homeWeatherModel;
  HomeWeatherDetailPage({
    Key? key,
    this.homeWeatherModel,
  }) : super(key: key);

  @override
  _HomeWeatherDetailPageState createState() => _HomeWeatherDetailPageState();
}

class _HomeWeatherDetailPageState extends State<HomeWeatherDetailPage> {
  HomeWeatherModel? _homeWeatherModel;
  @override
  void initState() {
    super.initState();
    _homeWeatherModel = widget.homeWeatherModel;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: AppColor.frenchColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: RecookBackButton(
          white: _boolWhite(_homeWeatherModel!.weaImg),
        ),
        elevation: 0,
        title: Text(
          "天气",
          style: TextStyle(
            color: _getBackColor(_homeWeatherModel!.weaImg),
            fontSize: 36.sp,
          ),
        ),
      ),
      body: Stack(
        children: [
          Positioned(child: Container(
            height: 379*2.w+DeviceInfo.statusBarHeight! + DeviceInfo.appBarHeight,
            width: double.infinity,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(_getBackGroud(_homeWeatherModel!.weaImg)),
                    fit: BoxFit.fill)),
          )),
          _bodyWidget(),
        ],



      ),
    );
  }

  _bodyWidget() {
    return ListView(
      physics: ClampingScrollPhysics(),
      children: [
        Container(
          child: Container(
            width: double.infinity,
            height: 760.w,

            child: (Column(
              children: [
                140.hb,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _homeWeatherModel!.city??'',
                      style: TextStyle(fontSize: 40.sp, color: Colors.white),
                    ),
                    5.wb,
                    Image.asset(
                      Assets.weather.weatherLocation.path,
                      width: 40.w,
                      height: 39.w,
                    )
                  ],
                ),
                12.hb,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '°C',
                      style: TextStyle(
                          fontSize: 70.sp, color: Colors.transparent),
                    ),
                    Text(
                      _homeWeatherModel!.tem??'',
                      style: TextStyle(fontSize: 180.sp, color: Colors.white),
                    ),
                    Text(
                      '°C',
                      style: TextStyle(fontSize: 70.sp, color: Colors.white),
                    ),
                  ],
                ),
                14.hb,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _homeWeatherModel!.tem1??'',
                      style: TextStyle(fontSize: 36.sp, color: Colors.white),
                    ),
                    Text(
                      '°C',
                      style: TextStyle(fontSize: 36.sp, color: Colors.white),
                    ),
                    Text(
                      '/',
                      style: TextStyle(fontSize: 36.sp, color: Colors.white),
                    ),
                    Text(
                      _homeWeatherModel!.tem2??'',
                      style: TextStyle(fontSize: 36.sp, color: Colors.white),
                    ),
                    Text(
                      '°C',
                      style: TextStyle(fontSize: 36.sp, color: Colors.white),
                    ),
                  ],
                ),
                12.hb,
                Text(
                  _homeWeatherModel!.wea??'',
                  style: TextStyle(fontSize: 36.sp, color: Colors.white),
                ),
                Spacer(),
                Row(
                  children: [
                    Spacer(),
                    Text(
                      '空气',
                      style: TextStyle(fontSize: 36.sp, color: Colors.white),
                    ),
                    Text(
                      _homeWeatherModel!.airLevel??'',
                      style: TextStyle(fontSize: 36.sp, color: Colors.white),
                    ),
                    20.wb,
                  ],
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: _homeWeatherModel!.alarm?.alarmContent != ''
                          ? () {
                        Alert.show(
                            context,
                            NormalTextDialog(
                              title: '预警',
                              content:
                              _homeWeatherModel!.alarm!.alarmContent!,
                              titleColor: Color(0xFFEE0000),
                              //deleteItem: '确认',
                              items: ['确认'],
                              type: NormalTextDialogType.normal,
                              listener: (_) => Navigator.pop(context),
                              // deleteListener: () =>
                              //     Navigator.pop(context, true),
                            ));
                            }
                          : () {
                        Alert.show(
                            context,
                            NormalTextDialog(
                              title: '预警',
                              content: '暂无预警发布',
                              //deleteItem: '确认',
                              items: ['确认'],
                              type: NormalTextDialogType.normal,
                              listener: (_) => Navigator.pop(context),
                              // deleteListener: () =>
                              //     Navigator.pop(context, true),
                            ));
                            },
                      child: Row(
                        children: [
                          30.wb,
                          Text(
                            '天气预警',
                            style: TextStyle(
                                fontSize: 28.sp, color: Colors.white),
                          ),
                          Image.asset(
                            Assets.weather.weatherWaning.path,
                            height: 28.w,
                            width: 32.w,
                          ),
                        ],
                      ),
                    ),
                    Spacer(),
                    Text(
                      '气象台更新时间：',
                      style: TextStyle(fontSize: 28.sp, color: Colors.white),
                    ),
                    Text(
                      _homeWeatherModel!.updateTime??"",
                      style: TextStyle(fontSize: 28.sp, color: Colors.white),
                    ),
                    20.wb,
                  ],
                ),
                22.hb,
              ],
            )),
          ),
        ),
        Container(
          width: double.infinity,
          color: _getColor(_homeWeatherModel!.weaImg),
          child: Column(
            children: [
              _getDivider(),
              _bottomItem('湿度', '能见度', _homeWeatherModel!.humidity??"",
                  _homeWeatherModel!.visibility??""),
              _getDivider(),
              _bottomItem1(),
              _getDivider(),
              _bottomItem('PM2.5', 'PM10', _homeWeatherModel!.aqi==null?'': _homeWeatherModel!.aqi!.pm25Desc,
                  _homeWeatherModel!.aqi==null?'': _homeWeatherModel!.aqi!.pm10Desc),
              _getDivider(),
              _bottomItem('O3', 'NO2', _homeWeatherModel!.aqi==null?'':  _homeWeatherModel!.aqi!.o3Desc,
                  _homeWeatherModel!.aqi==null?'': _homeWeatherModel!.aqi!.no2Desc),
              _getDivider(),
              _bottomItem('SO2', '是否需要佩戴口罩',  _homeWeatherModel!.aqi==null?'': _homeWeatherModel!.aqi!.so2Desc,
                  _homeWeatherModel!.aqi==null?'':  _homeWeatherModel!.aqi!.kouzhao),
              _getDivider(),
              _bottomItem('风向', '风速',  _homeWeatherModel!.aqi==null?'': _homeWeatherModel!.win??"",
                  _homeWeatherModel!.aqi==null?'': _homeWeatherModel!.winSpeed??""),
              _getDivider(),
              _bottomItem('外出适宜', '开窗适宜',  _homeWeatherModel!.aqi==null?'': _homeWeatherModel!.aqi!.waichu,
                  _homeWeatherModel!.aqi==null?'':  _homeWeatherModel!.aqi!.kaichuang),
            ],
          ),
        )
      ],
    );
  }

  _getDivider() {
    return Divider(
      height: 2.w,
      color: Colors.white,
      indent: 20.w,
      endIndent: 20.w,
    );
  }

  _bottomItem1() {
    return Container(
        height: 156.w,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            30.wb,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 140.w,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '空气质量',
                        style: TextStyle(color: Colors.white, fontSize: 32.sp),
                      ),
                      Text(
                        _homeWeatherModel!.airLevel??"",
                        style: TextStyle(color: Colors.white, fontSize: 48.sp),
                      )
                    ],
                  ),
                )
              ],
            ),
            64.wb,
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  _homeWeatherModel!.airTips??"",
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.white, fontSize: 24.sp),
                ),
              ],
            ).expand()
          ],
        ));
  }

  _bottomItem(String title1, String title2, String content1, String content2) {
    return Container(
        height: 156.w,
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            30.wb,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title1,
                  style: TextStyle(color: Colors.white, fontSize: 32.sp),
                ),
                Text(
                  content1,
                  style: TextStyle(color: Colors.white, fontSize: 48.sp),
                )
              ],
            ).expand(),
            80.wb,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title2,
                  style: TextStyle(color: Colors.white, fontSize: 32.sp),
                ),
                Text(
                  content2,
                  style: TextStyle(color: Colors.white, fontSize: 48.sp),
                )
              ],
            ).expand()
          ],
        ));
  }

  _getBackGroud(String? weather) {
    switch (weather) {
      case 'xue':
        return Assets.weather.xunBg.path;
      case 'lei':
        return Assets.weather.leiBg.path;
      case 'shachen':
        return Assets.weather.shachenBg.path;
      case 'wu':
        return Assets.weather.wuBg.path;
      case 'bingbao':
        return Assets.weather.bingbaoBg.path;
      case 'yun':
        return Assets.weather.yunBg.path;
      case 'yu':
        return Assets.weather.yuBg.path;
      case 'yin':
        return Assets.weather.yinBg.path;
      case 'qing':
        return Assets.weather.qingBg.path;
    }
  }

  _getColor(String? weather) {
    switch (weather) {
      case 'xue':
        return Color(0xFF27080E);
      case 'lei':
        return Color(0xFF112027);
      case 'shachen':
        return Color(0xFFDC721C);
      case 'wu':
        return Color(0xFF013358);
      case 'bingbao':
        return Color(0xFF141D24);
      case 'yun':
        return Color(0xFF599BE9);
      case 'yu':
        return Color(0xFF414954);
      case 'yin':
        return Color(0xFF373F4A);
      case 'qing':
        return Color(0xFF64A8F1);
    }
  }

  _getBackColor(String? weather) {
    switch (weather) {
      case 'xue':
        return Color(0xFF333333);
      case 'lei':
        return Colors.white;
      case 'shachen':
        return Colors.white;
      case 'wu':
        return Colors.white;
      case 'bingbao':
        return Colors.white;
      case 'yun':
        return Color(0xFF333333);
      case 'yu':
        return Colors.white;
      case 'yin':
        return Colors.white;
      case 'qing':
        return Color(0xFF333333);
    }
  }

  _boolWhite(String? weather) {
    switch (weather) {
      case 'xue':
        return false;
      case 'lei':
        return true;
      case 'shachen':
        return true;
      case 'wu':
        return true;
      case 'bingbao':
        return true;
      case 'yun':
        return false;
      case 'yu':
        return true;
      case 'yin':
        return true;
      case 'qing':
        return false;
    }
  }
}
