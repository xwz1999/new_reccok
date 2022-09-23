import 'package:azlistview/azlistview.dart';
import 'package:flutter/cupertino.dart';
import 'package:lpinyin/lpinyin.dart';
import 'package:new_recook/constants/styles.dart';
import 'package:new_recook/gen/assets.gen.dart';
import 'package:new_recook/utils/headers.dart';
import 'package:new_recook/utils/text_utils.dart';
import 'package:new_recook/widget/no_data_widget.dart';
import 'package:new_recook/widget/recook_back_button.dart';
import 'package:new_recook/widget/weather/models.dart';
import 'package:new_recook/widget/weather/weather_city_model.dart';
import 'package:new_recook/widget/weather/weather_city_tool.dart';


class WeatherCityPage extends StatefulWidget {
  final String? cityName;

  WeatherCityPage({Key? key, this.cityName}) : super(key: key);

  @override
  _WeatherCityPageState createState() => _WeatherCityPageState();
}

class _WeatherCityPageState extends State<WeatherCityPage> {
  int _suspensionHeight = 40;
  int _itemHeight = 50;
  // String _suspensionTag = "A";
  List<WeatherCityModel> _cityList = [];
  String? _selectCity = "";
  List<WeatherCityModel> _searchResultCityList = [];
  TextEditingController? _textEditingController;
  FocusNode _focusNode = FocusNode();
  List<CityModel> _list = [];


  @override
  void initState() {
    _textEditingController = TextEditingController();
    _focusNode.addListener(() {
      setState(() {});
    });

    if (!TextUtils.isEmpty(widget.cityName)) _selectCity = widget.cityName;
    WeatherCityTool.getInstance()!.getCityList().then((onValue) {
      _cityList = onValue;

      _cityList.forEach((element) {
        _list.add(CityModel(name:element.cityZh,namePinyin: element.namePinyin));
      });

      _handleList(_list);
      setState(() {});
    });



    super.initState();
  }

  void _handleList(List<CityModel> list) {
    if (list.isEmpty) return;
    for (int i = 0, length = list.length; i < length; i++) {
      String pinyin = PinyinHelper.getPinyinE(list[i].name!);
      String tag = pinyin.substring(0, 1).toUpperCase();
      list[i].namePinyin = pinyin;
      if (RegExp('[A-Z]').hasMatch(tag)) {
        list[i].tagIndex = tag;
      } else {
        list[i].tagIndex = '#';
      }
    }
    // A-Z sort.
    SuspensionUtil.sortListBySuspensionTag(list);

    // add hotCityList.

    // show sus tag.
    SuspensionUtil.setShowSuspensionStatus(_list);

    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: RecookBackButton(),
        backgroundColor:  Colors.white,
        title: Text('选择城市',style: TextStyle(color: Color(0xFF333333),fontSize: 30.sp),),
        elevation: 0,
      ),
      body: Container(
        color: Colors.white,
        // color: AppColor.frenchColor,
        child: Column(
          children: <Widget>[
            _searchBar(),
            _focusNode.hasFocus ||
                    !TextUtils.isEmpty(_textEditingController!.text)
                ? Expanded(child: _resultWidget())
                : Expanded(
                    child: Column(
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            if (TextUtils.isEmpty(_selectCity)) return;

                            WeatherCityModel model = WeatherCityModel();
                            model.cityZh = _selectCity;
                            Get.back(result: model);
                            //Navigator.pop(context, model);
                          },
                          child: Container(
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.only(left: 15.0),
                            height: 50.0,
                            child: Text(
                              "当前定位城市: $_selectCity",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 14),
                            ),
                          ),
                        ),
                        Expanded(
                          child: AzListView(

                            data: _list,
                            itemCount: _list.length,
                            itemBuilder: (context, index) =>
                                _buildListItem(_cityList[index]),

                            padding: EdgeInsets.zero,
                            susItemBuilder: (BuildContext context, int index) {
                              CityModel model = _list[index];
                              String tag = model.getSuspensionTag();
                              return getSusItem(context, tag);
                            },
                            // suspensionWidget: _buildSusWidget(_suspensionTag),
                            // isUseRealIndex: true,
                            // itemHeight: _itemHeight,
                            // suspensionHeight: _suspensionHeight,
                            // onSusTagChanged: (tag) {
                            //   setState(() {
                            //     _suspensionTag = tag;
                            //   });
                            // },
                          ),
                        )
                      ],
                    ),
                  )
          ],
        ),
      ),
    );
  }


   Widget getSusItem(BuildContext context, String tag,
      {double susHeight = 40}) {
    if (tag == '★') {
      tag = '★ 热门城市';
    }
    return Container(
      height: susHeight,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.only(left: 16.0),
      color: Color(0xFFF3F4F5),
      alignment: Alignment.centerLeft,
      child: Text(
        '$tag',
        softWrap: false,
        style: TextStyle(
          fontSize: 14.0,
          color: Color(0xFF666666),
        ),
      ),
    );
  }

  ///构建列表 item Widget.
  Widget _buildListItem(WeatherCityModel model) {
    return Column(
      children: <Widget>[
        Offstage(
          offstage: !(model.isShowSuspension == true),
          child: _buildSusWidget(model.getSuspensionTag()),
        ),
        SizedBox(
          height: _itemHeight.toDouble(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  Navigator.pop(context, model);
                },
                child: Container(
                  color: Colors.white,
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: 15),
                  height: _itemHeight.toDouble() - 1,
                  child: Text(
                    model.cityZh!,
                    style: TextStyle(color: Colors.black, fontSize: 15 * 2.sp),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  left: 15,
                ),
                color: AppColor.frenchColor,
                height: 1,
              )
            ],
          ),
        ),
      ],
    );
  }

  ///构建悬停Widget.
  Widget _buildSusWidget(String susTag) {
    return Container(
      height: _suspensionHeight.toDouble(),
      padding: const EdgeInsets.only(left: 15.0),
      color: Color(0xfff3f4f5),
      alignment: Alignment.centerLeft,
      child: Text(
        '$susTag',
        softWrap: false,
        style: TextStyle(
          fontSize: 14.0,
          color: Color(0xff999999),
        ),
      ),
    );
  }

  _searchBar() {
    return Container(
      height: 45,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: Container(
        decoration: BoxDecoration(
            color: Color(0xfff3f4f5), borderRadius: BorderRadius.circular(5)),
        child: Row(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 10),
              child: Image.asset(
               Assets.icons.search.path,
                width: 22,
                height: 22,
              ),
            ),
            Expanded(
              child: CupertinoTextField(
                decoration: BoxDecoration(color: Colors.white.withAlpha(0)),
                controller: _textEditingController,
                focusNode: _focusNode,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.search,
                placeholder: "请输入搜索词...",
                placeholderStyle: TextStyle(
                    color: Color(0xff999999),
                    fontSize: 14,
                    fontWeight: FontWeight.w300),
                onSubmitted: (text) {
                  // WeatherCityTool.getInstance().searchWithQuery(text, (list){
                  //   _searchResultCityList = list;
                  //   setState(() {});
                  // });
                },
                onChanged: (text) {
                  WeatherCityTool.getInstance()!.searchWithQuery(text, (list) {
                    _searchResultCityList = list;
                    setState(() {});
                  });
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  _resultWidget() {
    return Container(
      child: _searchResultCityList.length <= 0
          ? GestureDetector(
              onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
              child: NoDataWidget(text: '没有找到数据...',),
            )
          : ListView.builder(
              itemCount: _searchResultCityList.length,
              itemBuilder: (BuildContext context, int index) {
                return _buildListItem(_searchResultCityList[index]);
              },
            ),
    );
  }


}
