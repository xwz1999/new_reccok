import 'dart:async';
import 'dart:io';
import 'package:bot_toast/bot_toast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:new_recook/constants/styles.dart';
import 'package:new_recook/pages/shop/scan/barcodeScan.dart';
import 'package:new_recook/pages/shop/scan/qr_scaner_result_page.dart';
import 'package:new_recook/utils/headers.dart';
import 'package:new_recook/utils/image_utils.dart';
import 'package:new_recook/utils/text_utils.dart';
import 'package:new_recook/widget/button/text_button.dart';
import 'package:new_recook/widget/recook_back_button.dart';


class PhotosFailBarcodePage extends StatefulWidget {
  final String? code;
  final String? message;
  final File? image;

  const PhotosFailBarcodePage({Key? key, this.code, this.message, this.image,}) : super(key: key);

  // static setArguments(String? code, String? message, File image) {
  //   return {
  //     "code": code,
  //     "message": message,
  //     "image": image,
  //   };
  // }

  @override
  State<StatefulWidget> createState() {
    return _PhotosFailBarcodePageState();
  }
}

class _PhotosFailBarcodePageState
    extends State<PhotosFailBarcodePage> {
  String? _code;
  String? _message;
  File? _image;

  final picker  = ImagePicker();
  @override
  void initState() {
    super.initState();

      _code = widget.code;
      _message = widget.message;
      _image = widget.image;

  }

  @override
  Widget build(BuildContext context, {store}) {
    return Scaffold(
      appBar: AppBar(
        title: Text("识别失败",style: TextStyle(fontSize: 36.sp),),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: RecookBackButton(),
      ),
      body: SingleChildScrollView(
        child: _bodyWidget(),
      ),
    );
  }

  _bodyWidget() {
    double width = MediaQuery.of(context).size.width;
    Color buttonColor = Color(0xffE98787);
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 300.w,
            width: MediaQuery.of(context).size.width,
            child: Image.file(
              _image!,
              fit: BoxFit.contain,
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            width: width,
            padding: EdgeInsets.only(left: 60.w, top: 40.w),
            child: Text(
              _message == null ? "商品未录入" : _message!,
              style: TextStyle(color: Colors.black, fontSize: 44.sp),
            ),
          ),
          _codeWidget(),
          Container(
            padding: EdgeInsets.only(
              left: 60.w,
              right: 60.w,
              top: 200.w,
            ),
            child:
            TextReButton(
              height: 72.w,
              text: "重新上传",
              style: TextStyle(fontSize: 32.sp,color: Colors.white),
              boxDecoration: BoxDecoration(
                border:  Border.all(
                  color: buttonColor,
                ),
                color: AppColor.themeColor,
              ),
              onPressed: ()async{
                var image = await (picker.getImage(source: ImageSource.gallery));
                File? cropFile = await ImageUtils.cropImage(File(image!.path));
                if (cropFile == null) {
                  return;
                }
              },
            )

          ),
          Container(
            padding: EdgeInsets.only(
              left: 60.w,
              right: 60.w,
              top: 40.w,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child:
            TextReButton(
              height: 72.w,
              text: "切换扫描",
              style: TextStyle(fontSize: 32.sp,color: Colors.white),
              boxDecoration: BoxDecoration(
                border:  Border.all(
                  color: buttonColor,
                ),
              ),
              onPressed: (){
                Get.off(()=>BarcodeScanPage());
              },
            )

                ),
                Container(
                  width: 30,
                ),
                Expanded(
                  child:
                  TextReButton(
                    height: 72.w,
                    text: "返回首页",
                    style: TextStyle(fontSize: 32.sp,color: Colors.white),
                    boxDecoration: BoxDecoration(
                      border:  Border.all(
                        color: buttonColor,
                      ),
                    ),
                    onPressed: (){
                      Navigator.pop(context);
                    },
                  )
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  _codeWidget() {
    return Container(
        padding: EdgeInsets.only(left: 30, right: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 0),
                  // height: 60,
                  alignment: Alignment.center,
                  child: Text(
                    "扫码结果",
                    style: TextStyle(color: Colors.black, fontSize: 16 * 2.sp),
                  ),
                ),
                Container(
                  width: 15,
                ),
                Expanded(
                  child: Container(
                    height: 60,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      _code!,
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.5),
                          fontSize: 15 * 2.sp),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              height: 1,
              color: AppColor.frenchColor,
            )
          ],
        ));
  }

  Future onScan(String data, {File? image}) async {
    if (!TextUtils.isEmpty(data)) {
      _getGoodsWithCode(data, (goodsId) {
        Get.to(() => QRScarerResultPage());
        // AppRouter.pushAndReplaced(globalContext, RouteName.COMMODITY_PAGE, arguments: CommodityDetailPage.setArguments(int.parse(goodsId)));
        return;
      }, image: image);
    } else {
      BotToast.showText(text: '图片识别失败...');
    }
  }

  _getGoodsWithCode(String code, Function callBack, {File? image}) async {
    // ResultData resultData = await HttpManager.post(GoodsApi.goods_code_search, {
    //   "code": code,
    // });
    // if (!resultData.result) {
    //   _refreshState(code, resultData.msg, image);
    //   // pushToFailPage(code, resultData.msg, image);
    //   return;
    // }
    // BaseModel model = BaseModel.fromJson(resultData.data);
    // if (model.code != HttpStatus.SUCCESS) {
    //   _refreshState(code, model.msg, image);
    //   // pushToFailPage(code, model.msg, image);
    //   return;
    // }
    // String goodsId = resultData.data['data']['goodsId'].toString();
    // if (TextUtils.isEmpty(goodsId)) {
    //   return;
    // }
    // callBack(goodsId);
    // return;
  }

  _refreshState(code, message, image) {
    _code = code;
    _message = message;
    _image = image;
    setState(() {});
  }
}
