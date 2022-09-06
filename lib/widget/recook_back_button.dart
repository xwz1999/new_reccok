import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_recook/constants/styles.dart';


class RecookBackButton extends StatelessWidget {
  final bool? white;
  final bool? text;
  final VoidCallback? onTap;
  const RecookBackButton(
      {Key? key, this.white = false, this.text = false, this.onTap})
      : super(key: key);

  const RecookBackButton.text(
      {Key? key, this.white = false, this.text = true, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (Navigator.canPop(context)) {
      return text??false
          ? MaterialButton(
              minWidth:106.w,
              padding: EdgeInsets.zero,
              child: Text(
                '取消',
                overflow: TextOverflow.visible,
                style: TextStyle(
                  fontSize: 28.sp,
                  color: white??false ? Colors.white : Color(0xFF333333),
                ),
              ),
              onPressed: () {
                onTap == null ? Navigator.maybePop(context) : onTap!();
              },
            )
          : IconButton(
              icon: Icon(
                CupertinoIcons.chevron_back,
                color: white??false ? Colors.white : AppColor.blackColor,
              ),
              onPressed: () {
                onTap == null ? Navigator.maybePop(context) : onTap!();
              });
    } else
      return SizedBox();
  }
}
