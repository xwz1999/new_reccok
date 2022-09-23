import 'package:new_recook/utils/headers.dart';
import 'package:new_recook/widget/recook_scaffold.dart';

class InvoiceDetailMorePage extends StatefulWidget {
  final TextEditingController address;
  final TextEditingController telephone;
  final TextEditingController bankNum;
  final TextEditingController message;
  InvoiceDetailMorePage({
    Key? key,
    required this.address,
    required this.telephone,
    required this.bankNum,
    required this.message,
  }) : super(key: key);

  @override
  _InvoiceDetailMorePageState createState() => _InvoiceDetailMorePageState();
}

class _InvoiceDetailMorePageState extends State<InvoiceDetailMorePage> {
  int _addressMax = 0;
  int _messageMax = 0;
  @override
  Widget build(BuildContext context) {
    return RecookScaffold(
      title: '',
      body: ListView(
        children: [
          16.hb,
          Container(
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
               24.hb,
                Row(
                  children: [
                    32.wb,
                    Text(
                      '公司地址',
                      style: TextStyle(
                        color: Color(0xFF333333),
                        fontSize:32.sp,
                      ),
                    ),
                    Spacer(),
                    Text(
                      '$_addressMax/50',
                      style: TextStyle(
                        color: Color(0xFF999999),
                        fontSize: 28.sp,
                      ),
                    ),
                    32.wb,
                  ],
                ),
                TextField(
                  controller: widget.address,
                  onChanged: (text) {
                    setState(() {
                      _addressMax = text.length;
                    });
                  },
                  style: TextStyle(
                    color: Color(0xFF333333),
                  ),
                  minLines: 3,
                  maxLines: 3,
                  maxLength: 50,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 32.w,
                      vertical:24.w,
                    ),
                    hintText: '填写公司地址',
                    hintStyle: TextStyle(
                      color: Color(0xFF999999),
                      fontSize: 28.sp,
                    ),
                    border: InputBorder.none,
                  ),
                ),
                Divider(color: Color(0xFF666666)),
                Row(
                  children: [
                    32.wb,
                    Text(
                      '公司电话',
                      style: TextStyle(
                        color: Color(0xFF333333),
                        fontSize: 32.sp
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        style: TextStyle(
                          color: Color(0xFF333333),
                        ),
                        controller: widget.telephone,
                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 24.w,
                            horizontal: 32.w
                          ),
                          border: InputBorder.none,
                          hintText: '填写公司电话',
                          hintStyle: TextStyle(
                            color: Color(0xFF999999),
                            fontSize: 28.sp
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
         16.hb,
          Container(
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Row(
                  children: [
                    32.wb,
                    Text(
                      '开户行帐号',
                      style: TextStyle(
                        color: Color(0xFF333333),
                        fontSize: 32.sp
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        style: TextStyle(
                          color: Color(0xFF333333),
                        ),
                        controller: widget.bankNum,
                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 24.w,
                            horizontal:32.w
                          ),
                          border: InputBorder.none,
                          hintText: '填写开户行帐号',
                          hintStyle: TextStyle(
                            color: Color(0xFF999999),
                            fontSize: 28.sp
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    32.wb,
                    Text(
                      '银行账号    ',
                      style: TextStyle(
                          color: Color(0xFF333333),
                          fontSize: 32.sp
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        style: TextStyle(
                          color: Color(0xFF333333),
                        ),
                        controller: widget.bankNum,
                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 24.w,
                              horizontal:32.w
                          ),
                          border: InputBorder.none,
                          hintText: '填写开户行名称',
                          hintStyle: TextStyle(
                              color: Color(0xFF999999),
                              fontSize: 28.sp
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          16.hb,
          Container(
            color: Colors.white,
            child: Row(
              children: [
                SizedBox(
                  width: 32.w,
                  height: 64.w
                ),
                Text(
                  '备注',
                  style: TextStyle(
                    color: Color(0xFF333333),
                    fontSize:32.sp
                  ),
                ),
               20.wb,
                Text(
                  '该内容将会打印在发票上',
                  style: TextStyle(
                    color: Color(0xFF999999),
                    fontSize:28.sp
                  ),
                ),
                Spacer(),
                Text(
                  '$_messageMax/80',
                  style: TextStyle(
                    color: Color(0xFF999999),
                    fontSize: 28.sp
                  ),
                ),
               32.wb,
              ],
            ),
          ),
          Container(
            color: Colors.white,
            child: TextField(
              controller: widget.message,
              onChanged: (text) {
                setState(() {
                  _messageMax = text.length;
                });
              },
              style: TextStyle(
                color: Color(0xFF333333),
              ),
              minLines: 3,
              maxLines: 3,
              maxLength: 80,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  horizontal:32.w,
                  vertical: 24.w
                ),
                hintText: '按企业报销要求填写，如下单时间，下单原因',
                hintStyle: TextStyle(
                  color: Color(0xFF999999),
                  fontSize:28.sp
                ),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
