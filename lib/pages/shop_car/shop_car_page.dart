import 'package:new_recook/constants/api.dart';
import 'package:new_recook/gen/assets.gen.dart';
import 'package:new_recook/utils/headers.dart';
import 'package:new_recook/widget/OverlayWidget.dart';
import 'package:new_recook/widget/button/img_button.dart';
import 'package:new_recook/widget/recook_scaffold.dart';
import 'package:new_recook/widget/refresh_widget.dart';

class ShopCarPage extends StatefulWidget {
  const ShopCarPage({Key? key}) : super(key: key);

  @override
  _ShopCarPageState createState() => _ShopCarPageState();
}

class _ShopCarPageState extends State<ShopCarPage> {
  GSRefreshController? _refreshController =  GSRefreshController(initialRefresh: true);


  @override
  Widget build(BuildContext context) {
    return RecookScaffold(
      bodyColor: Color(0xFFF6F6F6),
      body: Stack(
        children: [
          Container(
            child: RefreshWidget(
              controller: _refreshController,
              onRefresh: (){

              },
              body: ListView(
                physics: AlwaysScrollableScrollPhysics(),
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 120.w, height: 120.w,
                        child: ClipOval(
                          child: FadeInImage.assetNetwork(
                            placeholder: Assets.images.placeholderNew1x1A.path,
                            image:  API.getImgUrl('')??'',
                            imageErrorBuilder: (context, obj, stackTrace) {
                              return Image.asset(
                                Assets.images.placeholderNew1x1A.path,
                                width: 128.w,
                                height:  128.w,
                                fit: BoxFit.cover,
                              );
                            },
                            width: 128.w,
                            height:  128.w,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      20.wb,
                      Text('11111',style: TextStyle(fontSize: 32.sp,color: Color(0xFF111111),fontWeight: FontWeight.bold),),
                      Spacer(),
                      ImgButton(path: Assets.icons.iconSetting.path,width: 44.w,height: 44.w,onPressed: (){

                      },),
                      20.wb,
                    ],
                  ),
                  30.hb,
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.w)
                    ),
                    height: 220.w,
                  )
                ],
              ),
            ),
          ),
          OverlayLivingBtnWidget(index: 2,),
        ],
      ),
    );
  }
}
