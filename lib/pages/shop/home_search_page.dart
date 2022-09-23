import 'package:flutter/cupertino.dart';
import 'package:new_recook/constants/styles.dart';
import 'package:new_recook/gen/assets.gen.dart';
import 'package:new_recook/models/goods/goods_item_grind_widget.dart';
import 'package:new_recook/models/goods/goods_item_widget.dart';
import 'package:new_recook/models/goods/goods_model.dart';
import 'package:new_recook/utils/headers.dart';
import 'package:new_recook/utils/hive_store.dart';
import 'package:new_recook/utils/text_utils.dart';
import 'package:new_recook/widget/button/text_button.dart';
import 'package:new_recook/widget/custom_floating_action_button_location.dart';
import 'package:new_recook/widget/goods_sort_widget.dart';
import 'package:new_recook/widget/no_data_widget.dart';
import 'package:new_recook/widget/recook_back_button.dart';
import 'package:new_recook/widget/refresh_widget.dart';
import 'package:waterfall_flow/waterfall_flow.dart';
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
  bool _displayList = false;//默认排列方式改为瀑布流
  List _recommendWords = [];//推荐分词
  bool _onLoad = true;
  List<GoodsModel> goodsList = [

  ];
  GSRefreshController _refreshController =
  GSRefreshController(initialRefresh: true);

  List<GoodsModel> likeGoodsList = [
    GoodsModel(goodsName: '李子园牛奶李子园牛奶李子园牛奶李子园牛奶李子园牛奶',saleNum: 100,shopName: '蒙牛旗舰店',price: '100.5',imgPath: '',inventory: 200),
    GoodsModel(goodsName: '李子园牛奶12',saleNum: 2200,shopName: '蒙牛旗舰店',price: '200.5',imgPath: '',inventory: 200),
    GoodsModel(goodsName: '李子园牛奶22',saleNum: 9900,shopName: '蒙牛旗舰店',price: '300.5',imgPath: '',inventory: 200),
    GoodsModel(goodsName: '李子园牛奶33',saleNum: 100,shopName: '蒙牛旗舰店',price: '100.5',imgPath: '',inventory: 200),
    GoodsModel(goodsName: '李子园牛奶44',saleNum: 100,shopName: '蒙牛旗舰店',price: '100.5',imgPath: '',inventory: 200),
  ];
  @override
  void initState() {
    super.initState();

    getSearchListFromSharedPreferences();
  }


  @override
  void dispose() {
    super.dispose();
    _refreshController.dispose();
  }

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
            Positioned(child: Column(
              children: [
                GoodsSortWidget(onTap: (OrderType type) {  },trialing: _displayIcon(),),
                Offstage(
                    offstage: !(goodsList.length==0),
                    child: Container(
                      color: Colors.white,
                      child: Container(
                          padding: EdgeInsets.only(top: 10.w),
                          child: Column(
                            children: <Widget>[
                              _recommendWidget(),
                            ],
                          )),
                    )),
                Expanded(child: _searchList()),
              ],
            )),


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
                              _hotGoods(),
                            ],
                          )),
                    ))),
          ],
        ),
      ),
    );
  }


  _searchList(){
    return RefreshWidget(
      controller: _refreshController,
      color: AppColor.themeColor,
      onRefresh: () async {
        _refreshController.refreshCompleted();
        goodsList = [
          GoodsModel(goodsName: '李子园牛奶李子园牛奶李子园牛奶李子园牛奶李子园牛奶',saleNum: 100,shopName: '蒙牛旗舰店',price: '100.5',imgPath: '',inventory: 200),
          GoodsModel(goodsName: '李子园牛奶12',saleNum: 2200,shopName: '蒙牛旗舰店',price: '200.5',imgPath: '',inventory: 0),
          GoodsModel(goodsName: '李子园牛奶22',saleNum: 9900,shopName: '蒙牛旗舰店',price: '300.5',imgPath: '',inventory: 200),
          GoodsModel(goodsName: '李子园牛奶33',saleNum: 100,shopName: '蒙牛旗舰店',price: '100.5',imgPath: '',inventory: 200),
          GoodsModel(goodsName: '李子园牛奶44',saleNum: 100,shopName: '蒙牛旗舰店',price: '100.5',imgPath: '',inventory: 200),
        ];
        _onLoad = false;
        setState(() {});
      },
      onLoadMore: () async {
        _refreshController.loadComplete();
      },
      body:  _onLoad?SizedBox():Padding(padding: EdgeInsets.only(top: 10.w,left: 16.w,right: 16.w),child:_buildList() ,)
    );
  }

  _buildList(){
    return CustomScrollView(
      controller: _scrollController,
      slivers: [
        goodsList.isNotEmpty?SliverWaterfallFlow(
          delegate: SliverChildBuilderDelegate(
                (context, index) {
              return GestureDetector(

                  onTap: () {
                      ///前往商品详情页面
                  },
                  child: _displayList
                      ? GoodsItemWidget(goodsModel: goodsList[index],)
                      : GoodsItemGrindWidget(goodsModel: goodsList[index],));
            },
            childCount: goodsList.length,
          ),
          gridDelegate: SliverWaterfallFlowDelegateWithFixedCrossAxisCount(
            crossAxisCount: _displayList ? 1 : 2,
            crossAxisSpacing: _displayList ? 5 : 10,
            mainAxisSpacing: _displayList ? 5 : 10,
          ),
          // ItemTagWidget.getSliverGridDelegate(_displayList, context),
        ):SliverToBoxAdapter(child: NoDataWidget(text: '换个关键词搜索一下吧～',height: 800.w,)),
        // SliverToBoxAdapter(
        //   child:  goodsList.isEmpty
        //       ? Padding(
        //     padding: EdgeInsets.only(top: 80.w, bottom: 20.w),
        //     child: Row(
        //       mainAxisAlignment: MainAxisAlignment.center,
        //       children: [
        //         Container(
        //           height: 4.w,
        //           color: Color(0xFFB8B8B8),
        //           width: 80.w,
        //         ),
        //        20.hb,
        //         Text(
        //           '猜你喜欢',
        //           style: TextStyle(
        //             fontSize:30.sp,
        //             fontWeight: FontWeight.bold,
        //             color: Colors.black87,
        //           ),
        //         ),
        //        20.hb,
        //         Container(
        //           height:4.w,
        //           color: Color(0xFFB8B8B8),
        //           width: 80.w,
        //         ),
        //       ],
        //     ),
        //   )
        //       : SizedBox(),
        // ),
        // SliverToBoxAdapter(
        //     child: goodsList.isEmpty&&likeGoodsList.isNotEmpty
        //         ? ListView.builder(
        //       shrinkWrap: true,
        //       physics: NeverScrollableScrollPhysics(),
        //       itemBuilder: (context, index) {
        //         return Container(
        //           padding: EdgeInsets.only(bottom: 5),
        //           color: AppColor.frenchColor,
        //             child: GoodsItemWidget(goodsModel: likeGoodsList[index],)
        //
        //         );
        //       },
        //       itemCount: likeGoodsList.length,
        //     )
        //         : SizedBox()),
      ],
    );
  }


   _displayIcon() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      color: Colors.transparent,
      child: GestureDetector(
        onTap: () {
          setState(() {
            _displayList = !_displayList;
          });
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 1.w,
              height: 45.w,
              margin: EdgeInsets.only(right: 15.w),
              color: Color(0xFF333333),
            ),
            Text(
              "排列",
              style:TextStyle(
                fontSize: 28.sp,color:  Color(0xFF333333),
              )
            ),
            Padding(
              padding: EdgeInsets.only(left: 10.w,top: 5.w),
              child: Image.asset( _displayList
                  ?Assets.icons.iconChangeList.path
                  : Assets.icons.iconChangeGrid.path,width: 25.w,height: 25.w,)

            ),
          ],
        ),
      ),
    );
  }

  _keyWordsTitle(){
    return Container(
        child: Container(
          margin: EdgeInsets.only(left: 20.w, top: 10.w,right: 20.w),
          child:
          Text(
            '没找到相关宝贝，试试',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500,
              fontSize: 14 * 2.sp,
            ),
          ),
        ));
  }

  _recommendWidget() {
    List<Widget> keyWordList = [];
    if (_recommendWords.length > 0) {
      for (int i=0;i<_recommendWords.length;i++) {
        keyWordList.add(Padding(
          padding: EdgeInsets.only(right: 10, bottom: 5),
          child: ChoiceChip(
            backgroundColor: AppColor.frenchColor,
            // disabledColor: Colors.blue,
            labelStyle: TextStyle(fontSize: 15 * 2.sp, color: Colors.black),
            labelPadding: EdgeInsets.only(left: 20, right: 20),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            onSelected: (bool value) async {
              _searchText = _recommendWords[i].token??'';
              _textEditController!.text = _recommendWords[i].token!;
              FocusManager.instance.primaryFocus!.unfocus();
              //_callRefresh();
              setState(() {});
            },
            label: Text(_recommendWords[i].token!),
            selected: false,
          ),
        ));
      }
      keyWordList.insert(0, _keyWordsTitle());
    }



    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Wrap(
              children: keyWordList,
            ),
          ),
          // Spacer()
        ],
      ),
    );
  }

  _hotGoods(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:  EdgeInsets.only(left: 20.w,top: 20.w),
          child: Text(
            '热门商品',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500,
              fontSize: 16 * 2.sp,
            ),
          ),
        ),
        20.hb,
        GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            itemCount: 6,
            //SliverGridDelegateWithFixedCrossAxisCount 构建一个横轴固定数量Widget
            gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(
              //横轴元素个数
                crossAxisCount: 2,
                //纵轴间距
                mainAxisSpacing: 6,
                //横轴间距
                crossAxisSpacing: 6,
                //子组件宽高长度比例
                childAspectRatio: 165 /48 ),
            itemBuilder: (BuildContext context, int index) {
              return Row(
                children: [
                  Container(color: Colors.red,width: 96.w,height: 96.w,),
                  10.wb,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '雪仑尔长绒棉浴巾',
                        style: TextStyle(
                          color: Color(0xFF111111),

                          fontSize: 20.sp,
                        ),
                      ),
                      Spacer(),
                      Text.rich( TextSpan(
                        text: '¥',
                        style: TextStyle(
                          color: Color(0xFFC92219),
                          fontSize: 20.sp,
                        ),
                      children: [
                        TextSpan(
                          text:
                          '299',
                          style: TextStyle(
                            color: Color(0xFFC92219),
                            fontSize: 28.sp,
                          ),
                        ),
                      ]
                      ),)

                    ],
                  )
                ],


              );
            }
            ),
      ],
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
        if(choiceChipList.length==10){
          choiceChipList.insert(0,Padding(
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
          choiceChipList.insert(0,Padding(
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
                      '历史搜索',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 16 * 2.sp,
                      ),
                    ),
                    Spacer(),
                    (_searchHistory.length > 0)
                        ? GestureDetector(
                      onTap: () {
                        _searchHistory = [];
                        saveSearchListToSharedPreferences(
                            _searchHistory);
                        setState(() {});
                      },
                      child: Image.asset(
                        Assets.icons.delete.path,
                        width: 40.w,
                        height: 40.w,
                      ),
                    )
                        : Container(),
                    36.wb,
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
    print(_searchText);
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


  getSearchListFromSharedPreferences() async {


    var history = HiveStore.appBox.get(
         "userSearhHistory");
    if (history != null) {
      _searchHistory = (history as List).cast<String>().toList();
    }
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
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: TextReButton(
            onPressed: () {
              if (TextUtils.isEmpty(_searchText)) return;
              _startSearch = true;
              _contentFocusNode.unfocus();
              _searchText = _searchText.trimLeft();
              _searchText = _searchText.trimRight();
              remember();
              saveSearchListToSharedPreferences(_searchHistory);

              setState(() {});
            },
            text: "搜索",
            style: TextStyle(
                color: TextUtils.isEmpty(_searchText)
                    ? Colors.grey
                    : Colors.black,
                fontSize: 30.sp),
          ))
    ];
  }
}
