import 'package:flutter/cupertino.dart';
import 'package:new_recook/models/user/invoice_title_list_model.dart';
import 'package:new_recook/utils/headers.dart';
import 'package:new_recook/utils/text_utils.dart';
import 'package:new_recook/widget/button/recook_check_box.dart';
import 'package:new_recook/widget/recook_scaffold.dart';

class InvoiceAddTitlePage extends StatefulWidget {
  final InvoiceTitleListModel? model;

  InvoiceAddTitlePage({Key? key, this.model}) : super(key: key);

  @override
  _InvoiceAddTitlePageState createState() => _InvoiceAddTitlePageState();
}

class _InvoiceAddTitlePageState extends State<InvoiceAddTitlePage> {
  bool _isCompany = true;
  bool defaultValue = false;

  TextEditingController _cName = TextEditingController();
  TextEditingController _pName = TextEditingController();
  TextEditingController _taxNum = TextEditingController();
  TextEditingController _address = TextEditingController();
  TextEditingController _phone = TextEditingController();
  TextEditingController _bankNum = TextEditingController();
  TextEditingController _bankName = TextEditingController();

  InvoiceTitleListModel? model;

  @override
  void initState() {
    super.initState();
    if (widget.model != null) {
      model = widget.model;
      _isCompany = (model!.type == 1);
      _cName.text = _isCompany ? model!.name! : "";
      _pName.text = _isCompany ? "" : model!.name!;
      _taxNum.text = model!.taxnum!;
      _address.text = model!.address!;
      _phone.text = model!.phone!;
      _bankNum.text = model!.bank!;
      defaultValue = model!.defaultValue == 1;
      _bankName.text = '宁波银行';
    }
  }

  @override
  Widget build(BuildContext context) {
    return RecookScaffold(
      title: '常用发票抬头',
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 16.w),
        children: [
          _titleWidget('抬头类型',  Row(
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    _isCompany = true;
                  });
                },
                child: Row(
                  children: [
                    RecookCheckBox(state: _isCompany),
                    16.wb,
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
              48.wb,
              GestureDetector(
                onTap: () {
                  setState(() {
                    _isCompany = false;
                  });
                },
                child: Row(
                  children: [
                    RecookCheckBox(state: !_isCompany),
                    16.wb,
                    Text(
                      '个人/非企业单位',
                      style: TextStyle(
                        fontSize: 14 * 2.sp,
                        color: Color(0xFF666666),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )),
          _isCompany ? _buildCompany() : _buildPersonal(),
          20.hb,
          Material(
            color: Colors.white,
            child: ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 32.w),
              title: Text(
                '设备默认抬头',
                style: TextStyle(
                  color: Color(0xFF333333),
                  fontSize: 32.sp,
                ),
              ),
              subtitle: Text(
                '每次开票会默认填写该抬头信息',
                style: TextStyle(
                  color: Color(0xFF333333),
                  fontSize: 24.sp,
                ),
              ),
              trailing: CupertinoSwitch(
                value: defaultValue,
                activeColor: Color(0xffd5101a),
                onChanged: (value) {
                  setState(() {
                    defaultValue = value;
                  });
                },
              ),
            ),
          ),
        ],
      ),
      bottomNavi: Container(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 32.w,
            vertical: 24.w
          ),
          child: SafeArea(
            bottom: true,
            top: false,
            child: GestureDetector(
              onTap: _parseCheck()
                  ? () {
                if (widget.model != null) {

                }

              }
                  : null,
              child: Container(
                alignment: Alignment.center,
                height: 80.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40.w),
                  color: Color(0xFFDB1E1E),
                ),

                child: Text('保存',style: TextStyle(fontSize: 32.sp,color: Colors.white),),

              ),
            ),
          ),
        ),
      ),
    );
  }

  _buildCompany() {
    return Column(
      children: [
        _titleWidget(
          '发票抬头',
          TextField(
            style: TextStyle(color: Color(0xFF333333)),
            controller: _cName,
            onChanged: (_) => setState(() {}),
            decoration: InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.zero,
              border: InputBorder.none,
              hintText: '填写需要开具发票的企业名称',
              hintStyle: TextStyle(
                fontSize: 28.sp,
                color: Color(0xFF999999),
              ),
            ),
          ),
        ),
        _BuildDivider(),
        _titleWidget(
          '公司税号',
          TextField(
            style: TextStyle(color: Color(0xFF333333)),
            controller: _taxNum,
            onChanged: (_) => setState(() {}),
            decoration: InputDecoration(
              hintText: '请填写纳税人识别号',
              hintStyle: TextStyle(
                color: Color(0xFF999999),
                fontSize: 28.sp,
              ),
              isDense: true,
              contentPadding: EdgeInsets.zero,
              border: InputBorder.none,
            ),
          ),
        ),
        _BuildDivider(),
        _titleWidget(
          '企业地址',
          TextField(
            style: TextStyle(color: Color(0xFF333333)),
            onChanged: (_) => setState(() {}),
            controller: _address,
            decoration: InputDecoration(
              hintText: '请填写公司注册地址',
              hintStyle: TextStyle(
                color: Color(0xFF999999),
                fontSize: 28.sp,
              ),
              isDense: true,
              contentPadding: EdgeInsets.zero,
              border: InputBorder.none,
            ),
          ),
        ),
        _BuildDivider(),
        _titleWidget(
          '企业电话',
          TextField(
            style: TextStyle(color: Color(0xFF333333)),
            controller: _phone,
            onChanged: (_) => setState(() {}),
            decoration: InputDecoration(
              hintText: '请填写公司注册电话',
              hintStyle: TextStyle(
                color: Color(0xFF999999),
                fontSize: 28.sp,
              ),
              isDense: true,
              contentPadding: EdgeInsets.zero,
              border: InputBorder.none,
            ),
          ),
        ),
        _titleWidget(
          '开户银行',
          TextField(
            style: TextStyle(color: Color(0xFF333333)),
            controller: _bankName,
            onChanged: (_) => setState(() {}),
            decoration: InputDecoration(
              hintText: '请填写银行名称',
              hintStyle: TextStyle(
                color: Color(0xFF999999),
                fontSize: 28.sp,
              ),
              isDense: true,
              contentPadding: EdgeInsets.zero,
              border: InputBorder.none,
            ),
          ),
        ),
        _BuildDivider(),
        _titleWidget(
          '银行账号',
          TextField(
            style: TextStyle(color: Color(0xFF333333)),
            controller: _bankNum,
            onChanged: (_) => setState(() {}),
            decoration: InputDecoration(
              hintText: '请填写银行帐号',
              hintStyle: TextStyle(
                color: Color(0xFF999999),
                fontSize: 28.sp,
              ),
              isDense: true,
              contentPadding: EdgeInsets.zero,
              border: InputBorder.none,
            ),
          ),
        )
      ],
    );
  }

  //前端验证
  bool _parseCheck() {
    return _isCompany
        ? (TextUtils.isNotEmpty(_cName.text) &&
            TextUtils.isNotEmpty(_taxNum.text))
        : (TextUtils.isNotEmpty(_pName.text));
  }

  _buildPersonal() {
    return _titleWidget(
      '发票抬头',
      TextField(
        style: TextStyle(color: Color(0xFF333333)),
        controller: _pName,
        onChanged: (text) => setState(() {}),
        decoration: InputDecoration(
          hintText: '填写发票抬头',
          hintStyle: TextStyle(
            color: Color(0xFF999999),
            fontSize: 28.sp,
          ),
          isDense: true,
          contentPadding: EdgeInsets.zero,
          border: InputBorder.none,
        ),
      ),
    );
  }

  _BuildDivider() {
    return Divider(
      height: 1.w,
      thickness: 1.w,
      color: Color(0xFFEEEEEE),
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
