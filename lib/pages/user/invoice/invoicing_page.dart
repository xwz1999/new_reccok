import 'package:new_recook/utils/headers.dart';
import 'package:new_recook/widget/recook_scaffold.dart';

import 'Invoice_with_goods_page.dart';
import 'invoice_history_page.dart';
import 'invoice_usually_used_page.dart';

class InvoicingPage extends StatefulWidget {
  const InvoicingPage({Key? key}) : super(key: key);

  @override
  _InvoicingPageState createState() => _InvoicingPageState();
}

class _InvoicingPageState extends State<InvoicingPage> {
  @override
  Widget build(BuildContext context) {
    return RecookScaffold(
      title: '发票助手',
      body: ListView(
        padding: EdgeInsets.only(
          top: 16.w,
        ),
        children: [
          GestureDetector(
            onTap: (){
              Get.to(()=>InvoiceWithGoodsPage());
            },
            child: Container(
              padding: EdgeInsets.all(24.w),
              color: Colors.white,
              child: Row(
                children: [
                  Text('平台消费开票',style: TextStyle(fontSize: 28.sp,color: Color(0xFF333333),fontWeight: FontWeight.bold),),
                  Spacer(),
                  Icon(
                    Icons.keyboard_arrow_right,
                    size: 40.sp,
                    color: Colors.grey,
                  )
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: (){
              Get.to(()=>InvoiceUsuallyUsedPage());
            },
            child: Container(
              padding: EdgeInsets.all(24.w),
              color: Colors.white,
              child: Row(
                children: [
                  Text('常用开票抬头',style: TextStyle(fontSize: 28.sp,color: Color(0xFF333333),fontWeight: FontWeight.bold),),
                  Spacer(),
                  Icon(
                    Icons.keyboard_arrow_right,
                    size: 40.sp,
                    color: Colors.grey,
                  )
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: (){
              Get.to(()=>InvoiceHistoryPage());
            },
            child: Container(
              padding: EdgeInsets.all(24.w),
              color: Colors.white,
              child: Row(
                children: [
                  Text('开票历史',style: TextStyle(fontSize: 28.sp,color: Color(0xFF333333),fontWeight: FontWeight.bold),),
                  Spacer(),
                  Icon(
                    Icons.keyboard_arrow_right,
                    size: 40.sp,
                    color: Colors.grey,
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
