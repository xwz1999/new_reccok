import 'package:common_utils/common_utils.dart';
import 'package:new_recook/pages/shop/calendar/calendar_header.dart';
import 'package:new_recook/utils/headers.dart';
import 'package:new_recook/widget/calendar/holiday_util.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatefulWidget {
  final String holiday;
  final String workDay;
  const Calendar({Key? key, required this.holiday, required this.workDay}) : super(key: key);

  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  late final PageController _pageController;
  final ValueNotifier<DateTime> _focusedDay = ValueNotifier(DateTime.now());
  DateTime? _selectedDay;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  String _workday =
  '';
  String _holiday =
  '';
  HolidayUtil holidayUtil = HolidayUtil();

  @override
  void initState() {
    super.initState();
    _workday = widget.workDay;
    _holiday = widget.holiday;
  }

  @override
  Widget build(BuildContext context) {
    return       Container(
      color: Colors.white,
      child: Column(
          children: [
            ValueListenableBuilder<DateTime>(
              valueListenable: _focusedDay,
              builder: (context, value, _) {
                return CalendarHeader(
                  focusedDay: value,
                  // onTodayButtonTap: () {
                  //   setState(() => _focusedDay.value = DateTime.now());
                  // },
                  onLeftArrowTap: () {
                    _pageController.previousPage(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeOut,
                    );
                  },
                  onRightArrowTap: () {
                    _pageController.nextPage(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeOut,
                    );

                  },
                );
              },
            ),
            Container(

              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: TableCalendar(
                locale: 'zh_CN',
                firstDay: DateTime.utc(2010, 10, 16),
                lastDay: DateTime.utc(2030, 3, 14),
                focusedDay: _focusedDay.value,
                calendarFormat: _calendarFormat,
                headerVisible: false,
                rowHeight:120.w,
                holidayPredicate: (day) => _getHolidays(day),
                selectedDayPredicate: (day) => isSameDay(_selectedDay,day),
                onPageChanged: (focusedDay) => _focusedDay.value = focusedDay,
                onCalendarCreated: (controller) => _pageController = controller,
                onDaySelected: (selectedDay, focusedDay) {
                  if (!isSameDay(_selectedDay, selectedDay)) {
                    // Call `setState()` when updating the selected day
                    setState(() {
                      _selectedDay = selectedDay;
                      _focusedDay.value = focusedDay;
                    });
                  }
                },
                startingDayOfWeek: StartingDayOfWeek.monday,
                daysOfWeekHeight: 30,

                calendarBuilders: CalendarBuilders(

                  outsideBuilder: (context, date, events) => Opacity(
                    opacity: 0.3,
                    child: Container(
                        margin: const EdgeInsets.all(4.0),
                        alignment: Alignment.center,

                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.w)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              date.day.toString(),
                              style: TextStyle(color: Color(0xFF333333),fontSize: 25.sp),
                            ),
                            10.hb,
                            Text(
                              holidayUtil.getHoliday(date.year, date.month, date.day)??'',
                              style: TextStyle(color: Color(0xFF333333),fontSize: 25.sp),
                            ),
                          ],
                        )),
                  ),
                  defaultBuilder: (context, date, events) =>
                  _getWorkdays(date)?Stack(
                    children: [

                      Container(
                          margin: const EdgeInsets.all(4.0),

                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Color(0xFF999999).withOpacity(0.2),
                              borderRadius: BorderRadius.circular(10.w)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                date.day.toString(),
                                style: TextStyle(color: Color(0xFF333333),fontSize: 25.sp),
                              ),
                              10.hb,
                              Text(
                                holidayUtil.getHoliday(date.year, date.month, date.day)??'',
                                style: TextStyle(color:holidayUtil.isHoliday(date.year, date.month, date.day)? Color(0xFFDB2D2D): Color(0xFF333333),fontSize: 25.sp),
                              ),
                            ],
                          )),
                      Positioned(  top: 10.w,
                          right:12.w ,child: Text('班',style: TextStyle(color: Color(0xFF999999),fontSize: 20.sp),)),
                    ],
                  ):
                      Container(
                      margin: const EdgeInsets.all(4.0),
                      alignment: Alignment.center,

                      decoration: BoxDecoration(
                          color: _getWorkdays(date)?Color(0xFF999999).withOpacity(0.2): Colors.white,
                          borderRadius: BorderRadius.circular(10.w)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            date.day.toString(),
                            style: TextStyle(color: Color(0xFF333333),fontSize: 25.sp),
                          ),
                          10.hb,
                          Text(
                            holidayUtil.getHoliday(date.year, date.month, date.day)??'',
                            style: TextStyle(color:holidayUtil.isHoliday(date.year, date.month, date.day)? Color(0xFFDB2D2D): Color(0xFF333333),fontSize: 25.sp),
                          ),
                        ],
                      )
                  ),
                  holidayBuilder: (context, date, events) => Opacity(
                    opacity: date.month!=events.month? 0.3:1,
                    child: Stack(
                      children: [

                        Container(
                            margin: const EdgeInsets.all(4.0),

                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Color(0xFFFFD3D3),
                                borderRadius: BorderRadius.circular(10.w)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  date.day.toString(),
                                  style: TextStyle(color: Color(0xFFDB2D2D),fontSize: 25.sp),
                                ),
                                10.hb,
                                Text(
                                  holidayUtil.getHoliday(date.year, date.month, date.day)??'',
                                  style: TextStyle(color: Color(0xFFDB2D2D),fontSize: 25.sp),
                                ),
                              ],
                            )),
                        Positioned(  top: 10.w,
                            right:12.w ,child: Text('休',style: TextStyle(color: Color(0xFFDB2D2D),fontSize: 20.sp),)),
                      ],
                    ),
                  ),
                  todayBuilder: (context, date, events) => Container(
                      margin: const EdgeInsets.all(4.0),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          border: Border.all(color: Color(0xFFDB2D2D),width: 2.w),
                          borderRadius: BorderRadius.circular(10.w)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            date.day.toString(),
                            style: TextStyle(color: Color(0xFF333333),fontSize: 25.sp),
                          ),
                          10.hb,
                          Text(
                            holidayUtil.getHoliday(date.year, date.month, date.day)??'',
                            style: TextStyle(color:holidayUtil.isHoliday(date.year, date.month, date.day)? Color(0xFFDB2D2D): Color(0xFF333333),fontSize: 25.sp),
                          ),
                        ],
                      )
                  ),
                  selectedBuilder: (context, date, events) => Container(
                      margin: const EdgeInsets.all(4.0),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          border: Border.all(color: Color(0xFF007BFF),width: 2.w),
                          borderRadius: BorderRadius.circular(10.w)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            date.day.toString(),
                            style: TextStyle(color: Color(0xFF333333),fontSize: 25.sp),
                          ),
                          10.hb,
                          Text(
                            holidayUtil.getHoliday(date.year, date.month, date.day)??'',
                            style: TextStyle(color:holidayUtil.isHoliday(date.year, date.month, date.day)? Color(0xFFDB2D2D): Color(0xFF333333),fontSize: 25.sp),
                          ),
                        ],
                      )
                  ),

                ),


              ),
            ),
          ],

      ),
    );

  }

  _getHolidays(DateTime day){
    if( _holiday.contains(DateUtil.formatDate(day, format: 'yyyy-MM-dd'))){
      return true;
    }else{
      return false;
    }

  }

  _getWorkdays(DateTime day){
    if( _workday.contains(DateUtil.formatDate(day, format: 'yyyy-MM-dd'))){
      return true;
    }else{
      return false;
    }

  }
}
