import 'package:new_recook/constants/styles.dart';
import 'package:new_recook/gen/assets.gen.dart';
import 'package:new_recook/models/goods/goods_item_widget.dart';
import 'package:new_recook/models/goods/goods_model.dart';
import 'package:new_recook/utils/headers.dart';
import 'package:new_recook/widget/recook_scaffold.dart';
import 'package:new_recook/widget/refresh_widget.dart';



class ActivityGoodsPage extends StatefulWidget {
  final int type;

  ///type=1 热销 type=2 特惠
  const ActivityGoodsPage({Key? key, required this.type}) : super(key: key);

  @override
  _ActivityGoodsPageState createState() => _ActivityGoodsPageState();
}

class _ActivityGoodsPageState extends State<ActivityGoodsPage> {
  bool _onLoad = true;
  GSRefreshController _refreshController =
  GSRefreshController(initialRefresh: true);
  List<GoodsModel> goodsList = [

  ];


  @override
  void dispose() {
    super.dispose();
    _refreshController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RecookScaffold(
      bodyColor: Color(0xFFF6F6F6),
      title: widget.type==1?'热销榜单':'特惠专区',
      body: _goodList(),
    );
  }

  _goodList(){
    return Container(
      margin: EdgeInsets.only(left:16.w, right: 16.w, top: 16.w),
      child: RefreshWidget(
          controller: _refreshController,
          color: AppColor.themeColor,
          onRefresh: () async {
            goodsList = [
              GoodsModel(goodsName: '李子园牛奶李子园牛奶李子园牛奶李子园牛奶李子园牛奶',saleNum: 100,shopName: '蒙牛旗舰店',price: '100.5',imgPath: '',inventory: 200),
              GoodsModel(goodsName: '李子园牛奶12',saleNum: 2200,shopName: '蒙牛旗舰店',price: '200.5',imgPath: '',inventory: 0),
              GoodsModel(goodsName: '李子园牛奶22',saleNum: 9900,shopName: '蒙牛旗舰店',price: '300.5',imgPath: '',inventory: 200),
              GoodsModel(goodsName: '李子园牛奶33',saleNum: 100,shopName: '蒙牛旗舰店',price: '100.5',imgPath: '',inventory: 200),
              GoodsModel(goodsName: '李子园牛奶44',saleNum: 100,shopName: '蒙牛旗舰店',price: '100.5',imgPath: '',inventory: 200),
              GoodsModel(goodsName: '李子园牛奶22',saleNum: 9900,shopName: '蒙牛旗舰店',price: '300.5',imgPath: '',inventory: 200),
              GoodsModel(goodsName: '李子园牛奶33',saleNum: 100,shopName: '蒙牛旗舰店',price: '100.5',imgPath: '',inventory: 200),
              GoodsModel(goodsName: '李子园牛奶44',saleNum: 100,shopName: '蒙牛旗舰店',price: '100.5',imgPath: '',inventory: 200),
              GoodsModel(goodsName: '李子园牛奶22',saleNum: 9900,shopName: '蒙牛旗舰店',price: '300.5',imgPath: '',inventory: 200),
              GoodsModel(goodsName: '李子园牛奶33',saleNum: 100,shopName: '蒙牛旗舰店',price: '100.5',imgPath: '',inventory: 200),
              GoodsModel(goodsName: '李子园牛奶44',saleNum: 100,shopName: '蒙牛旗舰店',price: '100.5',imgPath: '',inventory: 200),
            ];
            _onLoad = false;
            setState(() {});
            _refreshController.refreshCompleted();
          },
          onLoadMore: () async {
            _refreshController.loadComplete();
          },
          body:  _onLoad?SizedBox():_buildList()
      ),
    );
  }

  _buildList(){
    return ListView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.only(
          left: 0, top: 0, right: 0, bottom: ScreenUtil().bottomBarHeight),
      itemBuilder: (_, index) {
        return GestureDetector(
          onTap: () {
          },
          child: Padding(padding: EdgeInsets.only(bottom: 8.w),
          child: _activityWidget( index),) 
        );
      },
      itemCount: goodsList.length,
    );
  }


  _activityWidget(int index){
    String iconPath = Assets.icons.hotSellIconMore.path;
    if (index == 0) {
      iconPath = Assets.icons.hotSellIconOne.path;
    }
    if (index == 1) {
      iconPath = Assets.icons.hotSellIconTwo.path;
    }
    if (index == 2) {
      iconPath = Assets.icons.hotSellIconThree.path;
    }
    return Stack(
      children: [
        GoodsItemWidget( goodsModel: goodsList[index],),
        Positioned(
          width: 20,
          height: 23,
          left: 15,
          top: 0,
          child: Image.asset(
            iconPath,
            fit: BoxFit.fill,
          ),
        ),
        Positioned(
            width: 20,
            height: 20,
            left: 15,
            top: 0,
            child: Container(
              alignment: Alignment.center,
              child: Text(
                (index + 1).toString(),
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                    fontSize: 24.sp),
              ),
            )),
      ],
    );
  }
}
