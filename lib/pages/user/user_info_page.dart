import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:new_recook/constants/api.dart';
import 'package:new_recook/constants/styles.dart';
import 'package:new_recook/gen/assets.gen.dart';
import 'package:new_recook/utils/headers.dart';
import 'package:new_recook/widget/action_sheet.dart';
import 'package:new_recook/widget/recook_scaffold.dart';


class UserInfoPage extends StatefulWidget {
  const UserInfoPage({Key? key}) : super(key: key);

  @override
  _UserInfoPageState createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage> {
  @override
  Widget build(BuildContext context) {
    return RecookScaffold(
      title: '个人信息',
      bodyColor: Color(0xFFF6F6F6),
      body: _listView(),

    );
  }
  _listView(){
    return ListView(
      children: [
        _normalTile("头像",
            margin: EdgeInsets.symmetric(vertical: 20.w),
            trailing:
            ClipRRect(
              borderRadius: BorderRadius.circular(50.w),
              child: FadeInImage.assetNetwork(
                height: 100.w,
                width: 100.w,
                placeholder: Assets.icons.appIcon.path,
                imageErrorBuilder: (context, error, stackTrace) {
                  return Image.asset(Assets.icons.appIcon.path,height: 100.w,
                    width: 100.w,);
                },
                image:  API.getImgUrl(
                   '')!,
              ),
            ),
            listener: () {

            }),
        _normalTile("昵称",
            value: '瑞库客',
            needDivide: false, listener: () {
            }),

        _normalTile(
          "用户ID",
          value: '321123123',
          needDivide: false,
          listener: null,

        ),
        _normalTile("性别", value: '男', needDivide: false, listener: () {
          ActionSheet.show(context, items: ["男", "女"],
              listener: (int index) {

              });
        }),
        _normalTile("生日",
            value:  "未选择",

            needDivide: false, listener: () {
              DateTime currentTime = DateTime.now();
              // if (!TextUtils.isEmpty(UserManager.instance!.user.info!.birthday)) {
              //   //String birthday = UserManager.instance!.user.info!.birthday!;
              //   currentTime = DateTime(
              //       int.parse(birthday.substring(0, 4)),
              //       int.parse(birthday.substring(5, 7)),
              //       int.parse(birthday.substring(8, 10)));
              // }

              DatePicker.showDatePicker(context,
                  showTitleActions: true,
                  theme: DatePickerTheme(
                      cancelStyle:
                      TextStyle(fontSize: 15 * 2.sp, color: Colors.grey),
                      doneStyle: TextStyle(fontSize:15 * 2.sp,
                          color: AppColor.themeColor),
                      itemStyle: TextStyle(fontSize:15 * 2.sp)),
                  minTime: DateTime(1970, 01, 01),
                  maxTime: DateTime.now(),
                  currentTime: currentTime,
                  locale: LocaleType.zh, onConfirm: (DateTime date) {
                    //String time = date.toString().split("-").join("");

                  });
            }),
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
                      width:320.w,
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
}
