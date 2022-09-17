import 'package:flutter/cupertino.dart';
import 'package:new_recook/constants/api.dart';
import 'package:new_recook/constants/constants.dart';
import 'package:new_recook/gen/assets.gen.dart';
import 'package:new_recook/models/home/aku_video_list_model.dart';
import 'package:new_recook/pages/shop/function/aku_college_detail_page.dart';
import 'package:new_recook/utils/headers.dart';
import 'package:new_recook/widget/no_data_widget.dart';
import 'package:new_recook/widget/recook_scaffold.dart';
import 'package:new_recook/widget/refresh_widget.dart';

class AkuCollegePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AkuCollegePageState();
  }
}

class _AkuCollegePageState extends State<AkuCollegePage> {
  GSRefreshController _refreshController =
      GSRefreshController(initialRefresh: true);
  TextEditingController? _textEditController;
  AkuVideoListModel? _akuVideoListModel;
  List<AkuVideo>? _akuVideoList;
  String? _searchText;
  int page = 1;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context, {store}) {
    return RecookScaffold(
      extendBody: true,
      title: '',
      body: Stack(
        children: [
          Positioned(
              child: Container(
            height:
                240.w + DeviceInfo.statusBarHeight! + DeviceInfo.appBarHeight,
            width: double.infinity,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(Assets.images.schoolBg.path),
                    fit: BoxFit.fill)),
          )),
          _bodyWidget(),
        ],
      ),
    );
  }

  _bodyWidget() {
    return Column(
      children: [
        Container(
            height:
                280.w + DeviceInfo.statusBarHeight! + DeviceInfo.appBarHeight),

        Container(
            alignment: Alignment.center,
            width: 520.w,
            height: 80.w,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 2),
                  color: Color(0x45B4B1B1),
                  blurRadius: 8.w,
                )
              ],
              borderRadius: BorderRadius.all(Radius.circular(26.w)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: CupertinoTextField(
                    keyboardType: TextInputType.text,
                    controller: _textEditController,
                    //textInputAction: TextInputAction.search,
                    onChanged: (text) async {
                      _searchText = text;
                      setState(() {});
                    },
                    placeholder: "搜一下是否有您想要的内容",
                    placeholderStyle: TextStyle(
                        color: Color(0xFF999999),
                        fontSize: 28.sp,
                        fontWeight: FontWeight.w300),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(32.w)),
                    ),
                    style: TextStyle(color: Colors.black, fontSize: 32.sp),
                  ),
                ),
                Container(
                  width: 74.w,
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: Icon(
                    Icons.search,
                    size: 36.w,
                    color: Color(0xFFC92219),
                  ),
                ),
              ],
            )),
        _buildListView(),
      ],
    );
  }

  _buildListView() {
    return Container(
            margin: EdgeInsets.only(left: 16.w, right: 16.w, top: 16.w),
            child: RefreshWidget(
                controller: _refreshController,
                noData: '没有找到您想要的内容',
                onRefresh: () async {
                  setState(() {});
                  _refreshController.refreshCompleted();
                },
                onLoadMore: () async {
                  if (_akuVideoListModel!.list!.length >=
                      _akuVideoListModel!.total!) {
                    _refreshController.loadComplete();
                    _refreshController.loadNoData();
                  } else {
                    _refreshController.loadComplete();
                  }
                },
                body: _akuVideoListModel?.list != null
                    ? GridView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 170 / 162,
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 17),
                        itemCount: _akuVideoListModel!.list!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return _akuVideoItem(
                              _akuVideoListModel!.list![index]);
                        },
                      )
                    : NoDataWidget(
                        text: '没有找到您想要的内容',
                      )))
        .expand();
  }

  _akuVideoItem(AkuVideo akuVideo) {
    return Container(
      margin: EdgeInsets.only(left: 8.w, right: 8.w, top: 8.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.w),
        boxShadow: [
          BoxShadow(
            color: Color(0xFFDBDBDB),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              //跳转页面
              Get.to(AkuCollegeDetailPage(akuVideo: akuVideo));
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  child: Container(
                      decoration: BoxDecoration(
                        //color: Colors.white,
                        borderRadius: BorderRadius.circular(8.w),
                      ),
                      child: FadeInImage.assetNetwork(
                        placeholder: Assets.images.placeholderNew2x1A.path,
                        image: API.getImgUrl(akuVideo.coverUrl)??"",
                        fit: BoxFit.fill,
                        imageErrorBuilder: (context, error, stackTrace) {
                          return Image.asset(
                            Assets.images.placeholderNew2x1A.path,
                            fit: BoxFit.fill,
                          );
                        },
                      )
                      ),
                ),
                akuVideo.type == 1
                    ? Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: Icon(CupertinoIcons.play_circle,
                            size: 50, color: Colors.white),
                      )
                    : SizedBox()
              ],
            ),
          ),
          10.hb,
          Row(
            children: [
              16.wb,
              Text(
                akuVideo.title!,
                maxLines: 2,
                softWrap: true,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: 24.sp,
                    color: Color(0xFF333333),
                    fontWeight: FontWeight.bold),
              ).expand(),
              16.wb,
            ],
          ),
          Spacer(),
          Row(
            children: [
              16.wb,
              Text(akuVideo.subTitle!,
                  style: TextStyle(fontSize: 20.sp, color: Color(0xFF333333))),
              Spacer(),
              Text(akuVideo.numberOfHits.toString() + '人看过',
                  style: TextStyle(fontSize: 20.sp, color: Color(0xFF999999))),
              16.wb,
            ],
          ),
          20.hb,
        ],
      ),
    );
  }
}
