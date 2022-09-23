import 'package:flutter/cupertino.dart';
import 'package:new_recook/constants/styles.dart';
import 'package:new_recook/models/user/invoice_get_bill_model.dart';
import 'package:new_recook/utils/headers.dart';
import 'package:new_recook/widget/button/recook_check_box.dart';
import 'package:new_recook/widget/no_data_widget.dart';
import 'package:new_recook/widget/recook_scaffold.dart';
import 'package:new_recook/widget/refresh_widget.dart';

import 'invoice_detail_page.dart';

class InvoiceWithGoodsPage extends StatefulWidget {
  InvoiceWithGoodsPage({Key? key}) : super(key: key);

  @override
  _InvoiceWithGoodsPageState createState() => _InvoiceWithGoodsPageState();
}

class _InvoiceWithGoodsPageState extends State<InvoiceWithGoodsPage> {
  GSRefreshController _refreshController =
      GSRefreshController(initialRefresh: true);

  List<InvoiceGetBillModel> _models = [
    InvoiceGetBillModel(endTime: '2022-10-10',goodsName: '伊犁牛奶',goodsTotalAmount: 10.2,orderId: 1),
    InvoiceGetBillModel(endTime: '2022-10-10',goodsName: '伊犁牛奶',goodsTotalAmount: 10.2,orderId: 2),
    InvoiceGetBillModel(endTime: '2022-10-10',goodsName: '伊犁牛奶',goodsTotalAmount: 10.2,orderId: 3)
  ];
  List<int?> _selectedIds = [];
  double _price = 0.0;
  //int _page = 0;

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RecookScaffold(
      title: '开具发票',
      bodyColor: Colors.white,
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 32.w,
              vertical: 16.w,
            ),
            child: Row(
              children: [
                Text(
                  '可开票订单',
                  style: TextStyle(
                    color: Color(0xFF333333),
                  ),
                ),
                Spacer(),
              ],
            ),
          ),
          Divider(
            color: Color(0xFFEEEEEE),
            height: 0.5,
          ),
          Expanded(
            child: RefreshWidget(
              onRefresh: () async {
                // await _invoicePresenter.getInvoice().then((value) {
                //   _page = 0;
                //   if (mounted) {
                //     setState(() {
                //       _models = value;
                //     });
                //     _refreshController.refreshCompleted();
                //   }
                // });
                _refreshController.refreshCompleted();
              },
              onLoadMore: () async {
                // _page++;
                // await _invoicePresenter.getInvoice(page: _page).then((value) {
                //   _models.addAll(value);
                //   if (mounted)
                //     setState(() {
                //       _refreshController.loadComplete();
                //     });
                // });
                _refreshController.loadComplete();
              },
              controller: _refreshController,
              body: _models.isNotEmpty? ListView.builder(
                itemBuilder: (context, index) {
                  return _buildCard(_models[index]);
                },
                itemCount: _models.length,
              ):NoDataWidget(text: '您还没有可开发票的订单'),
            ),
          ),
        ],
      ),
      bottomNavi: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 4.w,
              spreadRadius: 2.w,
              color: Color(0xFF3C0A07).withOpacity(0.07),
            ),
          ],
        ),
        child: SafeArea(
          bottom: true,
          top: false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 32.w,
                  vertical: 12.w,
                ),
                alignment: Alignment.centerLeft,
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(
                      color: Color(0xFF666666),
                      fontSize: 15 * 2.sp,
                    ),
                    children: [
                      TextSpan(
                        text: _selectedIds.length.toString(),
                        style: TextStyle(color: AppColor.priceColor),
                      ),
                      TextSpan(
                        text: '笔订单，共',
                      ),
                      TextSpan(
                        text: _price.toStringAsFixed(2),
                        style: TextStyle(color: AppColor.priceColor),
                      ),
                      TextSpan(
                        text: '元',
                      ),
                    ],
                  ),
                ),
              ),
              Divider(
                height: 0.5 * 2.w,
                color: Color(0xFFEEEEEE),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 32.w,
                  vertical: 20.w,
                ),
                child: Row(
                  children: [
                    CupertinoButton(
                      minSize: 0,
                      padding: EdgeInsets.zero,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding:  EdgeInsets.only(top: 10.w),
                            child: RecookCheckBox(
                                state: _selectedIds.length == _models.length),
                          ),
                          16.wb,
                          Text(
                            '全选',
                            style: TextStyle(
                              color: Color(0xFF333333),
                              fontSize: 14 * 2.sp,
                            ),
                          ),
                        ],
                      ),
                      onPressed: () {
                        if (_selectedIds.length == _models.length) {
                          _selectedIds = [];
                          _price = 0;
                        } else {
                          _selectedIds = [];
                          _price = 0;
                          _models.forEach((element) {
                            _price += element.goodsTotalAmount!;
                            _selectedIds.add(element.orderId);
                          });
                        }
                        setState(() {});
                      },
                    ),
                    Spacer(),
                    TextButton(
                      onPressed: () {
                        // AppRouter.push(context, RouteName.USER_INVOICE_DETAIL,
                        //     arguments: {'ids': _selectedIds, 'price': _price});

                        Get.to(()=>InvoiceDetailPage(price: _price, ids: _selectedIds,));
                      },
                      child: Text('开具发票',style: TextStyle(color: Colors.white),),
                      style:ButtonStyle(backgroundColor: MaterialStateProperty.all(AppColor.redColor),)
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _buildCard(InvoiceGetBillModel model) {
    return InkWell(
      onTap: () {
        if (_selectedIds.contains(model.orderId)) {
          _selectedIds.remove(model.orderId);
          _price -= model.goodsTotalAmount!;
        } else {
          _selectedIds.add(model.orderId);
          _price += model.goodsTotalAmount!;
        }
        setState(() {});
      },
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              width: 2.w,
              color: Color(0xFFEEEEEE),
            ),
          ),
        ),
        height: 100 * 2.w,
        child: Row(
          children: [
            RecookCheckBox(state: _selectedIds.contains(model.orderId)),
            32.wb,
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.endTime!,
                    style: TextStyle(
                      color: Color(0xFF666666),
                      fontSize: 14 * 2.sp,
                    ),
                  ),
                  Text(
                    model.goodsName!,
                    style: TextStyle(
                      color: Color(0xFF333333),
                      fontSize: 14 * 2.sp,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(
                  model.goodsTotalAmount.toString(),
                  style: TextStyle(
                    color: Color(0xFFDB2D2D),
                    fontSize: 24 * 2.sp,
                  ),
                ),
                Text(
                  '元',
                  style: TextStyle(
                    color: Color(0xFF666666),
                    fontSize: 14 * 2.sp,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
