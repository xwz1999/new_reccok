import 'package:new_recook/constants/constants.dart';
import 'package:new_recook/gen/assets.gen.dart';
import 'package:new_recook/models/goods/category_model.dart';
import 'package:new_recook/pages/shop/home_search_page.dart';
import 'package:new_recook/utils/headers.dart';
import 'package:new_recook/widget/button/img_button.dart';
import 'package:new_recook/widget/home/sc_grid_view.dart';
import 'package:new_recook/widget/home/sc_tab_bar.dart';
import 'package:new_recook/widget/no_data_widget.dart';
import 'package:new_recook/widget/recook_scaffold.dart';

import '../../constants/api.dart';


class ClassifyPage extends StatefulWidget {
  final List<FirstCategory> data;
  final String? initValue;

  const ClassifyPage({Key? key, required this.data, this.initValue}) : super(key: key);

  @override
  _ClassifyPageState createState() => _ClassifyPageState();
}

class _ClassifyPageState extends State<ClassifyPage> with AutomaticKeepAliveClientMixin{

  PageController _controller = PageController();
  TabBarController _tabController = TabBarController();

  int currentIndex = 0;

  bool animating = false;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 300), () {
      int current =
      widget.data.indexWhere((element) => element.name == widget.initValue);
      currentIndex = current == -1 ? 0 : current;
      _tabController.jumpToIndex(currentIndex);
      _controller.animateToPage(currentIndex,
          duration: Duration(milliseconds: 200), curve: Curves.easeIn);
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return RecookScaffold(
      title: _buildTitle(),
      body: widget.data == null ? _blankView() : _buildContent(),
    );
  }

  Widget _blankView() {
    return NoDataWidget(text: '没有找到数据');
  }

  Widget _buildTitle() {
    return GestureDetector(
      onTap: (){
        Get.to(()=>HomeSearchPage());
      },
      child: Container(
        height: 80.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(40.w)),
          color: Color(0xFFEDEDED),
        ),
        child:  Row(

          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 10),
              child:Icon(
                Icons.search,
                size: 40.w,
                color: Colors.grey,
              ),
            ),
            Container(
              width: 6,
            ),
            Text(
              '搜索商品',
              style: TextStyle(
                  color: Color(0xFF666666),
                  fontSize: 15 * 2.sp,
                  ),
            ),

          ],
        ),
      ),
    );
  }

  _buildContent() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(flex: 2, child: _buildLeft()),
        Expanded(flex: 7, child: _buildRight()),
      ],
    );
  }

  _buildLeft() {
    return SCTabBar<String?>(
      controller: _tabController,
      initialIndex: 0,
      height:56.w,
      indicatorLocation: IndicatorLocation.left,
      indicatorHeight: 8.w,
      direction: Axis.vertical,
      spacing: 60.w,
      items: widget.data.map((item) {
        return item.name;
      }).toList(),
      itemBuilder: (context, index, item) {
        Color color;
        if (index == currentIndex) {
          color = Colors.red;
        } else {
          color = Colors.black87;
        }
        return Container(
            child: Center(
                child: Text(
                  item??'',
                  style: TextStyle(color: color,fontSize: 14 * 2.sp),
                  textAlign: TextAlign.center,
                )));
      },
      itemClick: (index) {
        currentIndex = index;
        _controller.animateToPage(currentIndex,
            duration: Duration(milliseconds: 200), curve: Curves.easeIn);
      },
    );
  }

  _buildRight() {
    double? statusBarHeight = DeviceInfo.statusBarHeight;
    double appbarHeight = 56.0;

    return PageView.builder(
        itemCount: widget.data.length,
        controller: _controller,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return NotificationListener(
              child: buildGridView(appbarHeight, statusBarHeight!, index),
              onNotification: (ScrollUpdateNotification notification) {
                if (animating) return true;

                if (currentIndex < widget.data.length - 1 &&
                    notification.metrics.pixels.toInt() >
                        ( notification.metrics.maxScrollExtent + 120).toInt()) {
                  if (!animating) {
                    animating = true;
                    currentIndex++;
                    _controller
                        .animateToPage(currentIndex,
                        duration: Duration(milliseconds: 200),
                        curve: Curves.linear)
                        .then((value) {
                      animating = false;
                      setState(() {
                        _tabController.jumpToIndex(currentIndex);
                      });
                    });
                  }
                }

                if (currentIndex > 0 &&
                    notification.metrics.pixels.toInt() <
                        notification.metrics.minScrollExtent - 120) {
                  if (!animating) {
                    animating = true;
                    currentIndex--;
                    _controller
                        .animateToPage(currentIndex,
                        duration: Duration(milliseconds: 200),
                        curve: Curves.linear)
                        .then((value) {
                      animating = false;
                      setState(() {
                        _tabController.jumpToIndex(currentIndex);
                      });
                    });
                  }
                }
                return true;
              });
        });
  }

  buildGridView(
      double appbarHeight, double statusBarHeight, int index) {
    List<SecondCategory>? secondCategories = widget.data[index].sub;
    String? firstTitle = widget.data[index].name;
    return SCGridView(
        viewportHeight:
        DeviceInfo.screenHeight! - appbarHeight - statusBarHeight + 5,
        crossAxisCount: 3,
        sectionCount: 1,
        childAspectRatio: 0.9,
        itemCount: (section) {
          return widget.data[index].sub!.length;
        },
        headerBuilder: (context, section) {
          return Container(
            // color: Colors.blueGrey,
            // height: rSize(48),
            height: DeviceInfo.screenWidth! / 4,
            child:FadeInImage.assetNetwork(
              width: DeviceInfo.screenWidth! / 4,
              height: DeviceInfo.screenWidth! / 4 * 3,
              placeholder:
              Assets.images.placeholderNew2x1A.path,
              image: API.getImgUrl(widget.data[index].logoUrl)!,
              fit: BoxFit.fill,
              imageErrorBuilder:
                  (context, error, stackTrace) {
                return Image.asset(
                  Assets.images.placeholderNew2x1A.path,
                  fit: BoxFit.fill,
                );
              },
            )

          );
        },
        itemBuilder: (context, indexIn) {
          SecondCategory secondCategory = secondCategories![indexIn];
          return GestureDetector(
            onTap: (){
              // Get.to(() =>
              //     GoodsListPage(
              //       arguments: GoodsListPage.setArguments(
              //           title: firstTitle,
              //           index: indexIn,
              //           secondCategoryList: secondCategories,
              //           isJD: widget.jdType == 1 ? true : false),
              //     ));
            },
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(20.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(16.w))
                  ),
                  child: FadeInImage.assetNetwork(
                    width: 100.w,
                    height: 100.w,
                    placeholder:
                    Assets.images.placeholderNew1x1A.path,
                    image: API.getImgUrl(secondCategory.logoUrl)!,
                    fit: BoxFit.fill,
                    imageErrorBuilder:
                        (context, error, stackTrace) {
                      return Image.asset(
                        Assets.images.placeholderNew1x1A.path,
                        fit: BoxFit.fill,
                        width: 100.w,
                        height: 100.w,
                      );
                    },
                  ),
                ),
                10.hb,
                Text(secondCategory.name??"",style: TextStyle(
                  fontSize: 26.sp,color: Color(0xFF333333)
                ),)
              ],
            ),
          );

        });
  }
}
