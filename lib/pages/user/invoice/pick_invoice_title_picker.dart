
import 'package:new_recook/models/user/invoice_title_list_model.dart';
import 'package:new_recook/utils/headers.dart';
import 'package:new_recook/widget/refresh_widget.dart';

import 'invoice_add_title_page.dart';

pickInvoiceTitle(
    BuildContext context, Function(InvoiceTitleListModel model) onModel) {
  showGeneralDialog(
    context: context,
    pageBuilder: (BuildContext context, Animation<double> animation,
        Animation<double> secondaryAnimation) {
      return Align(
        alignment: Alignment.bottomCenter,
        child: InvoicePicker(
          onModel: onModel,
        ),
      );
    },
    barrierDismissible: true,
    barrierLabel: '',
    barrierColor: Colors.black.withOpacity(0.5),
    transitionDuration: Duration(milliseconds: 300),
  );
}

class InvoicePicker extends StatefulWidget {
  final Function(InvoiceTitleListModel model)? onModel;
  InvoicePicker({Key? key, this.onModel}) : super(key: key);

  @override
  _InvoicePickerState createState() => _InvoicePickerState();
}

class _InvoicePickerState extends State<InvoicePicker> {

  List<InvoiceTitleListModel> _models = [
    InvoiceTitleListModel(
      id: 1,uid: 2,name: '问问',taxnum: '123123213',address: '阿斯顿收到了',phone: '12232345324',bank: '宁波银行',defaultValue: 1,type: 1
    ),
    InvoiceTitleListModel(
        id: 1,uid: 2,name: '问问',taxnum: '123123213',address: '阿斯顿收到了',phone: '12232345324',bank: '宁波银行',defaultValue: 0,type: 1
    ),
    InvoiceTitleListModel(
        id: 1,uid: 2,name: '问问',taxnum: '123123213',address: '阿斯顿收到了',phone: '12232345324',bank: '宁波银行',defaultValue: 0,type: 1
    ),
  ];
  GSRefreshController _controller = GSRefreshController();
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 500), () {
      if (mounted) {
        _controller.requestRefresh();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(
              32.w
            ),
          ),
        ),
        height: 750.w,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.all(32.w),
              child: Text(
                '常用发票抬头',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF333333),
                  fontSize: 16 * 2.sp,
                ),
              ),
            ),
            _buildDivider(),
            Expanded(
                child: RefreshWidget(
              controller: _controller,
              onRefresh: () async {
                _controller.refreshCompleted();
              },
              body: ListView.separated(
                  separatorBuilder: (context, index) {
                    return Divider(
                      height: 1.w,
                      color: Color(0xFF666666),
                    );
                  },
                  itemBuilder: (context, index) {
                    return Material(
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                          widget.onModel!(_models[index]);
                        },
                        child: Row(
                          children: [
                            SizedBox(
                              width: 30.w,
                              height:96.w,
                            ),
                            Text(
                              _models[index].name!,
                              style: TextStyle(
                                color: Color(0xFF333333),
                                fontSize: 28.sp,
                              ),
                            ),
                            Spacer(),
                            _models[index].defaultValue == 1
                                ? Text(
                                    '默认抬头',
                                    style: TextStyle(
                                      color: Color(0xFFFA6400),
                                      fontSize: 28.sp,
                                    ),
                                  )
                                : SizedBox(),
                            SizedBox(
                              width: 30.w,
                              height:96.w,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  itemCount: _models.length),
            )),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal:32.w,
                vertical:24.w,
              ),
              child: GestureDetector(
                onTap: (){
                  Get.off(InvoiceAddTitlePage());
                },
                child: Container(
                  alignment: Alignment.center,

                  padding: EdgeInsets.symmetric(
                    vertical:24.w,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50.w),
                    color: Color(0xffd5101a),
                  ),
                  child: Text('添加常用发票抬头',style: TextStyle(color: Colors.white),),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).viewPadding.bottom,
            ),
          ],
        ),
      ),
    );
  }

  _buildDivider() {
    return Divider(
      color: Color(0xFFEEEEEE),
      thickness: 0.5,
      height: 0.5,
    );
  }
}
