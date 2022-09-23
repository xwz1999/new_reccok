import 'package:new_recook/constants/api.dart';
import 'package:new_recook/gen/assets.gen.dart';
import 'package:new_recook/pages/user/invoice/invoicing_page.dart';
import 'package:new_recook/pages/user/login_page.dart';
import 'package:new_recook/pages/user/my_address_page.dart';
import 'package:new_recook/pages/user/my_collection_page.dart';
import 'package:new_recook/pages/user/setting_page.dart';
import 'package:new_recook/pages/user/user_info_page.dart';
import 'package:new_recook/utils/headers.dart';
import 'package:new_recook/widget/OverlayWidget.dart';
import 'package:new_recook/widget/button/img_button.dart';
import 'package:new_recook/widget/recook_scaffold.dart';
import 'package:new_recook/widget/refresh_widget.dart';

import 'my_footprint_page.dart';

class UserHomePage extends StatefulWidget {
  const UserHomePage({Key? key}) : super(key: key);

  @override
  _UserHomePageState createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  bool haveLogin = true;
  GSRefreshController? _refreshController =
      GSRefreshController(initialRefresh: true);

  @override
  Widget build(BuildContext context) {
    return RecookScaffold(
      bodyColor: Color(0xFFF6F6F6),
      body: haveLogin
          ? Stack(
              children: [
                Container(
                  child: RefreshWidget(
                    controller: _refreshController,
                    onRefresh: () {
                      _refreshController!.refreshCompleted();
                    },
                    body: ListView(
                      physics: AlwaysScrollableScrollPhysics(),
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      children: [
                        SizedBox(
                          height: kToolbarHeight,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            GestureDetector(
                              child: SizedBox(
                                width: 100.w,
                                height: 100.w,
                                child: ClipOval(
                                  child: FadeInImage.assetNetwork(
                                    placeholder:
                                        Assets.images.placeholderNew1x1A.path,
                                    image: API.getImgUrl('') ?? '',
                                    imageErrorBuilder:
                                        (context, obj, stackTrace) {
                                      return Image.asset(
                                        Assets.images.placeholderNew1x1A.path,
                                        width: 100.w,
                                        height: 100.w,
                                        fit: BoxFit.cover,
                                      );
                                    },
                                    width: 100.w,
                                    height: 100.w,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              onTap: () {
                                Get.to(() => UserInfoPage());
                              },
                            ),
                            20.wb,
                            Text(
                              '瑞库客',
                              style: TextStyle(
                                  fontSize: 32.sp,
                                  color: Color(0xFF111111),
                                  fontWeight: FontWeight.bold),
                            ),
                            Spacer(),
                            ImgButton(
                              path: Assets.icons.iconSetting.path,
                              width: 44.w,
                              height: 44.w,
                              onPressed: () {
                                Get.to(() => SettingPage());
                              },
                            ),
                          ],
                        ),
                        40.hb,
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 12.w),
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16.w),
                              color: Colors.white),
                          height: 260.w,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                  left: 24.w,
                                  top: 24.w,
                                ),
                                child: Text(
                                  '订单中心',
                                  style: TextStyle(
                                      fontSize: 32.sp,
                                      color: Color(0xFF000000),
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              30.hb,
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        ImgButton(
                                          path: Assets.home.icOrder.path,
                                          width: 80.w,
                                          height: 80.w,
                                        ),
                                        10.hb,
                                        Text(
                                          '全部订单',
                                          style: TextStyle(
                                              fontSize: 24.sp,
                                              color: Color(0xFF333333)),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        ImgButton(
                                          path: Assets.home.icPay.path,
                                          width: 70.w,
                                          height: 70.w,
                                        ),
                                        20.hb,
                                        Text(
                                          '待付款',
                                          style: TextStyle(
                                              fontSize: 24.sp,
                                              color: Color(0xFF333333)),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        ImgButton(
                                          path: Assets.home.icLogistics.path,
                                          width: 70.w,
                                          height: 70.w,
                                        ),
                                        20.hb,
                                        Text(
                                          '待发货',
                                          style: TextStyle(
                                              fontSize: 24.sp,
                                              color: Color(0xFF333333)),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        ImgButton(
                                          path: Assets.home.icDeliver.path,
                                          width: 70.w,
                                          height: 70.w,
                                        ),
                                        20.hb,
                                        Text(
                                          '待收货',
                                          style: TextStyle(
                                              fontSize: 24.sp,
                                              color: Color(0xFF333333)),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        20.hb,
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 12.w),
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16.w),
                              color: Colors.white),
                          height: 260.w,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                  left: 24.w,
                                  top: 24.w,
                                ),
                                child: Text(
                                  '我的服务',
                                  style: TextStyle(
                                      fontSize: 32.sp,
                                      color: Color(0xFF000000),
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              30.hb,
                              Row(
                                children: [
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: (){
                                        Get.to(()=>MyCollectionPage());
                                      },
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          ImgButton(
                                            path: Assets.home.icFavor.path,
                                            width: 65.w,
                                            height: 65.w,
                                          ),
                                          15.hb,
                                          Text(
                                            '我的收藏',
                                            style: TextStyle(
                                                fontSize: 24.sp,
                                                color: Color(0xFF333333)),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: (){
                                        Get.to(()=>MyFootprintPage());
                                      },
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          ImgButton(
                                            path: Assets.home.icFootprint.path,
                                            width: 70.w,
                                            height: 70.w,
                                          ),
                                          15.hb,
                                          Text(
                                            '我的足迹',
                                            style: TextStyle(
                                                fontSize: 24.sp,
                                                color: Color(0xFF333333)),
                                          ),
                                          5.hb,
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: (){
                                        Get.to(()=>MyAddressPage());
                                      },
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          ImgButton(
                                            path: Assets.home.icLocation.path,
                                            width: 65.w,
                                            height: 65.w,
                                          ),
                                          15.hb,
                                          Text(
                                            '我的地址',
                                            style: TextStyle(
                                                fontSize: 24.sp,
                                                color: Color(0xFF333333)),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: (){
                                        Get.to(()=>InvoicingPage());
                                      },
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          ImgButton(
                                            path: Assets.home.icInvoice.path,
                                            width: 65.w,
                                            height: 65.w,
                                          ),
                                          15.hb,
                                          Text(
                                            '发票助手',
                                            style: TextStyle(
                                                fontSize: 24.sp,
                                                color: Color(0xFF333333)),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                OverlayLivingBtnWidget(
                  index: 3,
                ),
              ],
            )
          : Stack(
              children: [
                Container(
                  child: ListView(
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(top: 240.w),
                            width: 140.w,
                            height: 140.w,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: AspectRatio(
                                aspectRatio: 1.0 / 1.0,
                                child: Image.asset(Assets.icons.appIcon.path,
                                    fit: BoxFit.fill),
                              ),
                            ),
                          ),
                          Container(
                            height: 300.w,
                          ),
                          GestureDetector(
                            onTap: (){
                              Get.to(()=>LoginPage());
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 120.w, vertical: 15.w),
                              decoration: BoxDecoration(
                                color: Color(0xFFDB1E1E),
                                borderRadius: BorderRadius.circular(20.w),
                                gradient: LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  colors: <Color>[
                                    Color(0xFFE05346),
                                    Color(0xFFDB1E1E)
                                  ],
                                ),
                              ),
                              child: Text(
                                '登 录',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 32.sp),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                OverlayLivingBtnWidget(
                  index: 3,
                ),
              ],
            ),
    );
  }
}
