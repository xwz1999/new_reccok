import 'package:common_utils/common_utils.dart';
import 'package:intl/intl.dart';
import 'package:new_recook/gen/assets.gen.dart';
import 'package:new_recook/utils/headers.dart';

class CalendarHeader extends StatelessWidget {
  final DateTime focusedDay;
  final VoidCallback onLeftArrowTap;
  final VoidCallback onRightArrowTap;
  // final VoidCallback onTodayButtonTap;



  const CalendarHeader({
    Key? key,
    required this.focusedDay,
    required this.onLeftArrowTap,
    required this.onRightArrowTap,
    //required this.onTodayButtonTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final headerText = DateUtil.formatDate(focusedDay, format: 'yyyy年MM月');

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          50.wb,
          GestureDetector(
            onTap: onLeftArrowTap,
            child: Container(
                color: Colors.transparent,
                width: 60.w,
                height: 60.w,
                alignment: Alignment.center,
                child: Image.asset(
                  Assets.icons.lastMonthIcon.path,
                  width: 14.w,
                  height: 28.w,
                )),
          ),
          Spacer(),
          SizedBox(

            child: Text(
              headerText,
              style:
              TextStyle(color: Color(0xFF181818), fontSize: 32.sp),
            ),
          ),
          // IconButton(
          //   icon: Icon(Icons.calendar_today, size: 20.0),
          //   visualDensity: VisualDensity.compact,
          //   onPressed: onTodayButtonTap,
          // ),
          Spacer(),

          GestureDetector(
              onTap: onRightArrowTap,
              child: Container(
                  color: Colors.transparent,
                  width: 60.w,
                  height: 60.w,
                  alignment: Alignment.center,
                  child: Image.asset(
                    Assets.icons.nextMonthIcon.path,
                    width: 14.w,
                    height: 28.w,
                  ))),
          50.wb,
        ],
      ),
    );
  }
}