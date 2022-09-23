import 'dart:async';
import 'package:new_recook/constants/styles.dart';
import 'package:new_recook/gen/assets.gen.dart';
// import 'package:new_recook/models/home/promotion_list_model.dart';
import 'package:new_recook/utils/headers.dart';

class HomeCountdownController{
  late Function(int) indexChange;
}

class HomeCountdownWidget extends StatefulWidget {
  final HomeCountdownController? controller;
  final double height;
  final int index;

  HomeCountdownWidget({Key? key, this.height=40, this.index=0, this.controller}) : super(key: key);

  @override
  _HomeCountdownWidgetState createState() => _HomeCountdownWidgetState();
}

class _HomeCountdownWidgetState extends State<HomeCountdownWidget> {

  //活动时间定时器
  Timer? _promotionTimer;
  @override
  void initState() { 
    super.initState();
    widget.controller!.indexChange = (int index){

    };
  }
  @override
  void dispose() {
    if (_promotionTimer != null) {
      _promotionTimer!.cancel();
      _promotionTimer = null;
    }
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Container(

      color: AppColor.frenchColor,
      margin: EdgeInsets.only(top: 20.w), height: widget.height,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
            Image.asset(Assets.home.homeListTimes1.path, width: 230.w, height: 60.w),
          // Spacer(),
          // widget.promotionList!=null&&widget.promotionList.length>0?_rightWidget():Container(),
        ],
      ),
    );
  }

}
