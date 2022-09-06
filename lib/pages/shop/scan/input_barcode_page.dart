import 'package:flutter/cupertino.dart';
import 'package:new_recook/constants/styles.dart';
import 'package:new_recook/pages/shop/scan/barcodeScan.dart';
import 'package:new_recook/utils/headers.dart';
import 'package:new_recook/utils/text_utils.dart';
import 'package:new_recook/widget/button/text_button.dart';
import 'package:new_recook/widget/recook_back_button.dart';

class InputBarcodePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _InputBarcodePageState();
  }
}

class _InputBarcodePageState extends State<InputBarcodePage> {
  final _textEditcontroller = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context, {store}) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
          appBar: AppBar(
            leading: RecookBackButton(),
            backgroundColor: Colors.white,
            elevation: 0,
          ),
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: _bodyWidget(),
          )),
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
            alignment: Alignment.centerLeft,
            width: width,
            padding: EdgeInsets.only(left: 30, top: 20),
            child: Text(
              "填写商品条码",
              style: TextStyle(color: Colors.black, fontSize: 44.sp),
            ),
          ),
          inputWidget(),
          Container(
            padding: EdgeInsets.only(
              left: 30,
              right: 30,
              top: 30,
            ),
            child: TextReButton(
              height: 72.w,
              text: "确认",
              style: TextStyle(fontSize: 32.sp,color: Colors.white),
              onPressed: TextUtils.isEmpty(_textEditcontroller.text)
                    ? null
                    : () {
                        _getGoodsWithCode(_textEditcontroller.text);
                      },
            )
          ),
          Container(
            padding: EdgeInsets.only(
              left: 30,
              right: 30,
              top: 20,
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

  Widget inputWidget() {
    return Container(
      padding: EdgeInsets.only(left: 30, right: 30),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                // height: 60,
                alignment: Alignment.center,
                child: Text(
                  "商品条码",
                  style: TextStyle(color: Colors.black, fontSize: 16 * 2.sp),
                ),
              ),
              Container(
                width: 15,
              ),
              Expanded(
                  child: Container(
                height: 60,
                alignment: Alignment.center,
                child: CupertinoTextField(
                  onChanged: (string) {
                    setState(() {});
                  },
                  controller: _textEditcontroller,
                  placeholder: "请输入条码",
                  decoration: BoxDecoration(),
                  maxLength: 13,
                  maxLines: 1,
                  style: TextStyle(fontSize: 15 * 2.sp, color: Colors.black),
                  textAlign: TextAlign.left,
                ),
              )),
            ],
          ),
          Container(
            height: 1,
            color: AppColor.frenchColor,
          )
        ],
      ),
    );
  }

  _getGoodsWithCode(String code) async {
    // ResultData resultData =
    //     await HttpManager.post(APIV2.userAPI.getScanResult, {
    //   "skuCode": code,
    // });
    // if (!resultData.result) {
    //   showError(resultData.msg??'');
    //   return;
    // }
    // BaseModel model = BaseModel.fromJson(resultData.data);
    // if (model.code != HttpStatus.SUCCESS) {
    //   showError(model.msg??'');
    //   return;
    // }
    // // String goodsId = resultData.data['data']['goodsId'].toString();
    // // if (TextUtils.isEmpty(goodsId)) {
    // //   return;
    // // }
    // // AppRouter.pushAndReplaced(globalContext, RouteName.COMMODITY_PAGE, arguments: CommodityDetailPage.setArguments(int.parse(goodsId)));
    // ScanResultModel scanResultModel =
    //     ScanResultModel.fromMap(resultData.data['data']);
    // if (scanResultModel == null) {
    //   showError(model.msg??'');
    //   return;
    // }
    // Get.off(
    //   () => QRScarerResultPage(
    //     model: scanResultModel,
    //   ),
    // );
    // return;
  }
}
