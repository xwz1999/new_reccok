import 'package:new_recook/gen/assets.gen.dart';
import 'package:new_recook/utils/headers.dart';

class NoDataWidget extends StatelessWidget {
  final String text;
  final Widget? icon;
  final double? height;
  const NoDataWidget({Key? key, required this.text, this.icon, this.height = 500,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
      return Container(
        height: this.height,
        width: double.infinity,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            icon ??
                Image.asset(
                  Assets.images.imgNoData.path,
                  width: 260.w,
                  height: 260.w,
                ),
            SizedBox(
              height: 8,
            ),
            Text(
              text,
              style: TextStyle(fontSize: 28.sp,color:Color(0xFFBBBBBB) ),
            ),

          ],
        ),
      );
    }
  }

