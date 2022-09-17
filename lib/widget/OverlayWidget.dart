import 'package:new_recook/pages/shop/shop_home_page.dart';
import 'package:new_recook/pages/shop_car/shop_car_page.dart';
import 'package:new_recook/pages/user/user_home_page.dart';
import 'package:new_recook/utils/headers.dart';

import '../gen/assets.gen.dart';

class OverlayLivingBtnWidget extends StatefulWidget {
  final int index;

  OverlayLivingBtnWidget({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  _OverlayLivingBtnWidgetState createState() => _OverlayLivingBtnWidgetState();
}

class _OverlayLivingBtnWidgetState extends State<OverlayLivingBtnWidget>
    with TickerProviderStateMixin {
  double _topPos = 0;
  double _leftPos = 0;
  bool _isMoving = false;
  double _width = 50;

  double get _subWidth => _width / 2;
  double _height = 115;

  double get _subHeight => _height / 2;
  bool _isHide = false;
  int index = 1;

  ///1为首页，2为购物车，3为我的

  @override
  void initState() {
    super.initState();
    _topPos = ScreenUtil().screenHeight - 20 - _height - 100;
    _leftPos = _leftPos = 20.w;
    index = widget.index;

    print("_topPos");
    print(_topPos);
    print("_leftPos");
    print(_leftPos);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      left: _isHide ? -_width : _leftPos,
      top: _topPos,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.transparent, width: 2.w),
        ),
        child: Stack(
          children: [
            GestureDetector(
              onTap: () {},
              onPanUpdate: (detail) {
                setState(() {
                  _topPos = detail.globalPosition.dy - _subHeight;
                  _leftPos = detail.globalPosition.dx - _subWidth;
                });
              },
              onPanStart: (detail) {
                setState(() {
                  _isMoving = true;
                });
              },
              onPanEnd: (detail) {
                _isMoving = false;
                if (_leftPos < 20) _leftPos = 20;
                if (_topPos < ScreenUtil().statusBarHeight + 20)
                  _topPos = (20 + ScreenUtil().statusBarHeight);
                if ((_leftPos + _width + 20) > ScreenUtil().screenWidth)
                  _leftPos = ScreenUtil().screenWidth - 20 - _width;
                if ((_topPos + _height + 55 + 20) > ScreenUtil().screenHeight)
                  _topPos = ScreenUtil().screenHeight - 20 - _height - 55;
                setState(() {});
              },
              child: Container(
                width: 80.w,
                // /height: 212.w,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xFFDBDBDB),
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                    borderRadius: BorderRadius.all(Radius.circular(14.w)),
                    color: Color(0xB3000000)),
                child: Column(
                  children: [
                    16.hb,
                    GestureDetector(
                      onTap: () {
                        if (index == 1) {
                          Get.off(() => ShopCarPage());
                        } else {
                          Get.off(() => ShopHomePage());
                        }
                      },
                      child: Container(
                        color: Colors.transparent,
                        child: Column(
                          children: [
                            Image.asset(
                              index == 1
                                  ? Assets.icons.tabCar.path
                                  : Assets.icons.tabHome.path,
                              width: 45.w,
                              height: 45.w,
                            ),
                            8.hb,
                            Text(
                              index == 1 ? '购物车' : '商城',
                              style: TextStyle(
                                  fontSize: 20.sp, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Divider(
                      thickness: 1.w,
                      color: Colors.white,
                    ),
                    GestureDetector(
                      onTap: () {
                        if (index == 3) {
                          Get.off(() => ShopCarPage());
                        } else {
                          Get.off(() => UserHomePage());
                        }
                      },
                      child: Container(
                        color: Colors.transparent,
                        child: Column(
                          children: [
                            Image.asset(
                              index == 3
                                  ? Assets.icons.tabCar.path
                                  : Assets.icons.tabMy.path,
                              width: 45.w,
                              height: 45.w,
                            ),
                            8.hb,
                            Text(
                              index == 3 ? '购物车' : '我的',
                              style: TextStyle(
                                  fontSize: 20.sp, color: Colors.white),
                            ),
                            16.hb,
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Positioned(
            //   left: 0,
            //   right: 0,
            //   top: 0,
            //   bottom: 0,
            //   child: Container(
            //     width: 80.w,
            //     // /height: 212.w,
            //     decoration: BoxDecoration(
            //         boxShadow: [
            //           BoxShadow(
            //             color: Color(0xFFDBDBDB),
            //             blurRadius: 4,
            //             offset: Offset(0, 2),
            //           ),
            //         ],
            //         borderRadius: BorderRadius.all(Radius.circular(14.w)),
            //         color: Color(0xB3000000)),
            //     child: Column(
            //       children: [
            //         16.hb,
            //
            //         GestureDetector(
            //           onTap: (){
            //             print('shangmian');
            //             Get.to(()=>index==1?ShopCarPage():ShopHomePage());
            //           },
            //           child: Container(
            //             color: Colors.transparent,
            //             child: Column(
            //               children: [
            //                 Image.asset(index==1?Assets.icons.tabCar.path: Assets.icons.tabHome.path,width: 45.w,height: 45.w,),
            //                 8.hb,
            //                 Text(
            //                   index==1?'购物车':
            //                   '商城',
            //                   style: TextStyle(
            //                       fontSize: 20.sp, color: Colors.white),
            //                 ),
            //               ],
            //             ),
            //           ),
            //         ),
            //
            //
            //         Divider(thickness: 1.w,color: Colors.white,),
            //
            //         GestureDetector(
            //           onTap: (){
            //             print('xiamian');
            //             Get.to(()=>index==3?ShopCarPage():UserHomePage());
            //           },
            //           child: Container(
            //             color: Colors.transparent,
            //             child: Column(
            //               children: [
            //                 Image.asset( index==3?Assets.icons.tabCar.path:Assets.icons.tabMy.path,width: 45.w,height: 45.w,),
            //                 8.hb,
            //                 Text(
            //                   index==3?'购物车':
            //                   '我的',
            //                   style: TextStyle(
            //                       fontSize: 20.sp, color: Colors.white),
            //                 ),
            //               ],
            //             ),
            //           ),
            //         ),
            //
            //
            //       ],
            //     ),
            //
            //   ),
            //
            // ),
          ],
        ),
      ),
      curve: Curves.easeInOutCubic,
      duration: _isMoving ? Duration.zero : Duration(milliseconds: 300),
    );
  }
}
