import 'package:flutter/cupertino.dart';
import 'package:new_recook/constants/api.dart';
import 'package:new_recook/constants/styles.dart';
import 'package:new_recook/gen/assets.gen.dart';
import 'package:new_recook/models/goods/goods_model.dart';
import 'package:new_recook/utils/headers.dart';
import 'package:new_recook/widget/button/check_radio.dart';
import 'package:new_recook/widget/no_data_widget.dart';
import 'package:new_recook/widget/recook_scaffold.dart';
import 'package:new_recook/widget/refresh_widget.dart';

class MyCollectionPage extends StatefulWidget {
  const MyCollectionPage({Key? key}) : super(key: key);

  @override
  _MyCollectionPageState createState() => _MyCollectionPageState();
}

class _MyCollectionPageState extends State<MyCollectionPage> {
  bool _editStatus = false;
  bool _onLoad = true;

  GSRefreshController _refreshController =
      GSRefreshController(initialRefresh: true);
  List<GoodsModel> _goodsList = [
    GoodsModel(
        goodsName: '李子园牛奶李子园牛奶李子园牛奶李子园牛奶李子园牛奶',
        saleNum: 100,
        shopName: '蒙牛旗舰店',
        price: '100.5',
        imgPath: '',
        inventory: 200),
    GoodsModel(
        goodsName: '李子园牛奶12',
        saleNum: 2200,
        shopName: '蒙牛旗舰店',
        price: '200.5',
        imgPath: '',
        inventory: 0),
    GoodsModel(
        goodsName: '李子园牛奶22',
        saleNum: 9900,
        shopName: '蒙牛旗舰店',
        price: '300.5',
        imgPath: '',
        inventory: 200),
    GoodsModel(
        goodsName: '李子园牛奶33',
        saleNum: 100,
        shopName: '蒙牛旗舰店',
        price: '100.5',
        imgPath: '',
        inventory: 200),
  ];

  List<GoodsModel> _chooseGoodsList = [];

  List<int> _selectIndex = [];

  bool get _allSelect =>
      _selectIndex.length == _goodsList.length && _selectIndex.length != 0;

  @override
  Widget build(BuildContext context) {
    return RecookScaffold(
        title: '我的收藏',
        body: _goodsList.isNotEmpty
            ? _listWidget()
            : NoDataWidget(
                text: '收藏夹是空的～快去逛逛吧',
                btn: GestureDetector(
                  onTap: () {},
                  child: Container(
                    alignment: Alignment.center,
                    width: 212.w,
                    height: 64.w,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            Color(0xFFE05346),
                            Color(0xFFDB1E1E),
                          ],
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(32.w))),
                    child: Text(
                      '去购物',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28.sp,
                      ),
                    ),
                  ),
                ),
              ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 30.w),
            child: Center(
              child: GestureDetector(
                onTap: () {
                  _editStatus = !_editStatus;
                  setState(() {});
                },
                child: Text(
                  !_editStatus ? '编辑' : '完成',
                  style: TextStyle(
                    color: Color(0xFF666666),
                    fontSize: 28.sp,
                  ),
                ),
              ),
            ),
          )
        ],
        bottomNavi: _editStatus
            ? Container(
                color: Colors.white,
                height: 130.w,
                child: Row(
                  children: [
                    24.wb,
                    GestureDetector(
                      onTap: () {
                        if (_allSelect) {
                          _selectIndex.clear();
                          _chooseGoodsList.clear();
                        } else {
                          _selectIndex.clear();
                          _chooseGoodsList.clear();
                          _chooseGoodsList.addAll(_goodsList);
                          _selectIndex.addAll(List.generate(
                              _goodsList.length, (index) => index));
                        }
                        setState(() {});
                      },
                      child: Container(
                        color: Colors.transparent,
                        padding: EdgeInsets.all(20.w),
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.only(top: 10.w),
                              child: AnimatedContainer(
                                height: 40.w,
                                width: 40.w,
                                decoration: BoxDecoration(
                                  color: themeColor
                                      .withOpacity(_allSelect ? 1 : 0),
                                  border: Border.all(
                                    color: (_allSelect
                                        ? themeColor
                                        : Color(0xFF979797)),
                                    width: 3.w,
                                  ),
                                  borderRadius: BorderRadius.circular(20.w),
                                ),
                                duration: Duration(milliseconds: 300),
                                curve: Curves.easeInOutCubic,
                                alignment: Alignment.center,
                                child: AnimatedOpacity(
                                  duration: Duration(milliseconds: 500),
                                  curve: Curves.easeInOutCubic,
                                  opacity: _allSelect ? 1 : 0,
                                  child: Icon(
                                    CupertinoIcons.checkmark,
                                    color: Colors.white,
                                    size: 28.w,
                                  ),
                                ),
                              ),
                            ),
                            24.wb,
                            Text(
                              '全选',
                              style: TextStyle(
                                color: Color(0xFFC92219),
                                fontSize: 28.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        alignment: Alignment.center,
                        width: 200.w,
                        height: 80.w,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [
                                Color(0xFFE05346),
                                Color(0xFFDB1E1E),
                              ],
                            ),
                            borderRadius:
                                BorderRadius.all(Radius.circular(40.w))),
                        child: Text(
                          '删除',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 28.sp,
                          ),
                        ),
                      ),
                    ),
                    24.wb,
                  ],
                ),
              )
            : SizedBox());
  }

  _listWidget() {
    return Container(
      padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 16.w),
      child: RefreshWidget(
          controller: _refreshController,
          color: AppColor.themeColor,
          onRefresh: () async {
            _onLoad = false;
            setState(() {});
            _refreshController.refreshCompleted();
          },
          onLoadMore: () async {
            _refreshController.loadComplete();
          },
          body: _onLoad ? SizedBox() : _buildList()),
    );
  }

  _buildList() {
    return ListView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.only(
          left: 0, top: 0, right: 0, bottom: ScreenUtil().bottomBarHeight),
      itemBuilder: (_, index) {
        return GestureDetector(
            onTap: () {},
            child: Padding(
              padding: EdgeInsets.only(bottom: 8.w),
              child: _goodsWidget(_goodsList[index], index, _editStatus),
            ));
      },
      itemCount: _goodsList.length,
    );
  }

  _goodsWidget(GoodsModel goodsModel, int index, bool showRadio) {
    return Container(
      height: 272.w,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(16.w)),
      child: Row(
        children: [
          showRadio
              ? GestureDetector(
                  onTap: () {
                    if (_selectIndex.contains(index)) {
                      _selectIndex.remove(index);
                      _chooseGoodsList.remove(goodsModel);
                    } else {
                      _selectIndex.add(index);
                      _chooseGoodsList.add(goodsModel);
                    }
                    setState(() {});
                  },
                  child: Container(
                    color: Colors.transparent,
                    height: double.infinity,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      height: double.infinity,
                      alignment: Alignment.center,
                      child: CheckRadio(
                        value: index,
                        groupValue: _selectIndex,
                      ),
                    ),
                  ),
                )
              : SizedBox(),
          _image(goodsModel),
          Expanded(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  16.hb,
                  Padding(
                    padding: EdgeInsets.only(left: 16.w),
                    child: SizedBox(
                      child: Text(
                        goodsModel.goodsName ?? '',
                        style: TextStyle(
                            fontSize: 32.sp,
                            color: Color(0xFF333333),
                            fontWeight: FontWeight.bold),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  16.hb,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      24.wb,
                      Text.rich(
                        TextSpan(
                          text: '¥',
                          style: TextStyle(
                            color: Color(0xFFC92219),
                            fontSize: 32.sp,
                          ),
                          children: [
                            TextSpan(
                              text: goodsModel.price,
                              style: TextStyle(
                                color: Color(0xFFC92219),
                                fontSize: 48.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  Row(
                    children: [
                      16.wb,
                      Container(
                          alignment: Alignment.center,
                          width: 104.w,
                          height: 40.w,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Color(0xFFAAAAAA), width: 2.w),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.w))),
                          child: Text(
                            '找相似',
                            style: TextStyle(
                              color: Color(0xFF666666),
                              fontSize: 24.sp,
                            ),
                          )),
                      Spacer(),
                      Image.asset(
                        Assets.icons.iconCar.path,
                        width: 50.w,
                        height: 50.w,
                      )
                    ],
                  ),
                  20.hb,
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  _image(GoodsModel goodsModel) {
    bool sellout = false;
    if (goodsModel.inventory! > 0) {
      sellout = false;
    } else {
      sellout = true;
    }
    return Container(
      width: 250.w,
      height: 250.w,
      color: Colors.white,
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(16.w)),
        child: Stack(
          children: [
            Positioned(
                top: 0,
                right: 0,
                left: 0,
                bottom: 0,
                child: FadeInImage.assetNetwork(
                  placeholder: Assets.images.placeholderNew1x1A.path,
                  image: API.getImgUrl(goodsModel.imgPath) ?? '',
                  fit: BoxFit.cover,
                  imageErrorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      Assets.images.placeholderNew1x1A.path,
                      fit: BoxFit.fill,
                    );
                  },
                )),
            Positioned(
              top: 0,
              right: 0,
              left: 0,
              bottom: 0,
              child: Offstage(
                offstage: !sellout,
                child: Opacity(
                  opacity: 0.7,
                  child: Container(
                    color: Color(0x80000000),
                    child: Center(
                      child: Image.asset(
                        Assets.images.selloutBg.path,
                        width: 140.w,
                        height: 140.w,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
