import 'package:new_recook/models/user/invoice_bill_list_model.dart';
import 'package:new_recook/utils/headers.dart';
import 'package:new_recook/widget/recook_scaffold.dart';
import 'package:new_recook/widget/refresh_widget.dart';

import 'invoice_detail_information_page.dart';

class InvoiceHistoryPage extends StatefulWidget {
  InvoiceHistoryPage({Key? key}) : super(key: key);

  @override
  _InvoiceHistoryPageState createState() => _InvoiceHistoryPageState();
}

class _InvoiceHistoryPageState extends State<InvoiceHistoryPage> {
  List<InvoiceBillListModel> _models = [
    InvoiceBillListModel(
        id: 1,
        userId: 1,
        orderId: 1,
        buyerName: '阿三',
        taxNum: '123',
        address: '宁波市',
        telephone: '1232335452',
        phone: '12312323',
        email: '123123@123.com',
        account: '2',
        message: '123123',
        totalAmount: 123,
        invoiceStatus: 1,
        fpqqlsh: '123',
        ctime: '2022-10-10',
        failReasons: '123123',
        ctimeInvoice: '123123',
        invoiceUrl: '122')
  ];
  GSRefreshController _gsRefreshController = GSRefreshController();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 500), () {
      _gsRefreshController.requestRefresh();
    });
  }

  @override
  Widget build(BuildContext context) {
    return RecookScaffold(
      title: '开票历史',
      body: RefreshWidget(
        onRefresh: () async {
          _gsRefreshController.refreshCompleted();
        },
        controller: _gsRefreshController,
        body: ListView.builder(
          itemBuilder: (context, index) {
            return invoiceHistoryCard(
              context,
              _models[index],
            );
          },
          itemCount: _models.length,
        ),
      ),
    );
  }
}

Widget invoiceHistoryCard(BuildContext context, InvoiceBillListModel model) {
  return GestureDetector(
    onTap: () {
      Get.to(() => InvoiceDetailInformationPage(
            id: model.orderId,
          ));
    },
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.w),
      ),
      margin: EdgeInsets.symmetric(
        horizontal: 32.w,
        vertical: 16.w,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 28.w),
          Row(
            children: [
              Container(
                margin: EdgeInsets.only(left: 20.w, right: 16.w),
                height: 24.w,
                width: 24.w,
                decoration: BoxDecoration(
                  color: Color(0xFFFD8637),
                  borderRadius: BorderRadius.circular(12.w),
                ),
              ),
              Text(
                model.ctime!,
                style: TextStyle(
                  color: Color(0xFF666666),
                  fontSize: 28.sp,
                ),
              ),
              Spacer(),
              Icon(
                Icons.navigate_next,
                size: 40.w,
                color: Color(0xFFCCCCCC),
              ),
              SizedBox(width: 20.w),
            ],
          ),
          SizedBox(height: 30.w),
          Row(
            children: [
              SizedBox(width: 60.w),
              Text(
                '平台消费',
                style: TextStyle(
                  color: Color(0xFF666666),
                  fontSize: 28.sp,
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 6.w),
                decoration: BoxDecoration(
                  color: Color(0xFFE2F3FF),
                  borderRadius: BorderRadius.circular(6.w),
                  border: Border.all(
                    width: 2.w,
                    color: Color(0xFF63BCFF),
                  ),
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: 10.w,
                  vertical: 4.w,
                ),
                child: Text(
                  '电子发票',
                  style: TextStyle(
                    color: Color(0xFF10B1F1),
                    fontSize: 22.sp,
                  ),
                ),
              ),
              Spacer(),
              Row(
                textBaseline: TextBaseline.alphabetic,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                children: [
                  Text(
                    model.totalAmount!.toStringAsFixed(2),
                    style: TextStyle(
                      fontSize: 48.w,
                      color: Color(0xFF333333),
                    ),
                  ),
                  Text(
                    '元',
                    style: TextStyle(
                      fontSize: 28.sp,
                      color: Color(0xFF999999),
                    ),
                  ),
                ],
              ),
              SizedBox(width: 32.w),
            ],
          ),
          SizedBox(height: 40.w),
          Divider(
            height: 2.w,
            thickness: 2.w,
            color: Color(0xFFEEEEEE),
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(
              left: 20.w,
              bottom: 20.w,
              top: 16.w,
            ),
            child: Text(
              model.statusString,
              style: TextStyle(
                color: model.statusColor,
                fontSize: 26.sp,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
