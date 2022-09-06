
import 'package:new_recook/constants/styles.dart';
import 'package:new_recook/pages/shop/scan/barcodeScan.dart';
import 'package:new_recook/widget/button/text_button.dart';
import 'package:new_recook/widget/recook_back_button.dart';

import '../../../utils/headers.dart';

class FailBarcodePage extends StatefulWidget {
  final String? code;
  final String? message;
  const FailBarcodePage({Key? key, this.code, this.message,}) : super(key: key);


  @override
  State<StatefulWidget> createState() {
    return _FailBarcodePageState();
  }
}

class _FailBarcodePageState extends State<FailBarcodePage> {
  String? code;
  String? message;
  @override
  void initState() {
    super.initState();

      code = widget.code;
      message = widget.message;

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
      body: _bodyWidget(),
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
              message == null ? "商品未录入" : message!,
              style: TextStyle(color: Colors.black, fontSize: 22 * 2.sp),
            ),
          ),
          _codeWidget(),
          Container(
            padding: EdgeInsets.only(
              left: 30,
              right: 30,
              top: 100,
            ),
            child:
            TextReButton(
              height: 72.w,
              text: "重新扫描",
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
            padding: EdgeInsets.only(
              left: 30,
              right: 30,
              top: 20,
            ),
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
                      code!,
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
}
