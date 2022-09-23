import 'package:bot_toast/bot_toast.dart';
import 'package:new_recook/pages/user/delete_account_page.dart';
import 'package:new_recook/utils/alert.dart';
import 'package:new_recook/utils/cache_util.dart';
import 'package:new_recook/widget/recook_scaffold.dart';

import '../../utils/headers.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  int size = 0;
  String get sizeString => (size / 1048576).toStringAsFixed(2);

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      size = await CacheUtil.total();
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return RecookScaffold(
      title: '设置',
      bodyColor: Color(0xFFF6F6F6),
      body: _listView(),
    );
  }

  _listView() {
    return ListView(
      children: [
        16.hb,
        _normalTile("接受推送通知", needDivide: false, value: '已开启', listener: () {}),
        _normalTile("清除缓存", needDivide: false, value: '${sizeString}MB',
            listener: () {
          Alert.show(
              context,
              NormalTextDialog(
                title: '清除缓存',
                type: NormalTextDialogType.delete,
                content: '确定清除本地缓存',
                items: ["取消"],
                listener: (index) {
                  Alert.dismiss(context);
                },
                deleteItem: "确定",
                deleteListener: () async {
                  Alert.dismiss(context);
                  _clearCache();
                },
              ));
        }),
        16.hb,
        _normalTile("注销账号", needDivide: false, value: '已开启', listener: () {
          Get.to(()=>DeleteAccountPage());
        }),
        _normalTile("隐私政策", needDivide: false, value: '已开启', listener: () {}),
        _normalTile("联系我们",
            needDivide: false, value: '400-861-0321', listener: () {}),
        20.hb,
        GestureDetector(
          onTap: () {},
          child: Container(
            height: 80.w,
            color: Colors.white,
            width: double.infinity,
            alignment: Alignment.center,
            child: Text(
              '退出登陆',
              style: TextStyle(
                  fontSize: 28.sp,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF333333)),
            ),
          ),
        )
      ],
    );
  }

  _normalTile(String title,
      {VoidCallback? listener,
      String? value,
      Color backgroundColor = Colors.white,
      EdgeInsets padding =
          const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      EdgeInsets margin = const EdgeInsets.all(0),
      EdgeInsets divideMargin = const EdgeInsets.only(left: 10),
      Widget? trailing,
      bool needDivide = false,
      bool needArrow = true}) {
    return Container(
      margin: margin,
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: listener,
            child: Container(
              color: backgroundColor,
              padding: padding,
              child: Row(
                children: <Widget>[
                  Container(
                      width: 320.w,
                      child: Text(
                        title,
                        style: TextStyle(fontSize: 30.sp),
                      )),
                  Spacer(),
                  trailing ??
                      (value == null
                          ? Container()
                          : Text(
                              value,
                              textAlign: TextAlign.end,
                              maxLines: 1,
                              style: TextStyle(fontSize: 28.sp),
                            )),
                  SizedBox(
                    width: 10.w,
                  ),
                  Offstage(
                      offstage: !needArrow,
                      child: Icon(
                        Icons.keyboard_arrow_right,
                        size: 40.sp,
                        color: Colors.grey,
                      ))
                ],
              ),
            ),
          ),
          Offstage(
            offstage: !needDivide,
            child: Container(
              margin: divideMargin,
              color: Colors.grey[300],
              height: 0.8 * 2.w,
            ),
          )
        ],
      ),
    );
  }

  _clearCache() async {
    if (size <= 0) {
      BotToast.showText(text: '没有缓存可清理');
      return;
    }
    ;
    await CacheUtil.clear();
    BotToast.showText(text: '清除成功');
    await CacheUtil.total().then((value) {
      size = value;
      setState(() {});
    });
  }
}
