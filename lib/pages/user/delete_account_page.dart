import 'package:new_recook/utils/alert.dart';
import 'package:new_recook/widget/recook_scaffold.dart';

import '../../utils/headers.dart';

class DeleteAccountPage extends StatefulWidget {
  const DeleteAccountPage({Key? key}) : super(key: key);

  @override
  _DeleteAccountPageState createState() => _DeleteAccountPageState();
}

class _DeleteAccountPageState extends State<DeleteAccountPage> {
  final deleteInfo = [
    '您的账户无法登录与使用',
    '身份、账户信息、会员权益将被清空且无法恢复',
    '您已完成的交易将无法处理售后',
    '您将无法便捷地查询帐号历史交易记录',
  ];

  @override
  Widget build(BuildContext context) {
    return RecookScaffold(
      bodyColor: Colors.white,
      title: '注销账号',
      body: _bodyWidget(),

    );
  }

  _bodyWidget() {
    return Column(
      children: [
        Expanded(
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.all(16.w),
            children: [
              Text(
                '请注意，一旦注销账户：',
                style: TextStyle(
                  color: Color(0xFF333333),
                  fontSize: 40.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 30.w),
              ...deleteInfo.map((e) => _buildChildTile(e)),
            ],
          ),
        ),
        Container(
          color: Colors.white,

          padding: EdgeInsets.all(16.w),
          child: Row(
            children: [
              Expanded(
                  child: GestureDetector(
                    onTap: (){
                      Get.back();
                    },
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40.w),
                          color: Color(0xFFF0F0F0)),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 20.w,
                        ),
                        child: Text('不注销了',
                            style:
                            TextStyle(color: Color(0xFF666666), fontSize: 32.sp)),
                      ),
                    ),
                  )),
              20.wb,
              Expanded(
                  child: GestureDetector(
                    onTap: (){
                      Alert.show(
                          context,
                          NormalTextDialog(
                            title: '注销提示',
                            type: NormalTextDialogType.delete,
                            content: '确定注销账号？',
                            items: ["取消"],
                            listener: (index) {
                              Alert.dismiss(context);
                            },
                            deleteItem: "确定",
                            deleteListener: () async {
                              Alert.dismiss(context);

                            },
                          ));
                    },
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40.w),
                          color: Color(0xFFDB1E1E)),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 20.w,
                        ),
                        child: Text('确认注销',
                            style: TextStyle(color: Colors.white, fontSize: 32.sp)),
                      ),
                    ),
                  )),
            ],
          ),
        ),
        50.hb,
      ],
    );
  }

  _buildChildTile(String title) {
    return Container(
      child: Row(
        children: [
          Container(
            width: 16.w,
            height: 16.w,
            margin: EdgeInsets.only(right: 20.w),
            decoration: BoxDecoration(
              color: Color(0xFFE2E2E2),
              borderRadius: BorderRadius.circular(8.w),
            ),
          ),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 28.sp,
                color: Color(0xFF333333),
              ),
            ),
          ),
        ],
      ),
      margin: EdgeInsets.only(bottom: 40.w),
    );
  }
}
