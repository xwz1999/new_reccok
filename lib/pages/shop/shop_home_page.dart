import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:new_recook/constants/styles.dart';

// import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:new_recook/gen/assets.gen.dart';
import 'package:new_recook/models/home/banner_list_model.dart';
import 'package:new_recook/utils/headers.dart';
import 'package:new_recook/utils/permission_tool.dart';
import 'package:new_recook/utils/text_utils.dart';
import 'package:new_recook/widget/home/banner.dart';
import 'package:new_recook/widget/home/home_gif_header.dart';
import 'package:new_recook/widget/home/home_sliver_app_bar.dart';
import 'package:new_recook/widget/refresh_widget.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../widget/button/img_button.dart';
import 'animated_home_background.dart';

class ShopHomePage extends StatefulWidget {
  const ShopHomePage({Key? key}) : super(key: key);

  @override
  _ShopHomePageState createState() => _ShopHomePageState();
}

class _ShopHomePageState extends State<ShopHomePage> {
  ///局部刷新
  final GlobalKey<AnimatedHomeBackgroundState> _animatedBackgroundState = GlobalKey<AnimatedHomeBackgroundState>();
  final GlobalKey<HomeSliverAppBarState> _sliverAppBarGlobalKey = GlobalKey<HomeSliverAppBarState>();

  String? keyWords = '';
  String? cityName = '';

  ///高度
  double screenWidth = 0;
  double weatherHeight = 0;
  double bannerHeight = 0;
  double buttonsHeight = 100.w;
  double t1Height = 0;
  double t23Height = 0;
  double t4Height = 0;
  double timeHeight = 60.w;
  double tabbarHeight = 40.w;
  double? expandedHeight = 800.w;

  Color? _backgroundColor;
  GSRefreshController? _gsRefreshController;
  ScrollController? _sliverListController;
  List<BannerModel>? _bannerList = [];

  late StateSetter _bannerState;

  @override
  void initState() {
    super.initState();
    _gsRefreshController = GSRefreshController(initialRefresh: true);
    _sliverListController = ScrollController();
    _bannerList = [
      BannerModel(0,0,'https://mallcdn.reecook.cn/static/photo/20220729/a7d386be2c1d8bc5eaca5c4f2d8f52b8.jpg','','','#D07B15'),
      BannerModel(0,0,'https://mallcdn.reecook.cn/static/photo/20220729/a7d386be2c1d8bc5eaca5c4f2d8f52b8.jpg','','','#69A4A4'),
      BannerModel(0,0,'https://mallcdn.reecook.cn/static/photo/20220729/a7d386be2c1d8bc5eaca5c4f2d8f52b8.jpg','','','#99AD33'),
    ];
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    weatherHeight = (76 + ScreenUtil().statusBarHeight);
    bannerHeight = (screenWidth - 20) / 2.34;
    t1Height = (screenWidth - 20) * 0.3429;
    t23Height = ((screenWidth - 28) / 2) * 0.5 + 10;
    t4Height = (screenWidth - 20) * 0.2714;

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
    return RefreshWidget(
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
              bottom: _preferredSize()
          ),
        ],
      ),
    );
  }

  _actions() {
    return [
      ImgButton(
        path: Assets.icons.navigationMsg.path,
        width: 40.w,
        height: 40.w,
        onPressed: () {},
      ),
    ];
  }

  Widget _buildTitle() {
    GestureDetector scanCon = GestureDetector(
      onTap: () async {
        if (Platform.isIOS) {
          // Get.to(() => BarcodeScanPage());
          return;
        }
        bool permission = await Permission.camera.isGranted;
        if (!permission) {
          Get.dialog(
            CupertinoAlertDialog(
              title: Text('需要获取相机使用权限'),
              content: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //Image.asset(R.ASSETS_LOCATION_PER_PNG,width: 44.rw,height: 44.rw,),
                  Text(
                    '允许应用使用相机来扫码识别商品',
                    style: TextStyle(color: Color(0xFF666666), fontSize: 28.sp),
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
                        await PermissionTool.haveCameraPermission();
                    if (!canUseCamera) {
                      PermissionTool.showOpenPermissionDialog(
                          context, "没有相机使用权限,授予相机使用权限后才能进行扫码");
                      return;
                    } else {
                      //Get.to(() => BarcodeScanPage());
                    }
                  },
                ),
              ],
            ),
            barrierDismissible: false,
          );
        } else {
          //Get.to(() => BarcodeScanPage());
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
    );

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
                  child: Container(
                    color: Colors.transparent,
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.place, color: Colors.white, size: 32.w),
                        Container(
                          width: 2,
                        ),
                        Text(
                          cityName!,
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
                      // height: rSize(30),
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
                          scanCon,
                          22.wb,
                        ],
                      ),
                    ),
                    onTap: () {},
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
                  _bannerView(),
                ],
              ),
            ],
          )),
    );
  }

  PreferredSize _preferredSize() {
    return PreferredSize(
      preferredSize: Size.fromHeight(tabbarHeight),
      child: Container(),
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
            onTap: () {
            },
            child: FadeInImage.assetNetwork(
              placeholder: Assets.images.placeholderNew2x1A.path,
              image: '',
              fit: BoxFit.fill,
            ),
          );
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
}
