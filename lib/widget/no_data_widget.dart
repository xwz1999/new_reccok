import 'package:new_recook/gen/assets.gen.dart';
import 'package:new_recook/utils/headers.dart';

class NoDataWidget extends StatelessWidget {
  final String text;
  final Widget? icon;
  const NoDataWidget({Key? key, required this.text, this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
      return Container(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            icon ??
                Image.asset(
                  Assets.images.nodata.path,
                  width: 160.w,
                  height: 160.w,
                ),
            SizedBox(
              height: 8,
            ),
            Text(
              text,
              style: TextStyle(fontSize: 28.sp,color:Color(0xFF666666) ),
            ),
            SizedBox(
              height: 60.w,
            )
          ],
        ),
      );
    }
  }

