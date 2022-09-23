import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_recook/constants/api.dart';
import 'package:new_recook/gen/assets.gen.dart';
import 'package:new_recook/models/goods/plus_minus_view.dart';
import 'package:new_recook/models/home/scan_result_model.dart';
import 'package:new_recook/widget/button/text_button.dart';
import 'package:new_recook/widget/recook_back_button.dart';
import 'package:velocity_x/velocity_x.dart';

class QRScarerResultPage extends StatefulWidget {
  final ScanResultModel? model;
  QRScarerResultPage({Key? key, this.model}) : super(key: key);

  @override
  _QRScarerResultPageState createState() => _QRScarerResultPageState();
}

class _QRScarerResultPageState extends State<QRScarerResultPage> {
  int _goodsCount = 1;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("扫码购物",style: TextStyle(fontSize: 36.sp),),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: RecookBackButton(),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 22.w, horizontal: 20.w),
        children: [_goodsCard(widget.model!)],
      ),
      bottomNavigationBar: Row(
        children: [
          _addShopButton().expand(),
          2.widthBox,
          _buyButton().expand()
        ],
      )
          .pSymmetric(h: 32.w)
          .box
          .color(Colors.white)
          .padding(EdgeInsets.only(bottom: ScreenUtil().bottomBarHeight))
          .width(double.infinity)
          .height(128.w)
          .make(),
    );
  }

  Widget _goodsCard(ScanResultModel model) {
    return Column(
      children: [
        Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(4.w),
              child: FadeInImage.assetNetwork(
                placeholder: Assets.images.placeholderNew1x1A.path,
                image: API.getImgUrl(model.brandImg)??"",
                width: 44.w,
                height: 44.w,
                imageErrorBuilder: (context, error, stackTrace) {
                  return Image.asset(Assets.images.placeholderNew1x1A.path,height: 44.w,
                    width: 44.w,);
                },
              ),
            ),
            20.w.widthBox,
            model.brandName!.text
                .size(28.sp)
                .color(Color(0xFF0A0001))
                .bold
                .make(),
          ],
        ),
        26.w.heightBox,
        Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10.w),
              child: FadeInImage.assetNetwork(
                placeholder: Assets.images.placeholderNew1x1A.path,
                image: API.getImgUrl(model.goodsImg)!,
                width: 200.w,
                height: 200.w,
                fit: BoxFit.contain,
                imageErrorBuilder: (context, error, stackTrace) {
                  return Image.asset(Assets.images.placeholderNew1x1A.path,height:200.w,
                    width: 200.w,);
                },
              ),
            ),
            20.w.widthBox,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                model.goodsName!.text
                    .size(28.sp)
                    .bold
                    .lineHeight(1)
                    .color(Color(0xFF141414))
                    .maxLines(2)
                    .overflow(TextOverflow.ellipsis)
                    .make(),
                10.w.heightBox,
                Container(
                  decoration: BoxDecoration(
                      color: Color(0xFFEFF1F6),
                      borderRadius: BorderRadius.circular(4.w)),
                  padding: EdgeInsets.all(10.w),
                  child: '${model.skuName}'
                      .text
                      .color(Color(0xFF666666))
                      .size(20.sp)
                      .make(),
                ),
                30.w.heightBox,
                Row(
                  children: [
                    '¥ '
                        .richText
                        .withTextSpanChildren([
                          '${model.discount!.toStringAsFixed(0)}.'
                              .textSpan
                              .size(36.sp)
                              .color(Color(0xFFC92219))
                              .bold
                              .make(),
                          model.discount!
                              .toStringAsFixed(2)
                              .split('.')[1]
                              .textSpan
                              .color(Color(0xFFC92219))
                              .size(24.sp)
                              .bold
                              .make()
                        ])
                        .color(Color(0xFFC92219))
                        .size(24.sp)
                        .bold
                        .make(),
                    8.w.widthBox,
                    '赚${model.commission!.toStringAsFixed(2)}'
                        .text
                        .color(Color(0xFFC92219))
                        .bold
                        .size(24.sp)
                        .make(),
                    PlusMinusView(
                      onValueChanged: (value) {
                        _goodsCount = value;
                      },
                      initialValue: 1,
                      maxValue: getMaxGoodsCount,
                      onInputComplete: (text) {
                        _goodsCount = int.parse(text);
                      },
                    ).expand()
                  ],
                )
              ],
            ).expand(),
          ],
        )
      ],
    )
        .box
        .padding(EdgeInsets.symmetric(horizontal: 20.w, vertical: 26.w))
        .withRounded(value: 10.w)
        .width(double.infinity)
        .color(Colors.white)
        .make()
        .onInkTap(() {
      // Get.to(() => CommodityDetailPage(
      //       arguments: {"goodsID": widget.model!.goodsID},
      //     ));
    });
  }

  Widget emptyWidget() {
    return Container();
  }

  int? get getMaxGoodsCount {
    if (widget.model?.inventory == null) {
      BotToast.showText(text: '库存数量错误');
      return 0;
    }
    if (widget.model!.inventory == 0) {

      BotToast.showText(text: '库存数量为0');
      return 0;
    }
    return widget.model!.inventory! < 50 ? widget.model!.inventory as int? : 50;
  }

  Widget _buyButton() {
    return
      TextReButton(
        height: 80.w,
        text: "立即购买",
        style: TextStyle(fontSize: 32.sp,color: Colors.white),
        boxDecoration: BoxDecoration(
            gradient: const LinearGradient(
                colors: [Color(0xffc81a3e), Color(0xfffa4968)]),
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(30), bottomRight: Radius.circular(30))),
        onPressed: getMaxGoodsCount == 0
            ? null
            : () {
          _createOrder(widget.model!.skuID, widget.model!.skuName,
              _goodsCount);
        },
      );
  }

  Widget _addShopButton() {
    return
    TextReButton(
      height: 80.w,
      text: "加入购物车",
      style: TextStyle(fontSize: 32.sp,color: Colors.white),
      boxDecoration: BoxDecoration(
          gradient: const LinearGradient(
              colors: [Color(0xff979797), Color(0xff5d5e5d)]),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), bottomLeft: Radius.circular(30))),
      onPressed: getMaxGoodsCount == 0
          ? null
          : () {
        _addToShoppingCart(widget.model!.skuID, widget.model!.skuName,
            _goodsCount, context);
      },
    );
  }

  Future<dynamic> _createOrder(
      int? skuId, String? skuName, int quantity,
      ) async {
    // OrderPreviewModel order = await GoodsDetailModelImpl.createOrderPreview(
    //   UserManager.instance!.user.info!.id,
    //   skuId,
    //   skuName,
    //   quantity,
    //   liveId: isLive ? liveId : null,
    // );
    // if (order.code != HttpStatus.SUCCESS) {
    //   ReToast.err(text: order.msg);
    //   Get.back();
    //   return;
    // }
    // Get.to(()=>GoodsOrderPage(arguments: GoodsOrderPage.setArguments(order)));
  }

  Future<dynamic> _addToShoppingCart(
    int? skuId,
    String? skuName,
    int quantity,
    BuildContext context,
  ) async {
    // ResultData resultData = await ShoppingCartModelImpl().addToShoppingCart(
    //   UserManager.instance!.user.info!.id,
    //   skuId,
    //   skuName,
    //   quantity,
    // );
    // if (!resultData.result) {
    //   ReToast.err(text: resultData.msg);
    //   Get.back();
    //   return;
    // }
    // BaseModel model = BaseModel.fromJson(resultData.data);
    // if (model.code != HttpStatus.SUCCESS) {
    //   Toast.showError(model.msg);
    //   Get.back();
    //   return;
    // }
    // UserManager.instance!.refreshShoppingCart.value = true;
    // UserManager.instance!.refreshShoppingCartNumber.value = true;
    // UserManager.instance!.refreshShoppingCartNumberWithPage.value = true;
    // ReToast.success(text: '加入成功');
    // Get.back();
  }
}
