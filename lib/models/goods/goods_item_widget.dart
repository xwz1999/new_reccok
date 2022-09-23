import 'package:new_recook/constants/api.dart';
import 'package:new_recook/gen/assets.gen.dart';
import 'package:new_recook/models/goods/goods_model.dart';
import 'package:new_recook/utils/headers.dart';

class GoodsItemWidget extends StatelessWidget {
  final GoodsModel goodsModel;

  const GoodsItemWidget({Key? key, required this.goodsModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 272.w,

      padding: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(16.w)),
      child: Row(
        children: [
          _image(),
          Expanded(
            child: Container(
              child: Column(
                children: [
                  16.hb,
                  SizedBox(
                    child: Text(
                      goodsModel.goodsName ?? '',
                      style: TextStyle(fontSize: 32.sp, color: Color(0xFF333333),fontWeight: FontWeight.bold),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    width: 400.w,
                  ),
                  16.hb,
                  SizedBox(
                    child: Text(
                      goodsModel.shopName ?? '',
                      style: TextStyle(fontSize: 24.sp, color: Color(0xFFDB2D2D)),
                      maxLines: 1,

                      overflow: TextOverflow.ellipsis,
                    ),
                    width: 400.w,
                  ),
                  Spacer(),
                  Row(
                    children: [
                      16.wb,
                      Text.rich(
                        TextSpan(
                          text: '¥',
                          style: TextStyle(
                            color: Color(0xFFC92219),
                            fontSize: 32.sp,
                          ),
                          children: [
                            TextSpan(
                              text: goodsModel.price,
                              style: TextStyle(
                                color: Color(0xFFC92219),
                                fontSize: 48.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Spacer(),
                      Text(
                        '已售${goodsModel.inventory}件',
                        style: TextStyle(
                          color: Color(0xFF666666),
                          fontSize: 24.sp,
                        ),
                      )
                    ],
                  ),
                  30.hb,
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  _image() {
    bool sellout = false;
    if (goodsModel.inventory! > 0) {
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
                  image: API.getImgUrl(goodsModel.imgPath) ?? '',
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
