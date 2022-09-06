import 'package:flutter/cupertino.dart';
import 'package:new_recook/constants/styles.dart';
import 'package:new_recook/utils/hive_store.dart';
import 'package:new_recook/utils/text_utils.dart';
import 'package:new_recook/widget/custom_floating_action_button_location.dart';
import 'package:new_recook/widget/recook_back_button.dart';

import '../../gen/assets.gen.dart';
import '../../utils/headers.dart';

class HomeSearchPage extends StatefulWidget {
  const HomeSearchPage({Key? key}) : super(key: key);

  @override
  _HomeSearchPageState createState() => _HomeSearchPageState();
}

class _HomeSearchPageState extends State<HomeSearchPage> {
  String _searchText = "";
  FocusNode _contentFocusNode = FocusNode();
  ScrollController _scrollController = ScrollController();
  TextEditingController? _textEditController = TextEditingController();
  bool _startSearch = false;
  bool showFab = false;
  List<String> _searchHistory = [];
  List<String> _hotSearch = ['行李111箱','收纳222盒','美莲333宝','U33333盘','净333水器','粉底333液','bb霜','小米','123','222','333','4444'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.frenchColor,
      floatingActionButton:  !TextUtils.isEmpty(_textEditController!.text) &&
          _startSearch? showFab? _customer():SizedBox():SizedBox(),
      floatingActionButtonLocation:CustomFloatingActionButtonLocation(FloatingActionButtonLocation.endDocked, 0, -140.w),
      appBar: AppBar(
        title: _buildTitle(),
        titleSpacing: 0,
        backgroundColor: Color(0xFFFBFBFB),
        leading:  RecookBackButton(),
        actions: _rightActions(),
        //centerTitle: true,
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Stack(
          children: <Widget>[
            Positioned(
                child: Offstage(
                    offstage: !TextUtils.isEmpty(_textEditController!.text) &&
                        _startSearch,
                    child: Container(
                      color: Colors.white,
                      child: Container(
                          child: ListView(
                            children: <Widget>[
                              _searchHistory.isNotEmpty?
                              _searchHistoryWidget():SizedBox(),
                              10.hb,
                              _hotSearchWidget(),
                            ],
                          )),
                    ))),
          ],
        ),
      ),
    );
  }


  _hotSearchWidget() {
    List<Widget> choiceChipList = [];
    if (_hotSearch.isNotEmpty && _hotSearch.length > 0) {
      for (var text in _hotSearch) {
        if(choiceChipList.length==10){
          choiceChipList.removeAt(9);

          choiceChipList.insert(0,
              Padding(
                padding: EdgeInsets.only(right: 15.w, bottom: 10.w,left: 15.w),
                child: ChoiceChip(
                  backgroundColor:Color(0xFFF6F6F6),
                  // disabledColor: Colors.blue,
                  labelStyle: TextStyle(fontSize: 15 * 2.sp, color: Colors.black),
                  labelPadding: EdgeInsets.only(left: 16.w, right: 16.w),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  onSelected: (bool value) async {
                    _searchText = text;
                    _textEditController!.text = text;
                    FocusManager.instance.primaryFocus!.unfocus();

                    setState(() {});
                  },
                  label: Text(text,style: TextStyle(color: Color(0xD9111111),fontSize: 20.sp),),
                  selected: false,
                ),
              ));
        }else{

          choiceChipList.insert(0,
              Padding(
                padding: EdgeInsets.only(right: 15.w, bottom: 10.w,left: 15.w),
                child: ChoiceChip(
                  backgroundColor:Color(0xFFF6F6F6),
                  // disabledColor: Colors.blue,
                  labelStyle: TextStyle(fontSize: 15 * 2.sp, color: Colors.black),
                  labelPadding: EdgeInsets.only(left: 16.w, right: 16.w),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  onSelected: (bool value) async {
                    _searchText = text;
                    _textEditController!.text = text;
                    FocusManager.instance.primaryFocus!.unfocus();

                    setState(() {});
                  },
                  label: Text(text,style: TextStyle(color: Color(0xD9111111),fontSize: 20.sp),),
                  selected: false,
                ),
              ));
          print(choiceChipList);
        }

      }
    }

    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Container(
                margin: EdgeInsets.only(left: 20.w, top: 10.w, bottom: 20.w),
                child: Row(
                  children: <Widget>[
                    Text(
                      '热门搜索',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 16 * 2.sp,
                      ),
                    ),
                    Spacer()
                  ],
                )),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(left: 10.w, right: 10.w),
            child: Wrap(
              children: choiceChipList,
            ),
          ),
          // Spacer()
        ],
      ),
    );
  }

  _searchHistoryWidget() {
    List<Widget> choiceChipList = [];
    if (_searchHistory.isNotEmpty && _searchHistory.length > 0) {
      for (var text in _searchHistory) {
        choiceChipList.add(Padding(
          padding: EdgeInsets.only(right: 10, bottom: 5),
          child: ChoiceChip(
            backgroundColor: AppColor.frenchColor,
            // disabledColor: Colors.blue,
            labelStyle: TextStyle(fontSize: 15 * 2.sp, color: Colors.black),
            labelPadding: EdgeInsets.only(left: 20, right: 20),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            onSelected: (bool value) async {
              _searchText = text;
              _textEditController!.text = text;
              FocusManager.instance.primaryFocus!.unfocus();

              setState(() {});
            },
            label: Text(text),
            selected: false,
          ),
        ));
      }
    }

    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Container(
                margin: EdgeInsets.only(left: 15, top: 15, bottom: 5),
                child: Row(
                  children: <Widget>[
                    Text(
                      '历史搜索',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 16 * 2.sp,
                      ),
                    ),
                    Spacer()
                  ],
                )),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Wrap(
              children: choiceChipList,
            ),
          ),
          // Spacer()
        ],
      ),
    );
  }

  _customer(){
    return GestureDetector(
      onTap: () async{
        // if(_listViewController!.getData().length>4)
          _scrollController.jumpTo(0);
      },
      child: Container(
        width: 92.w,
        height: 92.w,
        decoration: BoxDecoration(
          color: Color(0xFF000000).withOpacity(0.7),
          borderRadius: BorderRadius.all(Radius.circular(46.w)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(Assets.icons.totop.path,width: 60.w,height: 60.w,color: Colors.white,),
          ],
        ),
      ),
    );
  }


  Widget _buildTitle() {
    return Container(
        height: 80.w,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(40.w),
            boxShadow: [
              BoxShadow(
                color: Color(0xFFDBDBDB),
                blurRadius: 2,
                offset: Offset(0, 1),
              ),
            ]
        ),
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Icon(
                Icons.search,
                size: 40.w,
                color: Colors.grey,
              ),
            ),
            Expanded(
              child: CupertinoTextField(

                autofocus: true,
                keyboardType: TextInputType.text,
                controller: _textEditController,
                textInputAction: TextInputAction.search,
                onSubmitted: (_submitted) async {
                  if (TextUtils.isEmpty(_searchText)) return;
                  _startSearch = true;
                  _contentFocusNode.unfocus();
                  _searchText = _searchText.trimLeft();
                  _searchText = _searchText.trimRight();
                  remember();
                  saveSearchListToSharedPreferences(_searchHistory);

                  setState(() {});
                },
                focusNode: _contentFocusNode,
                onChanged: (text) {
                  _startSearch = false;
                  _searchText = text;
                  setState(() {

                  });
                },
                placeholder: "请输入想要搜索的内容...",
                placeholderStyle: TextStyle(
                    color: Colors.grey.shade500,
                    fontSize: 28.sp,
                    fontWeight: FontWeight.w300),
                decoration: BoxDecoration(color: Colors.white.withAlpha(0)),
                style: TextStyle(
                    color: Colors.black,
                    textBaseline: TextBaseline.ideographic),
              ),
            )
          ],
        ));
  }


  ///保存搜索记录
  remember() {
    if (_searchHistory.contains(_searchText)) {
      _searchHistory.remove(_searchText);
      List<String> list = [_searchText];
      list.addAll(_searchHistory);
      _searchHistory = list;
    } else {
      List<String> list = [_searchText];
      list.addAll(_searchHistory);
      _searchHistory = list;
      while (_searchHistory.length > 15) {
        _searchHistory.removeLast();
      }
    }
    saveSearchListToSharedPreferences(_searchHistory);
    setState(() {});
  }

  ///保存搜索记录
  saveSearchListToSharedPreferences(List<String> value) async {

    HiveStore.appBox.put(
         "userSearhHistory",
        value);
  }

  List<Widget> _rightActions() {
    return <Widget>[
      Container(

          child: TextButton(
            onPressed: () {
              if (TextUtils.isEmpty(_searchText)) return;
              _contentFocusNode.unfocus();
            },
            child: Text(
              "搜索",
              style: TextStyle(
                  color: TextUtils.isEmpty(_searchText)
                      ? Colors.grey
                      : Colors.black,
                  fontSize: 30.sp),
            ),
          ))
    ];
  }
}
