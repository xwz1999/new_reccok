import 'package:new_recook/constants/api.dart';
import 'package:new_recook/gen/assets.gen.dart';

import '../../models/car/shopping_cart_list_model.dart';
import '../../utils/headers.dart';


typedef GoodsSelectedCallback = Function(ShoppingCartGoodsModel goods);
class ShopCarItem extends StatefulWidget {
  final ShoppingCartBrandModel carModel;
  final GoodsSelectedCallback selectedListener;
  const ShopCarItem({Key? key, required this.carModel, required this.selectedListener,}) : super(key: key);

  @override
  _ShopCarItemState createState() => _ShopCarItemState();
}

class _ShopCarItemState extends State<ShopCarItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 26.w),
      margin: EdgeInsets.symmetric(vertical: 10.w, horizontal: 20.w),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Column(
        children: <Widget>[_brandName(), _buildGoodsList()],
      ),
    );
  }
  _brandName() {
    return Padding(
      padding: EdgeInsets.only(right: 20.w, left: 20.w, bottom: 10.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              widget.carModel.selected = ! widget.carModel.selected!;
              widget.carModel.children!.forEach((goods) {
                // 只有 不是 活动未开始 的商品才能选择
                // isEdit 编辑状态下都可以选择
                // if (!goods.isWaitPromotionStart() || widget.isEdit) {
                if (goods.publishStatus == 1) {
                  goods.selected =  widget.carModel.selected;
                  widget.selectedListener(goods);
                } else {}

                // }
              });
            },
            child: Container(
              height: 32.w,
              width: 32.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.w),
                border: widget.carModel.selected!
                    ? null
                    : Border.all(
                  width: 2.w,
                  color: Color(0xFFC9C9C9),
                ),
                color:
                widget.carModel.selected! ? Color(0xFFDB2D2D) : Colors.transparent,
              ),
              child: Icon(
                Icons.check,
                color: Colors.white,
                size: 24.w,
              ),
            ),
          ),
          12.wb,
          Text(widget.carModel.brandName??'',style: TextStyle(fontSize: 34.sp,fontWeight: FontWeight.w500),)
        ],
      ),
    );
  }

  _buildGoodsList() {
    return ListView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.only(
          left: 0, top: 0, right: 0, bottom: ScreenUtil().bottomBarHeight),
      itemBuilder: (_, index) {
        return GestureDetector(
            onTap: () {},
            child: Padding(
              padding: EdgeInsets.only(bottom: 8.w),
              child: _goodsWidget(widget.carModel.children![index], index),
            ));
      },
      itemCount: widget.carModel.children!.length,
    );
  }



  _goodsWidget(ShoppingCartGoodsModel goodsModel, int index) {
    return Container(
      height: 272.w,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(16.w)),
      child: Row(
        children: [
          GestureDetector(
            onTap: goodsModel.publishStatus == 1
                ? () {
              goodsModel.selected = !goodsModel.selected!;
              bool checkAll = true;
              widget.carModel.children!.forEach((goodsItem) {
                if (!goodsItem.selected!) {
                  checkAll = false;
                  return;
                }
              });
              widget.carModel.selected = checkAll;
              widget.selectedListener(goodsModel);
              setState(() {});
            }
                : () {},
            child: Container(
              height: 32.w,
              width: 32.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.w),
                border: goodsModel.publishStatus == 1&&goodsModel.selected!
                    ? null
                    : Border.all(
                  width: 2.w,
                  color: Color(0xFFC9C9C9),
                ),
                color:
                goodsModel.publishStatus == 1&&goodsModel.selected! ? Color(0xFFDB2D2D) : Colors.transparent,
              ),
              child: Icon(
                Icons.check,
                color: Colors.white,
                size: 24.w,
              ),
            ),
          ),
          _image(goodsModel),
          Expanded(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  16.hb,
                  Padding(
                    padding: EdgeInsets.only(left: 16.w),
                    child: SizedBox(
                      child: Text(
                        goodsModel.goodsName ?? '',
                        style: TextStyle(
                            fontSize: 32.sp,
                            color: Color(0xFF333333),
                            fontWeight: FontWeight.bold),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  16.hb,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      24.wb,
                      Text.rich(
                        TextSpan(
                          text: '¥',
                          style: TextStyle(
                            color: Color(0xFFC92219),
                            fontSize: 32.sp,
                          ),
                          children: [
                            TextSpan(
                              text: goodsModel.price.toString(),
                              style: TextStyle(
                                color: Color(0xFFC92219),
                                fontSize: 48.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  Row(
                    children: [
                      16.wb,
                      Container(
                          alignment: Alignment.center,
                          width: 104.w,
                          height: 40.w,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Color(0xFFAAAAAA), width: 2.w),
                              borderRadius:
                              BorderRadius.all(Radius.circular(20.w))),
                          child: Text(
                            '找相似',
                            style: TextStyle(
                              color: Color(0xFF666666),
                              fontSize: 24.sp,
                            ),
                          )),
                      Spacer(),
                    ],
                  ),
                  20.hb,
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  _image(ShoppingCartGoodsModel goodsModel) {
    bool sellout = false;
    if (goodsModel.publishStatus! == 1) {
      sellout = false;
    } else {
      sellout = true;
    }
    return Container(
      width: 250.w,
      height: 250.w,
      color: Colors.white,
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(16.w)),
        child: Stack(
          children: [
            Positioned(
                top: 0,
                right: 0,
                left: 0,
                bottom: 0,
                child: FadeInImage.assetNetwork(
                  placeholder: Assets.images.placeholderNew1x1A.path,
                  image: API.getImgUrl(goodsModel.mainPhotoUrl) ?? '',
                  fit: BoxFit.cover,
                  imageErrorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      Assets.images.placeholderNew1x1A.path,
                      fit: BoxFit.fill,
                    );
                  },
                )),
            Positioned(
              top: 0,
              right: 0,
              left: 0,
              bottom: 0,
              child: Offstage(
                offstage: !sellout,
                child: Opacity(
                  opacity: 0.7,
                  child: Container(
                    color: Color(0x80000000),
                    child: Center(
                      child: Image.asset(
                        Assets.images.selloutBg.path,
                        width: 140.w,
                        height: 140.w,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
