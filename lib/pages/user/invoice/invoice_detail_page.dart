import 'package:new_recook/constants/styles.dart';
import 'package:new_recook/pages/user/invoice/invoice_detail_more_page.dart';
import 'package:new_recook/pages/user/invoice/pick_invoice_title_picker.dart';
import 'package:new_recook/utils/headers.dart';
import 'package:new_recook/utils/text_utils.dart';
import 'package:new_recook/widget/button/recook_check_box.dart';
import 'package:new_recook/widget/recook_scaffold.dart';

import 'invoice_upload_done_page.dart';

class InvoiceDetailPage extends StatefulWidget {
  final List<int?> ids;
  final double price;
  InvoiceDetailPage({
    Key? key, required this.ids, required this.price,
  }) : super(key: key);

  @override
  _InvoiceDetailPageState createState() => _InvoiceDetailPageState();
}

class _InvoiceDetailPageState extends State<InvoiceDetailPage> {
  bool _isCompany = true;

  TextEditingController _cName = TextEditingController();
  TextEditingController _pName = TextEditingController();
  TextEditingController _taxNum = TextEditingController();
  TextEditingController _phone = TextEditingController();
  TextEditingController _email = TextEditingController();

  TextEditingController _addr = TextEditingController();
  TextEditingController _telePhone = TextEditingController();
  TextEditingController _bankNum = TextEditingController();
  TextEditingController _message = TextEditingController();

  GlobalKey<FormState> _formState = GlobalKey<FormState>();

  controllerClear() {
    _cName.clear();
    _pName.clear();
    _taxNum.clear();
    _phone.clear();
    _email.clear();
    _addr.clear();
    _telePhone.clear();
    _bankNum.clear();
    _message.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formState,
      child: RecookScaffold(
        title: '开具发票',
        body: ListView(
          padding: EdgeInsets.only(
            top: 16.w,
          ),
          children: [
            Container(
              padding: EdgeInsets.all(24.w),
              //margin: EdgeInsets.symmetric(horizontal: 24.w),
              decoration: BoxDecoration(
                color: Colors.white,
                //borderRadius: BorderRadius.circular(16.w),
              ),
              child: Column(
                children: [
                  Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            '订单编号',
                            style: TextStyle(
                              fontSize: 28.sp,
                              color: Color(0xFF333333),
                            ),
                          ),
                          20.wb,
                          Text(
                            '232748502637',
                            style: TextStyle(
                                fontSize: 28.sp,
                                color: Color(0xFF333333),
                                fontWeight: FontWeight.bold,height: 1.5),

                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            '开票金额',
                            style: TextStyle(
                              fontSize: 28.sp,
                              color: Color(0xFF333333),
                            ),
                          ),
                          20.wb,
                          Text(
                            '¥438.00',
                            style: TextStyle(
                              fontSize: 28.sp,
                              color: Color(0xFFD5101A),height: 1.5
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            '订单编号',
                            style: TextStyle(
                              fontSize: 28.sp,
                              color: Color(0xFF333333),
                            ),
                          ),
                          20.wb,
                          Text(
                            '232748502637',
                            style: TextStyle(
                                fontSize: 28.sp,
                                color: Color(0xFF333333),
                                fontWeight: FontWeight.bold,height: 1.5),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            '开票金额',
                            style: TextStyle(
                              fontSize: 28.sp,
                              color: Color(0xFF333333),
                            ),
                          ),
                          20.wb,
                          Text(
                            '¥438.00',
                            style: TextStyle(
                              fontSize: 28.sp,
                              color: Color(0xFFD5101A),height: 1.5
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            16.hb,
            _titleWidget(
              '抬头类型',
              Row(
                children: [
                  Expanded(
                      child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _isCompany = true;
                            controllerClear();
                          });
                        },
                        child: Row(
                          children: [
                            RecookCheckBox(state: _isCompany),
                            SizedBox(width: 16.w),
                            Text(
                              '企业单位',
                              style: TextStyle(
                                fontSize: 14 * 2.sp,
                                color: Color(0xFF666666),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 48.w),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _isCompany = false;
                            controllerClear();
                          });
                        },
                        child: Row(
                          children: [
                            RecookCheckBox(state: !_isCompany),
                            SizedBox(width: 16.w),
                            Text(
                              '个人/非企业',
                              style: TextStyle(
                                fontSize: 14 * 2.sp,
                                color: Color(0xFF666666),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ))
                ],
              ),
            ),
            _buildDivider(),
            _isCompany ? _buildInc() : _buildPerson(),
            16.hb,
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 32.w,
                vertical: 24.w,
              ),
              color: Colors.white,
              child: Row(
                children: [
                  Text(
                    '总金额',
                    style: TextStyle(
                      color: Color(0xFF333333),
                      fontSize: 16 * 2.sp,
                    ),
                  ),
                  Spacer(),
                  Text(
                    widget.price.toString(),
                    style: TextStyle(
                      color: Color(0xFFDB2D2D),
                      fontSize: 28.sp,height: 1.5
                    ),
                  ),
                  Text(
                    ' 元',
                    style: TextStyle(
                      color: Color(0xFF999999),
                      fontSize: 28.sp,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 32.w,
                vertical: 20.w,
              ),
              alignment: Alignment.centerLeft,
              child: Text(
                '接收方式',
                style: TextStyle(
                  fontSize: 14 * 2.sp,
                  color: Color(0xFF666666),
                ),
              ),
            ),
            _titleWidget(
              '手机号码',
              TextFormField(
                validator: (value) {
                  if (TextUtils.isEmpty(value)) {
                    return "请填写接收发票手机号码";
                  } else
                    return null;
                },
                style: TextStyle(
                  color: Color(0xFF333333),
                ),
                onChanged: (_) => setState(() {}),
                controller: _phone,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.zero,
                  isDense: true,
                  border: InputBorder.none,
                  hintText: '用于向您发送开票成功通知',
                  hintStyle: TextStyle(
                    color: Color(0xFF999999),
                    fontSize: 14 * 2.sp,
                  ),
                ),
              ),
            ),
            _titleWidget(
              '电子邮箱',
              TextFormField(
                style: TextStyle(
                  color: Color(0xFF333333),
                ),
                validator: (value) {
                  if (TextUtils.isEmpty(value)) {
                    return "请填写接收发票电子邮箱";
                  } else
                    return null;
                },
                onChanged: (_) => setState(() {}),
                controller: _email,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.zero,
                  isDense: true,
                  border: InputBorder.none,
                  hintText: '用于向您发送电子发票',
                  hintStyle: TextStyle(
                    color: Color(0xFF999999),
                    fontSize: 14 * 2.sp,
                  ),
                ),
              ),
            )
          ],
        ),
        bottomNavi: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 64.w,
            vertical: 24.w,
          ),
          child: SafeArea(
            bottom: true,
            top: false,
            child: GestureDetector(
              onTap: _parseCheck()
                  ? () {
                      if (_formState.currentState!.validate()) {
                        showGeneralDialog(
                          barrierDismissible: true,
                          barrierLabel: '',
                          barrierColor: Colors.black.withOpacity(0.5),
                          transitionDuration: Duration(milliseconds: 300),
                          context: context,
                          pageBuilder:
                              (context, animation, secondaryAnimation) {
                            return Align(
                              alignment: Alignment.bottomCenter,
                              child: Material(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(
                                        20.w,
                                      ),
                                    ),
                                  ),
                                  height: 750.w,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Center(
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 30.w),
                                          child: Text(
                                            '开具电子发票',
                                            style: TextStyle(
                                              fontSize: 18 * 2.sp,
                                              color: Color(0xFF333333),
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                          child: ListView(
                                        children: [
                                          Divider(
                                            height: 0.5,
                                            color: Color(0xFF666666),
                                          ),
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                              vertical: 24.w,
                                              horizontal: 32.w,
                                            ),
                                            child: Row(
                                              children: [
                                                Text(
                                                  '发票类型',
                                                  style: TextStyle(
                                                    fontSize: 32.sp,
                                                    color: Color(0xFF999999),
                                                  ),
                                                ),
                                                Spacer(),
                                                Text(
                                                  '电子发票',
                                                  style: TextStyle(
                                                    fontSize: 28.sp,
                                                    color: Color(0xFF333333),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Divider(
                                            height: 0.5,
                                            color: Color(0xFF666666),
                                          ),
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                              vertical: 24.w,
                                              horizontal: 32.w,
                                            ),
                                            child: Row(
                                              children: [
                                                Text(
                                                  '发票抬头',
                                                  style: TextStyle(
                                                    fontSize: 32.sp,
                                                    color: Color(0xFF999999),
                                                  ),
                                                ),
                                                Spacer(),
                                                Text(
                                                  _isCompany
                                                      ? _cName.text
                                                      : _pName.text,
                                                  style: TextStyle(
                                                    fontSize: 28.sp,
                                                    color: Color(0xFF333333),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Divider(
                                            height: 0.5,
                                            color: Color(0xFF666666),
                                          ),
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                              vertical: 24.w,
                                              horizontal: 32.w,
                                            ),
                                            child: Row(
                                              children: [
                                                Text(
                                                  '开票金额',
                                                  style: TextStyle(
                                                    fontSize: 32.sp,
                                                    color: Color(0xFF999999),
                                                  ),
                                                ),
                                                Spacer(),
                                                Text(
                                                  widget.price.toString(),
                                                  style: TextStyle(
                                                      fontSize: 28.sp,
                                                      color: Color(0xffd5101a),height: 1.5),
                                                ),
                                                Text(
                                                  '元',
                                                  style: TextStyle(
                                                    fontSize: 28.sp,
                                                    color: Color(0xFF333333),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Divider(
                                            height: 1.w,
                                            color: Color(0xFF666666),
                                          ),
                                        ],
                                      )),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 32.w,
                                          vertical: 24.w,
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 32.w,
                                            vertical: 24.w,
                                          ),
                                          child: TextButton(
                                            onPressed: _parseCheck()
                                                ? () async {
                                              Get.to(()=>InvoiceUploadDonePage());
                                            }
                                                : null,
                                            style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all(
                                                        AppColor.redColor)),
                                            child: Text(
                                              '确认提交',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16 * 2.sp,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: MediaQuery.of(context)
                                            .viewPadding
                                            .bottom,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      }
                    }
                  : null,
              child: Container(
                alignment: Alignment.center,
                height: 80.w,
                padding: EdgeInsets.symmetric(vertical: 16.w),
                decoration: BoxDecoration(
                  color: Color(0xFFDB1E1E),
                  borderRadius: BorderRadius.circular(36.w)
                ),
                child: Text(
                  '提交申请',
                  style: TextStyle(
                    fontSize: 16 * 2.sp,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool _parseCheck() {
    return _isCompany
        ? (TextUtils.isNotEmpty(_cName.text) &&
            TextUtils.isNotEmpty(_taxNum.text))
        : (TextUtils.isNotEmpty(_pName.text));
  }

  _buildInc() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _titleWidget(
          '发票抬头',
          TextField(
            style: TextStyle(
              color: Color(0xFF333333),
            ),
            onChanged: (_) => setState(() {}),
            controller: _cName,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.zero,
              isDense: true,
              border: InputBorder.none,
              hintText: '填写需要开具发票的企业名称',
              hintStyle: TextStyle(
                color: Color(0xFF999999),
                fontSize: 14 * 2.sp,
              ),
            ),
          ),
          suffix: GestureDetector(
            child: Icon(
              Icons.menu,
              color: Color(0xFF707070),
            ),
            onTap: () {
              pickInvoiceTitle(context, (model) {
                if (model.type == 1) {
                  _addr.text = model.address!;
                  _cName.text = model.name!;
                  _taxNum.text = model.taxnum!;
                  _telePhone.text = model.phone!;
                  _bankNum.text = model.bank!;
                } else {
                  _pName.text = model.name!;
                }
              });
            },
          ),
        ),
        _buildDivider(),
        _titleWidget(
          '公司税号',
          TextField(
            style: TextStyle(
              color: Color(0xFF333333),
            ),
            onChanged: (_) => setState(() {}),
            controller: _taxNum,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.zero,
              isDense: true,
              border: InputBorder.none,
              hintText: '填写纳税人识别号',
              hintStyle: TextStyle(
                color: Color(0xFF999999),
                fontSize: 14 * 2.sp,
              ),
            ),
          ),
        ),
        _buildDivider(),
        GestureDetector(
            onTap: () {
              Get.to(() => InvoiceDetailMorePage(
                    address: _addr,
                    bankNum: _bankNum,
                    message: _message,
                    telephone: _telePhone,
                  ));
            },
            child: _titleWidget(
              '更多内容',
              Text(
                '填写备注、地址等（非必填）',
                style: TextStyle(
                  color: Color(0xFF999999),
                  fontSize: 14 * 2.sp,
                ),
              ),
              suffix: Icon(
                Icons.navigate_next,
                color: Color(0xFFCCCCCC),
                size: 40.sp,
              ),
            ))
      ],
    );
  }

  _buildPerson() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _titleWidget(
          '抬头名称',
          TextField(
            style: TextStyle(
              color: Color(0xFF333333),
            ),
            onChanged: (_) => setState(() {}),
            controller: _pName,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.zero,
              isDense: true,
              border: InputBorder.none,
              hintText: '填写发票抬头',
              hintStyle: TextStyle(
                color: Color(0xFF999999),
                fontSize: 14 * 2.sp,
              ),
            ),
          ),
          suffix: GestureDetector(
            child: Icon(
              Icons.menu,
              color: Color(0xFF707070),
            ),
            onTap: () {
              pickInvoiceTitle(context, (model) {
                if (model.type == 1) {
                  _addr.text = model.address!;
                  _cName.text = model.name!;
                  _taxNum.text = model.taxnum!;
                  _telePhone.text = model.phone!;
                  _bankNum.text = model.bank!;
                } else {
                  _pName.text = model.name!;
                }
              });
            },
          ),
        )
      ],
    );
  }

  _buildDivider() {
    return Container(
      child: Divider(
        height: 0.5 * 2.w,
        thickness: 1,
        color: Color(0xFFEEEEEE),
      ),
      color: Colors.white,
    );
  }

  _titleWidget(
    String title,
    Widget mid, {
    Widget? suffix,
  }) {
    return Container(
      color: Colors.white,
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(
              color: Color(0xFF333333),
              fontSize: 16 * 2.sp,
            ),
          ),
          32.wb,
          Expanded(child: mid),
          suffix ?? SizedBox(),
        ],
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 32.w,
        vertical: 24.w,
      ),
    );
  }
}
