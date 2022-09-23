import 'dart:async';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:new_recook/constants/api.dart';
import 'package:new_recook/gen/assets.gen.dart';
import 'package:new_recook/pages/splash/webView.dart';
import 'package:new_recook/utils/alert.dart';
import 'package:new_recook/utils/headers.dart';
import 'package:new_recook/utils/text_utils.dart';
import 'package:new_recook/widget/recook_scaffold.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isLogin = true;
  bool _chooseAgreement = false;
  TextEditingController? _phoneController = TextEditingController();
  TextEditingController? _smsCodeController = TextEditingController();
  FocusNode? _phoneNode = FocusNode();
  FocusNode? _smsCodeNode = FocusNode();
  bool _getCodeEnable = false;
  bool _cantSelected = false;
  bool _loginEnable = false;
  String _errorMsg = "";
  Timer? _timer;
  String _countDownStr = "获取验证码";
  int _countDownNum = 59;

  @override
  void dispose() {
    _phoneController?.dispose();
    _smsCodeController?.dispose();
    _phoneNode?.dispose();
    _smsCodeNode?.dispose();
    if (_timer != null) {
      _timer!.cancel();
      _timer = null;
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RecookScaffold(
      bodyColor: Colors.white,
      title: '',
      body: Column(
        children: [
          100.hb,
          Container(
            width: 140.w,
            height: 140.w,
            alignment: Alignment.center,
            constraints: BoxConstraints(
              maxWidth: 140.w
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20.w),
                  child: Image.asset(Assets.icons.appIcon.path,fit: BoxFit.cover,),
                ),
              ],
            ),
          ),
          60.hb,
          isLogin
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _getPhoneString('15938758940'),
                      style: TextStyle(
                          fontSize: 32.sp,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF111111)),
                    ),
                    32.wb,
                    GestureDetector(
                      onTap: () {
                        isLogin = false;
                        setState(() {});
                      },
                      child: Text(
                        '更换',
                        style: TextStyle(
                            fontSize: 24.sp, color: Color(0xFF666666)),
                      ),
                    ),
                  ],
                )
              : Column(
                  children: [
                    _phoneText(),
                    _smsCode(),
                  ],
                ),
          Spacer(),
          _buildPhoneLogin(),
          30.hb,
          GestureDetector(
            onTap: () {
              _chooseAgreement = !_chooseAgreement;
              setState(() {});
            },
            child: Row(
              //mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    width: 50.w,
                    height: 50.w,
                    padding: EdgeInsets.only(top: 6.w, right: 5.w),
                    child: !_chooseAgreement
                        ? Icon(CupertinoIcons.circle,
                            size: 18, color: Color(0xFFdddddd))
                        : Icon(CupertinoIcons.checkmark_circle,
                            size: 18, color: Colors.red)),
                RichText(
                    text: TextSpan(
                        text: "您已阅读并同意",
                        style: TextStyle(
                            color: Color(0xFF666666), fontSize: 12 * 2.sp),
                        children: [
                      new TextSpan(
                          text: '《用户服务协议》',
                          style: new TextStyle(
                              color: Color(0xFFD5101A), fontSize: 12 * 2.sp),
                          recognizer: _recognizer(context, 2)),
                      TextSpan(
                        text: "和",
                        style: TextStyle(
                            color: Color(0xFF666666), fontSize: 12 * 2.sp),
                      ),
                      new TextSpan(
                          text: '《用户隐私政策》',
                          style: new TextStyle(
                              color: Color(0xFFD5101A), fontSize: 12 * 2.sp),
                          recognizer: _recognizer(context, 1)),
                    ])),
              ],
            ),
          ),
          50.hb,
        ],
      ),
    );
  }

  _beginCountDown() {
    setState(() {
      _getCodeEnable = false;
      _countDownStr = "重新获取($_countDownNum)";
    });
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_timer == null || !mounted) {
        return;
      }
      setState(() {
        if (_countDownNum == 0) {
          _countDownNum = 59;
          _countDownStr = "获取验证码";
          _getCodeEnable = true;
          _timer!.cancel();
          _timer = null;
          return;
        }
        _countDownStr = "重新获取(${_countDownNum--})";
      });
    });
  }

  Container _phoneText() {
    return Container(
      margin:
      EdgeInsets.only(top: 20.w, right: 40.w, left: 40.w),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[500]!, width: 1.w),
          borderRadius: BorderRadius.all(Radius.circular(6.w))),
      child: TextField(
        controller: _phoneController,
        focusNode: _phoneNode,
        keyboardType: TextInputType.number,
        style: TextStyle(color: Colors.black, fontSize: 16 * 2.sp),
        inputFormatters: [
          LengthLimitingTextInputFormatter(11),
        ],
        cursorColor: Colors.black,
        onChanged: (String phone) {
          setState(() {
            if (phone.length >= 11) {
              _getCodeEnable = true;
              _loginEnable = _verifyLoginEnable();
            } else {
              _errorMsg = "";
              _getCodeEnable = false;
              _loginEnable = false;
            }
          });
        },
        decoration: InputDecoration(
            contentPadding: EdgeInsets.only(
                left: 20.w,
                top: 26.w,
                bottom: _phoneNode!.hasFocus ? 0 : 28.w),
            border: InputBorder.none,
            hintText: "请输入手机号",
            hintStyle: TextStyle(color: Colors.grey[400], fontSize: 15 * 2.sp),
            suffixIcon: _clearButton(_phoneController, _phoneNode!)),
      ),
    );
  }

  IconButton? _clearButton(TextEditingController? controller, FocusNode node) {
    return node.hasFocus
        ? IconButton(
        padding: EdgeInsets.zero,
        icon: Icon(
          CupertinoIcons.clear,
          size: 17 * 2.sp,
          color: Colors.grey[300],
        ),
        onPressed: () {
          controller!.clear();
        })
        : null;
  }

  /// 验证码
  Container _smsCode() {
    return Container(
      margin:
      EdgeInsets.only(top: 20.w, right:40.w, left: 40.w),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[500]!, width: 0.5),
          borderRadius: BorderRadius.all(Radius.circular(3))),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              inputFormatters: [
                LengthLimitingTextInputFormatter(4),
              ],
              onChanged: (text) {
                setState(() {
                  _loginEnable = _verifyLoginEnable();
                });
              },
              controller: _smsCodeController,
              focusNode: _smsCodeNode,
              keyboardType: TextInputType.number,
              style: TextStyle(color: Colors.black, fontSize: 16 * 2.sp),
              cursorColor: Colors.black,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(
                      left: 20.w,
                      top: 26.w,
                      bottom: _smsCodeNode!.hasFocus ? 0 : 28.w),
                  border: InputBorder.none,
                  hintText: "请输入验证码",
                  hintStyle:
                  TextStyle(color: Colors.grey[400], fontSize: 14 * 2.sp),
                  suffixIcon: _clearButton(_smsCodeController, _smsCodeNode!)),
            ),
          ),

          GestureDetector(
            onTap: () {
              if (_chooseAgreement) {
                if (!TextUtils.verifyPhone(_phoneController!.text)) {
                  BotToast.showText(text: '手机号码格式不正确!');
                  return;
                }
                if (_cantSelected) return;
                _cantSelected = true;
                Future.delayed(Duration(seconds: 2), () {
                  _cantSelected = false;
                });
                _getSmsCode();
              } else {
                Alert.show(
                    context,
                    NormalContentDialog(
                      type: NormalTextDialogType.remind,
                      title: null,
                      content: Text(
                        '请您先阅读并同意《用户协议》和《隐私政策》',
                        style: TextStyle(color: Colors.black),
                      ),
                      items: ["确认"],
                      listener: (index) {
                        Alert.dismiss(context);
                      },
                    ));
              }
            },
            child: Container(
              alignment: Alignment.center,
              width: 240.w,
              decoration: BoxDecoration(
                border: Border(left: BorderSide(color: Colors.grey[500]!)),
              ),
              child: Text(_countDownStr,style: TextStyle(color: Color(0xFFAAAAAA),fontSize: 25.sp),),
            ),
          )

          // TButton.TextButton(
          //   title: _countDownStr,
          //   width: rSize(120),
          //   textColor: Colors.grey[700],
          //   enable: _getCodeEnable,
          //   font: 15 * 2.sp,
          //   unableTextColor: Colors.grey[400],
          //   highlightTextColor: Colors.grey[400],
          //   border: Border(left: BorderSide(color: Colors.grey[500]!)),
          //   onTap: () {
          //     if (_chooseAgreement) {
          //       if (!TextUtils.verifyPhone(_phoneController!.text)) {
          //         Toast.showError("手机号码格式不正确!");
          //         return;
          //       }
          //       if (_cantSelected) return;
          //       _cantSelected = true;
          //       Future.delayed(Duration(seconds: 2), () {
          //         _cantSelected = false;
          //       });
          //
          //       _getSmsCode();
          //     } else {
          //       Alert.show(
          //           context,
          //           NormalContentDialog(
          //             type: NormalTextDialogType.remind,
          //             title: null,
          //             content: Text(
          //               '请您先阅读并同意《用户协议》和《隐私政策》',
          //               style: TextStyle(color: Colors.black),
          //             ),
          //             items: ["确认"],
          //             listener: (index) {
          //               Alert.dismiss(context);
          //             },
          //           ));
          //     }
          //   },
          // ),
        ],
      ),
    );
  }


  _getSmsCode() {
    _beginCountDown();
    BotToast.showText(text: '验证码发送成功，请注意查收');
  }

  _verifyLoginEnable() {
    if (!TextUtils.verifyPhone(_phoneController!.text)) {
      setState(() {
        _errorMsg = "手机号格式不正确,请检查";
      });
      return false;
    }
    return _smsCodeController!.text.length == 4;
  }

  Container _buildPhoneLogin() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 40.w),
      height:80.w,
      decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Color(0xFFE05346),
              Color(0xFFDB1E1E),
            ],
          ),
          borderRadius: BorderRadius.all(Radius.circular(40.w))),
      child: MaterialButton(
        onPressed: () {
          if (_chooseAgreement) {

          } else {
            Alert.show(
                context,
                NormalContentDialog(
                  type: NormalTextDialogType.remind,
                  title: null,
                  content: Text(
                    '请您先阅读并同意《用户协议》和《隐私政策》',
                    style: TextStyle(color: Colors.black),
                  ),
                  items: ["确认"],
                  listener: (index) {
                    Alert.dismiss(context);
                  },
                ));
          }
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "本机号码登录",
              style:TextStyle(fontSize: 32.sp, color: Colors.white),
            )
          ],
        ),
      ),
    );
  }


  _getPhoneString(String phone) {
    String phoneString = '';
    if (phone.isNotEmpty) {
      phoneString = phone.substring(0, 3) + '****' + phone.substring(7, 11);
    } else {}
    return phoneString;
  }

  _recognizer(context, int type) {
    final TapGestureRecognizer recognizer = new TapGestureRecognizer();
    recognizer.onTap = () {
      print("点击协议了");
      Get.to(() => WebViewPage(
            url: type == 1 ? API.webAPI.webPrivacy : API.webAPI.webAgreement,
          ));
    };
    return recognizer;
  }
}
