import 'package:flutter/cupertino.dart';
import 'package:new_recook/constants/api.dart';
import 'package:new_recook/gen/assets.gen.dart';
import 'package:new_recook/models/car/shopping_cart_list_model.dart';
import 'package:new_recook/pages/shop_car/shop_car_item.dart';
import 'package:new_recook/utils/headers.dart';
import 'package:new_recook/widget/OverlayWidget.dart';
import 'package:new_recook/widget/button/img_button.dart';
import 'package:new_recook/widget/button/recook_check_box.dart';
import 'package:new_recook/widget/no_data_widget.dart';
import 'package:new_recook/widget/recook_scaffold.dart';
import 'package:new_recook/widget/refresh_widget.dart';

class ShopCarPage extends StatefulWidget {
  const ShopCarPage({Key? key}) : super(key: key);

  @override
  _ShopCarPageState createState() => _ShopCarPageState();
}

class _ShopCarPageState extends State<ShopCarPage> {
  GSRefreshController _refreshController =
      GSRefreshController(initialRefresh: true);
  int _totalNum = 0;
  bool _checkAll = false;
  List<ShoppingCartBrandModel> _shopCarGoods = [
    ShoppingCartBrandModel(
      1,1,'','',[
      ShoppingCartGoodsModel(1,1,'牛奶','','500ml',1,10,20,false,1),
      ShoppingCartGoodsModel(1,1,'牛奶','','500ml',1,10,20,false,1),
      ShoppingCartGoodsModel(1,1,'牛奶','','500ml',1,10,20,false,1),
    ],false
    ),
  ];
  List<ShoppingCartGoodsModel> _selectedGoods = [];
  bool _manageStatus = false;
  late StateSetter _bottomStateSetter;


  @override
  Widget build(BuildContext context) {
    return RecookScaffold(
      bgColor: Color(0xFFF6F6F6),
      bodyColor: Color(0xFFF6F6F6),
      titleSpacing: 0,
      leadingWidth: 30.w,
      title:  Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "购物车",
              style: TextStyle(
                color: Color(0xFF111111),
                fontSize: 40.sp,
              ),
            ),
            Text(
              " ($_totalNum)",
              style: TextStyle(
                color: Color(0xFF111111),
                fontSize: 30.sp,
              ),
            ),
          ],
        ),

      actions: [
        Center(
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
              for (ShoppingCartBrandModel _brandModel in _shopCarGoods) {
                _brandModel.selected = false;
                for (ShoppingCartGoodsModel _goodsModel
                    in _brandModel.children!) {
                  _goodsModel.selected = false;
                }
              }
              _checkAll = false;
              _selectedGoods.clear();
              _manageStatus = !_manageStatus;
              setState(() {});
            },
            child: Container(
              color: Colors.transparent,
              padding: EdgeInsets.only(right: 30.w, top: 20.w,left: 30.w,bottom: 20.w),
              child: Text(
                !_manageStatus ? "管理" : "完成",
                style: TextStyle(color: Color(0xFF666666), fontSize: 28.sp),
              ),
            ),
          ),
        )
      ],
      body: Stack(
        children: [
          Container(
            child: RefreshWidget(
              controller: _refreshController,
              onRefresh: () {
                _refreshController.refreshCompleted();
              },
              body: _shopCarGoods.isNotEmpty? ListView.builder(
                itemBuilder: (context, index) {
                  return ShopCarItem(carModel: _shopCarGoods[index], selectedListener: (ShoppingCartGoodsModel goods) {  },);
                },
                itemCount: _shopCarGoods.length,
              ):NoDataWidget(text: '购物车是空的，快去逛逛吧～'),
            ),
          ),
          OverlayLivingBtnWidget(
            index: 2,
            top: 180,
          ),
        ],
      ),
      bottomNavi: _bottomWidget(),
    );
  }

  _bottomWidget() {
    return StatefulBuilder(
      builder: (BuildContext context, StateSetter bottomSetState) {
        double totalPrice = 0;
        _selectedGoods.forEach((goods) {
          totalPrice += (goods.price! ) * goods.quantity!;
        });
        _bottomStateSetter = bottomSetState;
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 40.w),
          color: Colors.white,
          height: 120.w,
          child: Row(
            children: [
              CupertinoButton(
                minSize: 0,
                padding: EdgeInsets.zero,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 10.w),
                      child: RecookCheckBox(state: _checkAll),
                    ),
                    16.wb,
                    Text(
                      '全选',
                      style: TextStyle(
                        color: Color(0xFF333333),
                        fontSize: 14 * 2.sp,
                      ),
                    ),
                  ],
                ),
                onPressed: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                  _checkAll = !_checkAll;
                  _bottomStateSetter(() {});
                },
              ),
              Spacer(),

              _manageStatus?RichText(
                  text: TextSpan(
                      text: "合计：",
                      style: TextStyle(fontSize: 28.sp, color: Colors.black),
                      children: [
                    TextSpan(
                        text: "¥ ",
                        style: TextStyle(
                            fontSize: 26.sp,
                            color: Color(0xffc70404),
                            fontWeight: FontWeight.bold)),
                    TextSpan(
                        text: "${totalPrice.toStringAsFixed(2)}",
                        style: TextStyle(
                            fontSize: 44.sp,
                            color: Color(0xffc70404),
                            fontWeight: FontWeight.bold))
                  ])):SizedBox(),
              _manageStatus?GestureDetector(
                onTap: () {},
                child: Container(
                  margin: EdgeInsets.only(left: 20.w),
                  alignment: Alignment.center,
                  width: 210.w,
                  height: 80.w,
                  padding:
                      EdgeInsets.symmetric(vertical: 15.w, horizontal: 20.w),
                  decoration: BoxDecoration(
                      color: Color(0xffd5101a),
                      borderRadius: BorderRadius.circular(40.w)),
                  child: Text(
                    '删除',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ):GestureDetector(
                onTap: () {},
                child: Container(
                  alignment: Alignment.center,
                  width: 210.w,
                  height: 80.w,
                  padding:
                  EdgeInsets.symmetric(vertical: 15.w, horizontal: 20.w),
                  decoration: BoxDecoration(
                      color: Color(0xffd5101a),
                      borderRadius: BorderRadius.circular(40.w)),
                  child: Text(
                    "结算(${_selectedGoods.length})",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
