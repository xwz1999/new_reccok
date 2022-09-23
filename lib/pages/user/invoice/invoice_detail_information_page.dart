import 'package:new_recook/models/user/invoice_detail_model.dart';
import 'package:new_recook/utils/headers.dart';
import 'package:new_recook/widget/recook_scaffold.dart';


class InvoiceDetailInformationPage extends StatefulWidget {
  final int? id;
  InvoiceDetailInformationPage({
    Key? key,
    this.id,
  }) : super(key: key);

  @override
  _InvoiceDetailInformationPageState createState() =>
      _InvoiceDetailInformationPageState();
}

class _InvoiceDetailInformationPageState
    extends State<InvoiceDetailInformationPage> {
  InvoiceDetailModel? model;

  bool _showMore = false;
  @override
  void initState() {
    super.initState();
    model = InvoiceDetailModel(
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
        invoiceStatus:1,
        fpqqlsh:'123',
        ctime: '123123',
        failReasons: '123123',
        ctimeInvoice: '123123',
        invoiceUrl: '122'
    );
  }


  String  statusString(int invoiceStatus) {
    switch (invoiceStatus) {
      case 1:
        return '开票中';
      case 2:
        return '开票异常';
      case 3:
        return '开票中';
      case 4:
        return '开票失败';
      case 5:
        return '开票成功';
      default:
        return '未知';
    }
  }

  @override
  Widget build(BuildContext context) {
    return RecookScaffold(
      title: '发票详情',
      body: model == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView(
              children: [
                16.hb,
                Container(
                  color: Colors.white,
                  padding: EdgeInsets.symmetric(
                    vertical: 24.w,
                    horizontal:32.w,
                  ),
                  child: Row(
                    children: [
                      Text(
                        '电子发票',
                        style: TextStyle(
                          color: Color(0xFF333333),
                          fontSize: 32.sp,
                        ),
                      ),

                      Spacer(),
                      Text(
                        statusString(model!.invoiceStatus??1),
                        style: TextStyle(
                          color: model!.invoiceStatus == 5
                              ? Color(0xFFFF8F44)
                              : Color(0xFF333333),
                          fontSize: 32.sp,
                        ),
                      ),
                    ],
                  ),
                ),
                16.hb,
                _buildBox('发票抬头', model!.buyerName),
                _buildBox('公司税号', model!.taxNum),
                _buildBox('公司地址', model!.address, show: _showMore),
                _buildBox('公司电话', model!.telephone, show: _showMore),
                _buildBox('开户银行银行', model!.account, show: _showMore),
                _buildBox('开户银行账号', model!.account, show: _showMore),
                _buildBox('发票内容', '平台消费', show: _showMore),//发票内容暂时写死
                _buildBox('备注', model!.message, show: _showMore),
                Container(
                  color: Colors.white,
                  padding: EdgeInsets.symmetric(
                    vertical: 24.w,
                    horizontal: 32.w,
                  ),
                  child: Row(
                    children: [
                      Text(
                        '发票金额',
                        style: TextStyle(
                          color: Color(0xFF999999),
                          fontSize: 32.sp,
                        ),
                      ),
                      Spacer(),
                      Text(
                        model!.totalAmount!.toStringAsFixed(2),
                        style: TextStyle(
                          color: Color(0xFFFF4D4F),
                          fontSize: 28.sp,
                          height: 1.5
                        ),
                      ),
                      Text(
                        '元',
                        style: TextStyle(
                          color: Color(0xFF333333),
                          fontSize: 28.sp,
                        ),
                      ),
                    ],
                  ),
                ),
                _buildBox('开票时间', model!.ctime),
                GestureDetector(
                  child: Container(
                    color: Colors.white,
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(vertical: 24.w),
                    child: Text(
                      _showMore ? '收起' : '展开更多信息',
                      style: TextStyle(
                        color: Color(0xFF999999),
                        fontSize: 24.sp,
                      ),
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      _showMore = !_showMore;
                    });
                  },
                ),
              ],
            ),
    );
  }

  _buildBox(String title, String? subtitle, {bool show = true}) {
    if (!show) return SizedBox();
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(
        vertical: 24.w,
        horizontal:32.w
      ),
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(
              color: Color(0xFF999999),
              fontSize: 32.sp
            ),
          ),
          Spacer(),
          Text(
            subtitle!,
            style: TextStyle(
              color: Color(0xFF333333),
              fontSize: 28.sp
            ),
          ),
        ],
      ),
    );
  }
}
