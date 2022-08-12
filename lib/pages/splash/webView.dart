import 'dart:convert';


import 'package:flutter/cupertino.dart';
import 'package:new_recook/utils/headers.dart';
import 'package:webview_flutter/webview_flutter.dart';



class WebViewPage extends StatefulWidget {
  final String? url;
  final String? title;

  const WebViewPage({Key? key, this.url, this.title,});


  @override
  State<WebViewPage> createState() {
    return _WebViewState();
  }
}

class _WebViewState extends State<WebViewPage> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    // if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  @override
  void dispose() {
    super.dispose();

  }

  JavascriptChannel _alertJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
        name: 'recook',
        onMessageReceived: (JavascriptMessage message) {
          if (message.message.isNotEmpty) {
            Map map = jsonDecode(message.message);
            //{"method":"method_name","data":{"goods_id":10}}
            if (map.containsKey("method") && map["method"] == "detail") {
              if (map.containsKey("data")) {
                Map subMap = map["data"];
                if (subMap.containsKey("goods_id") &&
                    subMap["goods_id"] != null) {
                  //跳转详情页面

                }
              }
            }
          }
        });
  }

  @override
  // Widget build(BuildContext context) {
  Widget build(BuildContext context, {store}) {
    return Scaffold(
      // appBar: AppBar(
      //         title: Text(widget.title??''),
      //  ),
      body: SafeArea(
        top: true,
        bottom: false,
        child: Stack(
          children: <Widget>[
            WebView(
              javascriptMode: JavascriptMode.unrestricted,
              javascriptChannels: <JavascriptChannel>[
                _alertJavascriptChannel(context),
              ].toSet(),
              initialUrl: widget.url,
              onWebViewCreated: (WebViewController web) {
                web.canGoBack().then((res) {
                  print(res); // 是否能返回上一级
                });
                web.currentUrl().then((url) {
                  print(url); // 返回当前url
                });
                web.canGoForward().then((res) {
                  print(res); //是否能前进
                });
              },
              onPageFinished: (String value) {
                setState(() {
                  _isLoading = false;
                });
              },
            ),
            _loading(),
              Positioned(
                    top: ScreenUtil().statusBarHeight,
                    left: 30.w,
                    width: 60.w,
                    height: 60.w,
                    child: GestureDetector(
                      child: Container(
                        width: 60.w,
                        height: 60.w,

                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(40.w)),
                          color: Color.fromARGB(100, 0, 0, 0),
                        ),
                        child: Icon(
                          CupertinoIcons.back,
                        size: 40.w,
                        color: Colors.white,
                      ),
                      ),
                      onTap: (){
                        Navigator.maybePop(context);
                      },
                    )

                    // child: Container(),
                  ),
          ],
        ),
      ),
    );

  }

  _loading() {
    return _isLoading == true
        ? Container(
            decoration: BoxDecoration(color: Colors.white),
            child: Center(
              child: CircularProgressIndicator(
                valueColor:
                    new AlwaysStoppedAnimation<Color>(themeColor),
                strokeWidth: 1.0,
              ),
            ),
          )
        : Text('');
  }
}
