import 'dart:convert';
import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_recook/constants/styles.dart';

// import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:new_recook/constants/api.dart';
import 'package:new_recook/extensions/num_ext.dart';
import 'package:new_recook/gen/assets.gen.dart';
import 'package:new_recook/models/goods/category_model.dart';
import 'package:new_recook/models/home/banner_list_model.dart';
import 'package:new_recook/models/home/home_weather_model.dart';
import 'package:new_recook/models/home/king_coin_list_model.dart';
import 'package:new_recook/models/home/promotion_list_model.dart';
import 'package:new_recook/pages/shop/classify_page.dart';
import 'package:new_recook/pages/shop/home_search_page.dart';
import 'package:new_recook/pages/shop/scan/barcodeScan.dart';
import 'package:new_recook/pages/shop/weather/home_weather_view.dart';
import 'package:new_recook/pages/splash/webView.dart';
import 'package:new_recook/utils/location_util.dart';
import 'package:new_recook/utils/permission_tool.dart';
import 'package:new_recook/utils/text_utils.dart';
import 'package:new_recook/widget/OverlayWidget.dart';
import 'package:new_recook/widget/home/banner.dart';
import 'package:new_recook/widget/home/home_gif_header.dart';
import 'package:new_recook/widget/home/home_sliver_app_bar.dart';
import 'package:new_recook/widget/home_countdown_widget.dart';
import 'package:new_recook/widget/image_network_widget.dart';
import 'package:new_recook/widget/refresh_widget.dart';
import 'package:new_recook/widget/weather/weather_city_model.dart';
import 'package:new_recook/widget/weather/weather_city_page.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:power_logger/power_logger.dart';
import 'package:get/get.dart' hide Response;
import 'package:velocity_x/velocity_x.dart';
import '../../widget/button/img_button.dart';
import 'animated_home_background.dart';
import 'function/activity_goods_page.dart';
import 'function/aku_college_page.dart';

class ShopHomePage extends StatefulWidget {
  const ShopHomePage({Key? key}) : super(key: key);

  @override
  _ShopHomePageState createState() => _ShopHomePageState();
}

class _ShopHomePageState extends State<ShopHomePage> with TickerProviderStateMixin {
  ///局部刷新
  final GlobalKey<AnimatedHomeBackgroundState> _animatedBackgroundState =
      GlobalKey<AnimatedHomeBackgroundState>();
  final GlobalKey<HomeSliverAppBarState> _sliverAppBarGlobalKey =
      GlobalKey<HomeSliverAppBarState>();
  HomeCountdownController? _homeCountdownController;
  /// 天气数据
  HomeWeatherModel? _homeWeatherModel;
  ///城市选择数据
  WeatherCityModel? _weatherCityModel;

  String? keyWords = '';
  String cityName = '';

  ///高度
  double screenWidth = 0;
  double weatherHeight = 0;
  double bannerHeight = 0;
  double buttonsHeight = 200.w;
  double t1Height = 0;
  double t23Height = 0;
  double t4Height = 0;
  double timeHeight = 60.w;
  double tabbarHeight = 40.w;
  double? expandedHeight = 1600.w;

  Color? _backgroundColor;
  GSRefreshController? _gsRefreshController;
  ScrollController? _sliverListController;
  List<BannerModel>? _bannerList = [];
  List<Promotion>? _promotionList = [];
  TabController? _tabController;
  List<KingCoinListModel>? kingCoinListModelList;
  Map? _activityMap;
  late StateSetter _bannerState;
  late LocationUtil locationUtil = LocationUtil();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _promotionList!.length, vsync: this);
    Future.delayed(Duration.zero, () async {
      bool location = await Permission.location.isGranted;
      if (Platform.isIOS||location == true) {
        locationUtil.getCurrentLocation((Map result){
          cityName = result['city']??"";
          cityName = cityName.replaceAll("区", "");
          cityName = cityName.replaceAll("市", "");
          _getWeather();
          print('cityName:$cityName');
        }).catchError((err){
        });
      }else{
        _getWeather();
      }
    });


    _homeCountdownController = HomeCountdownController();
    _gsRefreshController = GSRefreshController(initialRefresh: true);
    _sliverListController = ScrollController();
    kingCoinListModelList = [
      KingCoinListModel(data: [
        KingCoin(
            id: 1,
            url: "/photo/20220719/7f750c3890d79e8bcac665cc9ee93087.png",
            name: "阿库学院",
          kingName: KingName(name:"阿库学院" )
        )
      ]),
      KingCoinListModel(data: [
        KingCoin(
            id: 1,
            url: "/photo/20220719/7f750c3890d79e8bcac665cc9ee93087.png",
            name: "京东优选",
            kingName: KingName(name:"热销榜单" )
        )
      ]),
      KingCoinListModel(data: [
        KingCoin(
            id: 1,
            url: "/photo/20220719/7f750c3890d79e8bcac665cc9ee93087.png",
            name: "京东优选")
      ]),
      KingCoinListModel(data: [
        KingCoin(
            id: 1,
            url: "/photo/20220719/7f750c3890d79e8bcac665cc9ee93087.png",
            name: "京东优选")
      ]),
      KingCoinListModel(data: [
        KingCoin(
            id: 1,
            url: "/photo/20220719/7f750c3890d79e8bcac665cc9ee93087.png",
            name: "京东优选")
      ]),
    ];
    _bannerList = [
      BannerModel(
          0,
          0,
          'https://mallcdn.reecook.cn/static/photo/20220729/a7d386be2c1d8bc5eaca5c4f2d8f52b8.jpg',
          '',
          '',
          '#D07B15'),
      BannerModel(
          0,
          0,
          'https://mallcdn.reecook.cn/static/photo/20220729/a7d386be2c1d8bc5eaca5c4f2d8f52b8.jpg',
          '',
          '',
          '#69A4A4'),
      BannerModel(
          0,
          0,
          'https://mallcdn.reecook.cn/static/photo/20220729/a7d386be2c1d8bc5eaca5c4f2d8f52b8.jpg',
          '',
          '',
          '#99AD33'),
    ];
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    weatherHeight = (76.w + ScreenUtil().statusBarHeight);
    bannerHeight = (screenWidth - 20.w) / 2.34;
    t1Height = (screenWidth - 20.w) * 0.3429;
    t23Height = ((screenWidth - 28.w) / 2) * 0.5 + 10;
    t4Height = (screenWidth - 20.w) * 0.2714;

    return WillPopScope(
      onWillPop: () async {
        await Get.dialog(CupertinoAlertDialog(
          title: '提示'.text.isIntrinsic.make(),
          content: '是否跳转到桌面？'.text.isIntrinsic.make(),
          actions: [
            CupertinoDialogAction(
              child: '取消'.text.isIntrinsic.make(),
              onPressed: Get.back,
            ),
            CupertinoDialogAction(
              child: '确定'.text.red600.isIntrinsic.make(),
              onPressed: () => Get.back(result: true),
            ),
          ],
        ));

        return false; //一定要return false
      },
      child: Scaffold(body: _bodyWidget()),
    );
  }

  _bodyWidget() {
    return Stack(
      children: [
        RefreshWidget(
          isInNest: true,
          color: Colors.black,
          controller: _gsRefreshController,
          header: HomeGifHeader(),
          onRefresh: () async {
            if (_gsRefreshController!.isRefresh()) {
              // Future.delayed(Duration(milliseconds: 1500), () {
              _gsRefreshController!.refreshCompleted();
              _gsRefreshController!.loadNoData();
              // });
            }
          },
          body: CustomScrollView(
            controller: _sliverListController,
            slivers: [
              HomeSliverAppBar(
                  key: _sliverAppBarGlobalKey,
                  actions: _actions(),
                  title: _buildTitle(),
                  backgroundColor: AppColor.themeColor,
                  flexibleSpace: _flexibleSpaceBar(),
                  expandedHeight: expandedHeight,
                  bottom: _preferredSize()),
            ],
          ),
        ),
        OverlayLivingBtnWidget(index: 1,),
      ],
    );
  }

  _actions() {
    return [
      Padding(
        padding: EdgeInsets.only(bottom: 30.w, left: 20.w, right: 20.w),
        child: ImgButton(
          path: Assets.icons.navigationMsg.path,
          width: 40.w,
          height: 40.w,
          onPressed: () {},
        ),
      ),
    ];
  }

  Widget _buildTitle() {
    String lastCity = '';

      if(_homeWeatherModel != null && !TextUtils.isEmpty(_homeWeatherModel!.city)){
        lastCity = _homeWeatherModel!.city!.length > 6
            ? _homeWeatherModel!.city!.substring(0, 6)
            : _homeWeatherModel!.city!;
      }else{
        lastCity = '';
      }

    return Container(
      height: kToolbarHeight,
      color: Colors.transparent,
      child: Column(
        children: <Widget>[
          Container(
            height: 40,
            child: Row(
              children: <Widget>[
                GestureDetector(
                  onTap: ()async{
                    print('点击了');
                    await PermissionTool.haveLocationPermission().then((value)  {
                      if(value){
                        locationUtil.getCurrentLocation((Map result){
                          cityName = result['city']??"";
                          cityName = cityName.replaceAll("区", "");
                          cityName = cityName.replaceAll("市", "");
                          print('cityName:$cityName');

                        }).catchError((err){

                        });
                      }
                      else{
                        PermissionTool.showOpenPermissionDialog(
                            context, '如果您想要改变您的定位，请先打开定位权限。');
                      }
                    });


                    if(cityName!=''){
                      Get.to(() => WeatherCityPage(cityName: cityName,
                      ))
                          ?.then((model) {
                        if (model is WeatherCityModel) {
                          _weatherCityModel = model;
                          _getWeather();
                        }
                      });
                    }

                  },
                  child: Container(
                    color: Colors.transparent,
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.place, color: Colors.white, size: 32.w),
                        Container(
                          width: 2,
                        ),
                        Text(
                          lastCity,
                          overflow: TextOverflow.fade,
                          maxLines: 1,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 28.sp,
                          ),
                        ),
                        Container(
                          width: 10.w,
                        ),
                      ],
                    ),
                  ),

                ),
                Expanded(
                  child: GestureDetector(
                    child: Container(
                      margin: EdgeInsets.only(top: 5, bottom: 5),
                      height: 30,
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(20)),
                      child: Row(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(left: 10),
                            width: 32.w,
                            height: 32.w,
                            child: Image.asset(
                              Assets.icons.homeTabSearch.path,
                              width: 32.w,
                              height: 32.w,
                            ),
                          ),
                          Container(
                            width: 6,
                          ),
                          Text(
                            keyWords!,
                            style: TextStyle(
                                color: Colors.white.withOpacity(0.9),
                                fontSize: 13 * 2.sp,
                                fontWeight: FontWeight.w300),
                          ),
                          Spacer(),
                          GestureDetector(
                            onTap: () async {
                              if (Platform.isIOS) {
                                Get.to(() => BarcodeScanPage());
                                return;
                              }
                              bool permission =
                                  await Permission.camera.isGranted;
                              if (!permission) {
                                Get.dialog(
                                  CupertinoAlertDialog(
                                    title: Text('需要获取相机使用权限'),
                                    content: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        //Image.asset(R.ASSETS_LOCATION_PER_PNG,width: 44.rw,height: 44.rw,),
                                        Text(
                                          '允许应用使用相机来扫码识别商品',
                                          style: TextStyle(
                                              color: Color(0xFF666666),
                                              fontSize: 28.sp),
                                        ),
                                      ],
                                    ),
                                    actions: [
                                      CupertinoDialogAction(
                                        child: Text('残忍拒绝'),
                                        onPressed: () => Get.back(),
                                      ),
                                      CupertinoDialogAction(
                                        child: Text('立即授权'),
                                        onPressed: () async {
                                          Get.back();
                                          bool canUseCamera =
                                              await PermissionTool
                                                  .haveCameraPermission();
                                          if (!canUseCamera) {
                                            PermissionTool
                                                .showOpenPermissionDialog(
                                                    context,
                                                    "没有相机使用权限,授予相机使用权限后才能进行扫码");
                                            return;
                                          } else {
                                            Get.to(() => BarcodeScanPage());
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                  barrierDismissible: false,
                                );
                              } else {
                                Get.to(() => BarcodeScanPage());
                              }
                            },
                            child: Container(
                              width: 50.w,
                              height: 50.w,
                              alignment: Alignment.center,
                              child: Image.asset(
                                Assets.icons.navigationScan.path,
                                fit: BoxFit.cover,
                                width: 34.w,
                                height: 34.w,
                              ),
                            ),
                          ),
                          22.wb,
                        ],
                      ),
                    ),
                    onTap: () {
                      Get.to(()=>HomeSearchPage());
                    },
                  ),
                )
              ],
            ),
            // child: ges,
          ),
          // Spacer()
        ],
      ),
    );
  }

  FlexibleSpaceBar _flexibleSpaceBar() {
    return FlexibleSpaceBar(
      collapseMode: CollapseMode.pin,
      background: Container(
          //头部整个背景颜色
          height: double.infinity,
          color: AppColor.frenchColor,
          // color: Colors.white,
          child: Stack(
            children: <Widget>[
              AnimatedHomeBackground(
                key: _animatedBackgroundState,
                height: weatherHeight + bannerHeight - 32,
                backgroundColor:
                    _backgroundColor == null ? Colors.white : _backgroundColor!,
              ),
              Column(
                children: <Widget>[
                  HomeWeatherWidget(
                    backgroundColor: Colors.white.withAlpha(0),
                    homeWeatherModel:_homeWeatherModel
                  ),
                  _bannerView(),
                  _buildGoodsCards(),
                  kingCoinListModelList == null
                      ? Container(
                          height: buttonsHeight,
                        )
                      : _buttonTitle(),
                  _activityImageTitle(),
                  _activityImageRow(),
                  _activityT4Image(),
                  HomeCountdownWidget(
                    height: timeHeight,
                    controller: _homeCountdownController,
                  ),
                ],
              ),
            ],
          )),
    );
  }

  _activityImageTitle() {
    HomeAcitvityItem? item;
    if (_activityMap != null && _activityMap!.containsKey('a')) {
      item = _activityMap!['a'];
    }
    return GestureDetector(
      onTap: () {
        if (item != null && !TextUtils.isEmpty(item.website)) {
          Get.to(() => WebViewPage(
            url: item!.website, title: "活动",
          ));
        }
      },
      child: Container(
        color: AppColor.frenchColor,
        padding: EdgeInsets.only(
          left: 20.w,
          right: 20.w,
        ),
        child: ClipRRect(
          child: _activityMap != null && _activityMap!.containsKey('a')
              ? FadeInImage.assetNetwork(
            placeholder: Assets.images.placeholderNew2x1A.path,
            image: API.getImgUrl(item!.logoUrl)!,
            fit: BoxFit.fill,
            imageErrorBuilder: (context, error, stackTrace) {
              return Image.asset(Assets.images.placeholderNew2x1A.path, fit: BoxFit.fill,);
            },
          )
              : Image.asset(
            Assets.images.placeholderNew2x1A.path,
            fit: BoxFit.fitWidth,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(5),
          ),
        ),
        height: t1Height,
        width: screenWidth,
      ),
    );
  }
  _activityT4Image() {
    HomeAcitvityItem? itemD;
    if (_activityMap != null && _activityMap!.containsKey('d')) {
      itemD = _activityMap!['d'];
    }
    Container con = Container(
      width: screenWidth,
      height: t4Height,
      color: AppColor.frenchColor,
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: ClipRRect(
        child: _activityMap != null && _activityMap!.containsKey('d')
            ? FadeInImage.assetNetwork(
                placeholder: Assets.images.placeholderNew2x1A.path,
                image: API.getImgUrl(itemD!.logoUrl)!,
                fit: BoxFit.fill,
                imageErrorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    Assets.images.placeholderNew2x1A.path,
                    fit: BoxFit.fill,
                  );
                },
              )
            : Image.asset(
                Assets.images.placeholderNew2x1A.path,
                fit: BoxFit.fitWidth,
              ),
        borderRadius: BorderRadius.all(
          Radius.circular(5),
        ),
      ),
    );
    return GestureDetector(
      onTap: () {
        if (itemD != null && !TextUtils.isEmpty(itemD.website)) {
          Get.to(() => WebViewPage(
                url: itemD!.website,
                title: "活动",
              ));
        }
      },
      child: con,
    );
  }

  _activityImageRow() {
    HomeAcitvityItem? itemB, itemC;
    if (_activityMap != null && _activityMap!.containsKey('b')) {
      itemB = _activityMap!['b'];
    }
    if (_activityMap != null && _activityMap!.containsKey('c')) {
      itemC = _activityMap!['c'];
    }
    return Container(
      color: AppColor.frenchColor,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.w),
      height: t23Height,
      width: screenWidth,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      if (itemB != null && !TextUtils.isEmpty(itemB.website)) {
                        Get.to(() => WebViewPage(
                              url: itemB!.website,
                              title: "活动",
                            ));
                      }
                    },
                    child: Container(
                      child: ClipRRect(
                        child: _activityMap != null &&
                                _activityMap!.containsKey('b')
                            ? FadeInImage.assetNetwork(
                                placeholder:
                                    Assets.images.placeholderNew2x1A.path,
                                image: API.getImgUrl(itemB!.logoUrl)!,
                                fit: BoxFit.fill,
                                imageErrorBuilder:
                                    (context, error, stackTrace) {
                                  return Image.asset(
                                    Assets.images.placeholderNew2x1A.path,
                                    fit: BoxFit.fill,
                                  );
                                },
                              )
                            : Image.asset(
                                Assets.images.placeholderNew2x1A.path,
                                fit: BoxFit.fitWidth,
                              ),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(5),
                          topRight: Radius.circular(5),
                          bottomLeft: Radius.circular(5),
                          bottomRight: Radius.circular(5),
                        ),
                      ),
                      height: t23Height,
                    ),
                  ),
                ),
                Container(
                  width: 10.w,
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      if (itemC != null && !TextUtils.isEmpty(itemC.website)) {
                        Get.to(() => WebViewPage(
                              url: itemC!.website,
                              title: "活动",
                            ));
                      }
                    },
                    child: Container(
                      child: ClipRRect(
                        child: _activityMap != null &&
                                _activityMap!.containsKey('c')
                            ? FadeInImage.assetNetwork(
                                placeholder:
                                    Assets.images.placeholderNew2x1A.path,
                                image: API.getImgUrl(itemC!.logoUrl)!,
                                fit: BoxFit.fill,
                                imageErrorBuilder:
                                    (context, error, stackTrace) {
                                  return Image.asset(
                                    Assets.images.placeholderNew2x1A.path,
                                    fit: BoxFit.fill,
                                  );
                                },
                              )
                            : Image.asset(
                                Assets.images.placeholderNew2x1A.path,
                                fit: BoxFit.fitWidth,
                              ),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(5),
                          topRight: Radius.circular(5),
                          bottomLeft: Radius.circular(5),
                          bottomRight: Radius.circular(5),
                        ),
                      ),
                      height: t23Height,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _activityImage234() {
    HomeAcitvityItem? itemB, itemC, itemD;
    if (_activityMap != null && _activityMap!.containsKey('b')) {
      itemB = _activityMap!['b'];
    }
    if (_activityMap != null && _activityMap!.containsKey('c')) {
      itemC = _activityMap!['c'];
    }
    if (_activityMap != null && _activityMap!.containsKey('d')) {
      itemD = _activityMap!['d'];
    }
    return Container(
      color: AppColor.frenchColor,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.w),
      height: t23Height + 100.w,
      width: screenWidth,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      if (itemB != null && !TextUtils.isEmpty(itemB.website)) {
                        LoggerData.addData(itemB.website, tag: "BB");
                        Get.to(() => WebViewPage(
                              url: itemB!.website,
                              title: "活动",
                            ));
                      }
                    },
                    child: Container(
                      child: ClipRRect(
                        child: _activityMap != null &&
                                _activityMap!.containsKey('b')
                            ? FadeInImage.assetNetwork(
                                placeholder:
                                    Assets.images.placeholderNew1x1A.path,
                                image: API.getImgUrl(itemB!.logoUrl)!,
                                fit: BoxFit.fill,
                                imageErrorBuilder:
                                    (context, error, stackTrace) {
                                  return Image.asset(
                                    Assets.images.placeholderNew1x1A.path,
                                    fit: BoxFit.fill,
                                  );
                                },
                              )
                            : Image.asset(
                                Assets.images.placeholderNew1x1A.path,
                                fit: BoxFit.fill,
                              ),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(5),
                          topRight: Radius.circular(5),
                          bottomLeft: Radius.circular(5),
                          bottomRight: Radius.circular(5),
                        ),
                      ),
                      height: t23Height + 100.w,
                    ),
                  ),
                ),
              ],
            ),
          ),
          8.wb,
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      if (itemC != null && !TextUtils.isEmpty(itemC.website)) {
                        LoggerData.addData(itemC.website, tag: "cc");

                        Get.to(() => WebViewPage(
                              url: itemC!.website,
                              title: "活动",
                            ));
                      }
                    },
                    child: Container(
                      child: ClipRRect(
                        child: _activityMap != null &&
                                _activityMap!.containsKey('c')
                            ? FadeInImage.assetNetwork(
                                placeholder:
                                    Assets.images.placeholderNew2x1A.path,
                                image: API.getImgUrl(itemC!.logoUrl)!,
                                fit: BoxFit.fill,
                                imageErrorBuilder:
                                    (context, error, stackTrace) {
                                  return Image.asset(
                                    Assets.images.placeholderNew2x1A.path,
                                    fit: BoxFit.fill,
                                  );
                                },
                              )
                            : Image.asset(
                                Assets.images.placeholderNew2x1A.path,
                                fit: BoxFit.fitWidth,
                                width: double.infinity,
                              ),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(5),
                          topRight: Radius.circular(5),
                          bottomLeft: Radius.circular(5),
                          bottomRight: Radius.circular(5),
                        ),
                      ),
                      height: t23Height,
                    ),
                  ),
                ),
                8.hb,
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      if (itemD != null && !TextUtils.isEmpty(itemD.website)) {
                        LoggerData.addData(itemD.website, tag: "DD");

                        Get.to(() => WebViewPage(
                              url: itemD!.website,
                              title: "活动",
                            ));
                      }
                    },
                    child: Container(
                      child: ClipRRect(
                        child: _activityMap != null &&
                                _activityMap!.containsKey('d')
                            ? FadeInImage.assetNetwork(
                                placeholder:
                                    Assets.images.placeholderNew2x1A.path,
                                image: API.getImgUrl(itemD!.logoUrl)!,
                                fit: BoxFit.fill,
                                imageErrorBuilder:
                                    (context, error, stackTrace) {
                                  return Image.asset(
                                    Assets.images.placeholderNew2x1A.path,
                                    fit: BoxFit.fill,
                                  );
                                },
                              )
                            : Image.asset(
                                Assets.images.placeholderNew2x1A.path,
                                fit: BoxFit.fitWidth,
                                width: double.infinity,
                              ),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(5),
                          topRight: Radius.circular(5),
                          bottomLeft: Radius.circular(5),
                          bottomRight: Radius.circular(5),
                        ),
                      ),
                      height: t23Height,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  PreferredSize _preferredSize() {
    return PreferredSize(
      preferredSize: Size.fromHeight(tabbarHeight),
      child: Container(
        alignment: Alignment.center,
        color: AppColor.frenchColor,
        // child: HomePageTabbar(
        //   promotionList: _promotionList,
        //   timerJump: (index) {
        //     //_tabIndex = index;
        //     _homeCountdownController!.indexChange(index);
        //     // 定时任务回调
        //     _tabController!.animateTo(index);
        //     //_getPromotionGoodsList(_promotionList![index].id);
        //   },
        //   clickItem: (index) {
        //     _homeCountdownController!.indexChange(index);
        //     //_getPromotionGoodsList(_promotionList![index].id);
        //   },
        //   tabController: _tabController,
        // ),
      ),
    );
  }

  _bannerView() {
    if (_backgroundColor == null &&
        _bannerList != null &&
        _bannerList!.length > 0) {
      BannerModel bannerModel = _bannerList![0];
      if (!TextUtils.isEmpty(bannerModel.color)) {
        Color color = TextUtils.hexToColor(bannerModel.color);
        _backgroundColor = color;
        _animatedBackgroundState.currentState?.changeColor(color);
        _sliverAppBarGlobalKey.currentState?.updateColor(color);
      }
    }
    Widget banner =
        StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
      _bannerState = setState;
      if (_bannerList == null || _bannerList!.length == 0) {
        return Container(
          height: bannerHeight,
        );
      }
      BannerListView bannerListView = BannerListView<BannerModel>(
        onPageChanged: (index) {
          int realIndex = index;
          if (realIndex < 0) return;
          if (realIndex >= _bannerList!.length) realIndex = 0;
          BannerModel bannerModel = _bannerList![realIndex];
          if (!TextUtils.isEmpty(bannerModel.color)) {
            Color color = TextUtils.hexToColor(bannerModel.color);
            _backgroundColor = color;
            _animatedBackgroundState.currentState!.changeColor(color);
            _sliverAppBarGlobalKey.currentState!.updateColor(color);
          }
        },
        height: bannerHeight,
        margin: EdgeInsets.symmetric(horizontal: 10),
        radius: 10,
        data: _bannerList,
        builder: (context, bannerModel) {
          return GestureDetector(
              onTap: () {},
              child: ImageNetworkWidget(
                placeholder: Assets.images.placeholderNew2x1A.path,
                url: bannerModel.url,
                fit: BoxFit.fill,
              ));
        },
      );
      return bannerListView;
    });
    return Container(
      width: screenWidth,
      height: bannerHeight,
      color: Colors.white.withAlpha(0),
      child: Stack(
        children: <Widget>[
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            top: 0,
            child: _bannerList == null ? Container() : banner,
          )
        ],
      ),
    );
  }

  _buttonTitle() {
    Container titles = Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    _buttonTitleRow(
                      kingCoinListModelList![0],
                    ),
                    _buttonTitleRow(
                      kingCoinListModelList![1],
                    ),
                    _buttonTitleRow(
                      kingCoinListModelList![2],
                    ),
                    _buttonTitleRow(
                      kingCoinListModelList![3],
                    ),
                    _buttonTitleRow(
                      kingCoinListModelList![4],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      color: AppColor.frenchColor,
      height: buttonsHeight,
      width: MediaQuery.of(context).size.width,
      child: titles,
    );
  }

  _buttonTitleRow(
    KingCoinListModel? kingCoin,
  ) {
    return Expanded(
      child: CupertinoButton(
        padding: EdgeInsets.zero,
        child: Column(
          children: <Widget>[
            Container(
              height: 10,
            ),
            Container(
                margin: EdgeInsets.only(top: 10.w),
                width: 96.w,
                height: 96.w,
                child: kingCoin == null
                    ? Image.asset(
                        Assets.images.placeholderNew1x1A.path,
                        height: 96.w,
                        width: 96.w,
                      )
                    : FadeInImage.assetNetwork(
                        placeholder: Assets.images.placeholderNew1x1A.path,
                        image: API.getImgUrl(kingCoin.data!.first.url,
                                isPrint: true) ??
                            '',
                        imageErrorBuilder: (context, error, stackTrace) {
                          return Image.asset(
                            Assets.images.placeholderNew1x1A.path,
                            height: 96.w,
                            width: 96.w,
                          );
                        },
                      )),
            Container(
              margin: EdgeInsets.only(top: 16.w),
              child: Text(
                kingCoin == null ? '' : kingCoin.data!.first.name ?? "",
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 24.sp,
                    color: Colors.black.withOpacity(0.8)),
              ),
            )
          ],
        ),
        onPressed: () {
          _kingCoinGet(kingCoin!.data!.first.kingName!.name);
        },
      ),
    );
  }

  _kingCoinGet(String? name) async {
    switch (name) {
      case '生活服务':
        break;
      case '京东优选':
        break;
      case '一键邀请':
        break;
      case '热销榜单':
        Get.to(()=>ActivityGoodsPage(type: 1,));
        break;
      case '进口专区':
        break;
      case '特惠专区':
        break;
      case '高额返补':
        break;
      case 'VIP权益':
        break;
      case '阿库学院':
        Get.to(()=>AkuCollegePage());
        break;
      case '家居生活':
        break;
      case '数码家电':
        break;
      case '生活服务':
        break;
      case '日用百货':
        break;
      case '酒饮冲调':
        break;
      case '休闲美食':
        break;
      case '茶米油盐':
        break;
      case '个护清洁':
        break;
      case '家用电器':
        break;
      case '母婴用品':
        break;
      case '美妆护肤':
        break;
      case '全部分类':
        break;
    }
  }

  ///首页上方分类功能卡片
  _buildGoodsCards() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 132.w,
      child: Row(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.only(left: 20.w),
              scrollDirection: Axis.horizontal,
              children: [
                _buildSingleGoodsCard(Assets.home.icRice.path, '柴米油盐'),
                _buildSingleGoodsCard(Assets.home.icClean.path, '个护清洁'),
                _buildSingleGoodsCard(Assets.home.icDepartment.path, '日用百货'),
                _buildSingleGoodsCard(Assets.home.icWine.path, '酒饮冲调'),
                _buildSingleGoodsCard(Assets.home.icTea.path, '休闲美食'),
                _buildSingleGoodsCard(Assets.home.icFood.path, '有机食品'),
                _buildSingleGoodsCard(Assets.home.icVegetables.path, '蔬果生鲜'),
                _buildSingleGoodsCard(Assets.home.icElectricity.path, '家用电器'),
                _buildSingleGoodsCard(Assets.home.icPhone.path, '手机数码'),
                _buildSingleGoodsCard(Assets.home.icBaby.path, '母婴用品'),
                _buildSingleGoodsCard(Assets.home.icSport.path, '运动旅行'),
                _buildSingleGoodsCard(Assets.home.icMedicalbox.path, '医疗保健'),
                _buildSingleGoodsCard(Assets.home.icHair.path, '美妆护肤'),
                _buildSingleGoodsCard(Assets.home.icBook.path, '图文教育'),
                _buildSingleGoodsCard(Assets.home.icFurniture.path, '家具饰品'),
                _buildSingleGoodsCard(Assets.home.icClothes.path, '服饰内衣'),
                _buildSingleGoodsCard(Assets.home.icBag.path, '鞋靴箱包'),
              ],
            ),
          ),
          Container(
            height: 124.w,
            decoration: BoxDecoration(
              color: AppColor.frenchColor,
              boxShadow: [
                //使用多层阴影的方式实现单边boxShadow
                /// more at [stackoverflow](https://stackoverflow.com/a/65296931/7963151)
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                  offset: Offset(-5, 0),
                ),

                BoxShadow(color: AppColor.frenchColor, offset: Offset(0, 16)),
                BoxShadow(color: AppColor.frenchColor, offset: Offset(16, 0)),
              ],
            ),
            child:
                _buildSingleGoodsCard(Assets.home.icClassification.path, '分类'),
          ),
        ],
      ),
    );
  }

  Widget _buildSingleGoodsCard(String path, String name) {
    return MaterialButton(
      minWidth: 108.w,
      padding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      onPressed: () async {
        var cancel = BotToast.showLoading();
        cancel();
        Get.to(() => ClassifyPage(data: [
          FirstCategory(
            name: '日用百货',
            sub: [
              SecondCategory(
                1,'枕头枕巾',2,''
              ),
              SecondCategory(
                  1,'烧烤烘焙',2,''
              ),
              SecondCategory(
                  1,'车品',2,''
              ),
              SecondCategory(
                  1,'厨房收纳',2,''
              ),
            ]
          ),
          FirstCategory(
              name: '酒饮冲调',
              sub: [
                SecondCategory(
                    1,'酒类',2,''
                ),
                SecondCategory(
                    1,'牛奶饮料',2,''
                ),
                SecondCategory(
                    1,'茗茶',2,''
                ),
                SecondCategory(
                    1,'麦片谷物',2,''
                ),
              ]
          ),
          FirstCategory(
              name: '休闲美食',
              sub: [
                SecondCategory(
                    1,'坚果炒货',2,''
                ),
                SecondCategory(
                    1,'面包蛋糕',2,''
                ),
                SecondCategory(
                    1,'饼干薯片',2,''
                ),
                SecondCategory(
                    1,'肉蒲熟食',2,''
                ),
              ]
          )
        ],
        initValue: name,
        ));
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            path,
            height: 56.w,
            width: 56.w,
          ),
          Text(
            name,
            style: TextStyle(
              color: Color(0xFF333333),
              fontSize: 20.sp,
            ),
          ),
        ],
      ),
    );
  }


  _getWeather() async {
    // if (_weatherLocation==null)
    //cityid、city和ip参数3选一提交，如果不传，默认返回当前ip城市天气，cityid优先级最高。
    String url =
        "https://v0.yiketianqi.com/api?version=v61&appid=81622428&appsecret=AxKzYWq3";
    if (_weatherCityModel != null &&
        !TextUtils.isEmpty(_weatherCityModel!.id)) {
      url = "$url&cityid=${_weatherCityModel!.id}";
    } else if (_weatherCityModel != null &&
        !TextUtils.isEmpty(_weatherCityModel!.cityZh)) {
      url = "$url&city=${_weatherCityModel!.cityZh}";
    } else if (
        !TextUtils.isEmpty(cityName)) {
        String city = (cityName).replaceAll("区", "");
        city = city.replaceAll("市", "");
        url = "$url&city=$city";
    }
    Response? res = await Dio().get(
      url,options:Options(responseType: ResponseType.plain)
    );

    LoggerData.addData(res);
    Map map = json.decode(res.data.toString());
    _homeWeatherModel = HomeWeatherModel.fromJson(map as Map<String, dynamic>);

    if (mounted) setState(() {});
  }

}

class HomeItem {
  String title;
  String imagePath;

  HomeItem(this.title, this.imagePath);
}

class HomeAcitvityItem {
  String? logoUrl;
  String? website;

  HomeAcitvityItem(this.logoUrl, this.website);
}
