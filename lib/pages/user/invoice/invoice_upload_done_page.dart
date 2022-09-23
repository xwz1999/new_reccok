import 'package:new_recook/constants/styles.dart';
import 'package:new_recook/pages/user/invoice/invoice_history_page.dart';
import 'package:new_recook/utils/headers.dart';
import 'package:new_recook/widget/recook_scaffold.dart';


class InvoiceUploadDonePage extends StatefulWidget {
  InvoiceUploadDonePage({Key? key}) : super(key: key);

  @override
  _InvoiceUploadDonePageState createState() => _InvoiceUploadDonePageState();
}

class _InvoiceUploadDonePageState extends State<InvoiceUploadDonePage> {
  @override
  Widget build(BuildContext context) {
    return RecookScaffold(
      title: '申请开票',
      bodyColor: AppColor.frenchColor,
      body: Column(
        children: [

          Expanded(
            child: Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 48.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  76.hb,
                  Center(
                    child: Icon(
                      Icons.check_circle,
                      color: Color(0xFFDB1E1E),
                      size: 148.w,
                    ),
                  ),
                  48.hb,
                  Center(
                    child: Text(
                      '提交成功',
                      style: TextStyle(
                        color: Color(0xFF333333),
                        fontSize: 18 * 2.sp,
                      ),
                    ),
                  ),
                 16.hb,
                  Center(
                    child: Text(
                      '您的发票预计将在24小时内开出，请注意查收',
                      style: TextStyle(
                        fontSize: 13 * 2.sp,
                        color: Color(0xFF999999),
                      ),
                    ),
                  ),
                  96.hb,
                  GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      margin: EdgeInsets.symmetric(
                        vertical: 24.w,
                      ),
                      padding: EdgeInsets.symmetric(vertical: 20.w),
                      decoration: BoxDecoration(
                        color:  Color(0xffd5101a),
                        borderRadius: BorderRadius.circular(40.w)
                      ),
                      child: Text(
                        '发票首页',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16 * 2.sp,
                        ),
                      ),
                    ),
                  ),

                  GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                      Navigator.pop(context);
                      Navigator.pop(context);
                      Get.to(()=>InvoiceHistoryPage());
                    },
                    child: Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      margin: EdgeInsets.symmetric(
                        vertical: 24.w,
                      ),
                      padding: EdgeInsets.symmetric(vertical: 20.w),
                      decoration: BoxDecoration(
                          color:  Colors.white,
                          borderRadius: BorderRadius.circular(40.w),
                        border: Border.all(color: Color(0xFFAAAAAA),width: 2.w)
                      ),
                      child: Text(
                        '开票历史',
                        style: TextStyle(
                          color: Color(0xFF666666),
                          fontSize: 16 * 2.sp,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}