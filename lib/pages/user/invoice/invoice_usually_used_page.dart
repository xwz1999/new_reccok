import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:new_recook/models/user/invoice_title_list_model.dart';
import 'package:new_recook/utils/headers.dart';
import 'package:new_recook/widget/recook_scaffold.dart';
import 'package:new_recook/widget/refresh_widget.dart';

import 'invoice_add_title_page.dart';

class InvoiceUsuallyUsedPage extends StatefulWidget {
  InvoiceUsuallyUsedPage({Key? key}) : super(key: key);

  @override
  _InvoiceUsuallyUsedPageState createState() => _InvoiceUsuallyUsedPageState();
}

class _InvoiceUsuallyUsedPageState extends State<InvoiceUsuallyUsedPage> {
  GSRefreshController _controller = GSRefreshController();
  List<InvoiceTitleListModel> _models = [
    InvoiceTitleListModel(
        id: 1,uid: 2,name: '问问',taxnum: '123123213',address: '阿斯顿收到了',phone: '12232345324',bank: '宁波银行',defaultValue: 1,type: 1
    ),
    InvoiceTitleListModel(
        id: 1,uid: 2,name: '问问',taxnum: '123123213',address: '阿斯顿收到了',phone: '12232345324',bank: '宁波银行',defaultValue: 0,type: 1
    ),
  ];

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 500), () {
      if (mounted) _controller.requestRefresh();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RecookScaffold(
      title: '常用开票抬头',
      body: RefreshWidget(
        controller: _controller,
        onRefresh: () async {
          _controller.refreshCompleted();
        },
        body: ListView.separated(
          padding: EdgeInsets.only(
            top: 16.w,
          ),
          separatorBuilder: (context, index) {
            return SizedBox(height: 4.w);
          },
          itemBuilder: (context, index) {
            return _buildCard(_models[index]);
          },
          itemCount: _models.length,
        ),
      ),
      bottomNavi: Container(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 64.w,
            vertical: 24.w,
          ),
          child: SafeArea(
            bottom: true,
            top: false,
            child: GestureDetector(
              onTap: () {
                Get.to(()=>InvoiceAddTitlePage())?.then((value) {
                  _controller.requestRefresh();
                });
              },
              child: Container(
                alignment: Alignment.center,
                height: 80.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40.w),
                  color: Color(0xffd5101a),
                ),
                child: Text('添加新的抬头',style: TextStyle(fontSize: 32.sp,color: Colors.white),),

              ),
            ),
          ),
        ),
      ),
    );
  }

  _buildCard(InvoiceTitleListModel model) {
    return Material(
      color: Colors.white,
      child: InkWell(
        onTap: () {
          Get.to(()=>InvoiceAddTitlePage(model: model,))?.then((value) {
            _controller.requestRefresh();
          });
        },
        child: Container(
          constraints: BoxConstraints(minHeight: 124.w),
          child: Row(
            children: [
              SizedBox(width: 30.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        model.name!,
                        style: TextStyle(
                          color: Color(0xFF333333),
                          fontSize: 32.sp,
                        ),
                      ),
                      SizedBox(width: 16.w),
                      model.defaultValue == 1
                          ? Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 3.w,
                          vertical: 1.w,
                        ),
                        child: Text(
                          '默认抬头',
                          style: TextStyle(
                            color: Color(0xFFD5101A),
                            fontSize: 20.sp,
                          ),
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1,
                            color: Color(0xFFD5101A),
                          ),
                          borderRadius: BorderRadius.circular(8.w),
                        ),
                      )
                          : SizedBox(),
                    ],
                  ),
                  10.hb,
                  Text(
                    model.type==1?'企业抬头':'个人抬头',
                    style: TextStyle(
                      color: Color(0xFF999999),
                      fontSize: 24.sp,
                    ),
                  ),
                ],
              ),







              Spacer(),
              Icon(
                Icons.navigate_next,
                color: Color(0xFF666666),
                size: 40.w,
              ),
              SizedBox(width: 24.w),
            ],
          ),
        ),
      ),
    );
  }
}
