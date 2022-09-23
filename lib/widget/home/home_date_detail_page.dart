import 'package:common_utils/common_utils.dart';
import 'package:new_recook/models/home/home_weather_model.dart';
import 'package:new_recook/pages/shop/calendar/calendar.dart';
import 'package:new_recook/pages/shop/home_func.dart';
import 'package:new_recook/utils/headers.dart';
// import 'package:new_recook/widget/home/holiday_calendar_model.dart';
import 'package:new_recook/models/home/wannianli_model.dart';
import 'package:new_recook/widget/recook_back_button.dart';

class HomeDateDetailPage extends StatefulWidget {
  final HomeWeatherModel? homeWeatherModel;

  HomeDateDetailPage({
    Key? key,
    this.homeWeatherModel,
  }) : super(key: key);

  @override
  _HomeDateDetailPageState createState() => _HomeDateDetailPageState();
}

class _HomeDateDetailPageState extends State<HomeDateDetailPage> {

  // HolidayCalendarModel? _holidayCalendarModel;

  WanNianLiModel? wanNianLiModel;


  final DateTime dateNow = DateTime.now();

  String _holiday = '';
  String _workday = '';

  @override
  void initState() {
    super.initState();
    DateTime dateNow = DateTime.now();

    _getPerpetual(DateUtil.formatDate(dateNow, format: 'yyyy-MM-dd'));

    _getholiday(dateNow.year.toString());
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFF8F8),
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: RecookBackButton(
          white: false,
          onTap: () {
            Navigator.pop(context);
          },
        ),
        elevation: 0,
        title: Text(
          "日历",
          style: TextStyle(
            color: Color(0xFF333333),
            fontSize: 36.sp,
          ),
        ),
      ),
      body: Container(
        child: _holiday != '' ? _bodyWidget() : SizedBox(),
      ),
    );
  }

  _bodyWidget() {
    return ListView(
      children: [
        _dateWidget(),
        wanNianLiModel != null ? _nongli() : SizedBox(),
      ],
    );
  }

  _dateWidget() {
    return Calendar(holiday: _holiday,workDay: _workday,);
  }

  _nongli() {
    return Container(
      width: double.infinity,
      //color: Color(0xFFFFF8F8),
      child: Column(
        children: [
          40.hb,
          Row(
            children: [
              40.wb,
              Text(
                '农历' + (wanNianLiModel!.lunar ?? ""),
                style: TextStyle(color: Color(0xFF181818), fontSize: 32.sp),
              ),
              Spacer(),
              Text(
                (wanNianLiModel!.lunarYear ?? ""),
                style: TextStyle(color: Color(0xFF181818), fontSize: 32.sp),
              ),
              40.wb
            ],
          ),
          20.hb,
          Row(
            children: [
              40.wb,
              Text(
                (wanNianLiModel!.holiday ?? ""),
                style: TextStyle(color: Color(0xFF181818), fontSize: 32.sp),
              ),
              Spacer(),
            ],
          ),
          40.hb,
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              40.wb,
              Column(
                children: [
                  8.hb,
                  Container(
                      width: 60.w,
                      height: 60.w,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Color(0xFF007AFF),
                          borderRadius: BorderRadius.all(Radius.circular(8.w))),
                      child: Text(
                        '宜',
                        style: TextStyle(
                            height: 1.1,
                            color: Colors.white,
                            fontSize: 40.sp,
                            fontWeight: FontWeight.bold),
                      )),
                ],
              ),
              40.wb,
              Container(
                child: Text((wanNianLiModel!.suit ?? ""),
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                    style:
                        TextStyle(color: Color(0xFF333333), fontSize: 28.sp)),
              ).expand(),
              100.wb
            ],
          ),
          40.hb,
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              40.wb,
              Column(
                children: [
                  8.hb,
                  Container(
                      width: 60.w,
                      height: 60.w,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Color(0xFFCE4242),
                          borderRadius: BorderRadius.all(Radius.circular(8.w))),
                      child: Text(
                        '忌',
                        style: TextStyle(
                            height: 1.1,
                            color: Colors.white,
                            fontSize: 40.sp,
                            fontWeight: FontWeight.bold),
                      )),
                ],
              ),
              40.wb,
              Container(
                child: Text((wanNianLiModel!.avoid ?? ""),
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                    style:
                        TextStyle(color: Color(0xFF333333), fontSize: 28.sp)),
              ).expand(),
              100.wb
            ],
          ),
        ],
      ),
    );
  }

  _getPerpetual(String time) async {
    wanNianLiModel = await HomeFunc.getWanNianLiModel(time);
    setState(() {});
  }

  _getholiday(String time) async {
    // String url =
    //     "http://api.tianapi.com/txapi/jiejiari/index?key=f2599751017c50b91d6f31261ce6dbc0&date=$time&type=1";
    //
    // Response res = (await (HttpManager.netFetchNormal(url, null, null, null)))!;
    // Map map = json.decode(res.data.toString());
    // _holidayCalendarModel =  await LifeFunc.getHoliday(time);
    //
    // _holidayCalendarModel = HolidayCalendarModel.fromJson(map as Map<String, dynamic>);
    // print(_holidayCalendarModel);
    //
    // for (int i = 0; i < _holidayCalendarModel!.data!.length; i++) {
    //   if (_holiday.isNotEmpty)
    //     _holiday += _holidayCalendarModel!.data![i].vacation! + '|';
    //   else
    //     _holiday += _holidayCalendarModel!.data![i].vacation!;
    //   if (_workday.isNotEmpty)
    //     _workday += _holidayCalendarModel!.data![i].remark! + '|';
    //   else
    //     _workday += _holidayCalendarModel!.data![i].vacation!;
    // }
    _workday =
        '2022-01-29|2022-01-30|2022-04-02|2022-04-24|2022-05-07|2022-10-08|2022-10-09|';
    _holiday =
        '2022-01-01|2022-01-02|2022-01-03|2022-01-31|2022-02-01|2022-02-02|2022-02-03|2022-02-04|'
            '2022-02-05|2022-02-06|2022-04-03|2022-04-04|2022-04-05|2022-04-30|2022-05-01|'
            '2022-05-02|2022-05-03|2022-05-04|2022-06-03|2022-06-04|2022-06-05|2022-09-10|'
            '2022-09-11|2022-09-12|2022-10-01|2022-10-02|2022-10-03|2022-10-04|2022-10-05|2022-10-06|2022-10-07|';
    // print(_holiday);
    // print(_workday);
    setState(() {});
  }


}
