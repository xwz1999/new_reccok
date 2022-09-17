import 'dart:async';

import 'package:chewie/chewie.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:new_recook/constants/api.dart';
import 'package:new_recook/gen/assets.gen.dart';
import 'package:new_recook/models/home/aku_video_list_model.dart';
import 'package:new_recook/utils/headers.dart';
import 'package:new_recook/widget/recook_scaffold.dart';
import 'package:video_player/video_player.dart';

class AkuCollegeDetailPage extends StatefulWidget {
  final AkuVideo akuVideo;

  const AkuCollegeDetailPage({Key? key, required this.akuVideo})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _AkuCollegeDetailPageState();
  }
}

class _AkuCollegeDetailPageState extends State<AkuCollegeDetailPage> {
  VideoPlayerController? _videoPlayerController;
  ChewieController? _chewieController;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      // String? code = await HomeFuc.addHits(widget.akuVideo.id);
      // print(code);
    });
    if (widget.akuVideo.type == 1) {
      _videoPlayerController = VideoPlayerController.network(
          API.getImgUrl(widget.akuVideo.videoUrl) ?? ''); //
      _videoPlayerController?.initialize().then((_) {
        _chewieController = ChewieController(
          videoPlayerController: _videoPlayerController!,
          aspectRatio: _videoPlayerController!.value.aspectRatio,
          autoPlay: false,
          showControls: true,
          customControls: CupertinoControls(
            backgroundColor: Color.fromRGBO(41, 41, 41, 0.7),
            iconColor: Color.fromARGB(255, 200, 200, 200),
          ),
        );

        setState(() {});
      });
    } else {
      if (widget.akuVideo.textBody != null) {}
    }
  }

  @override
  void dispose() {
    super.dispose();
    _videoPlayerController?.dispose();
    _chewieController?.dispose();
  }

  @override
  Widget build(BuildContext context, {store}) {
    return RecookScaffold.white(
      body: _bodyWidget(),
      title: "".text.bold.size(36.sp).make(),
      actions: [
        GestureDetector(
          onTap: () {},
          child: Padding(
            padding: EdgeInsets.only(right: 30.w, top: 10.w),
            child: Image.asset(
              Assets.icons.share.path,
              color: Colors.black,
              width: 40.w,
              height: 40.w,
            ),
          ),
        ),
      ],
    );
  }

  _bodyWidget() {
    return SingleChildScrollView(
        child: Column(
      children: [
        40.hb,
        Row(
          children: [
            30.wb,
            Text(
              widget.akuVideo.title ?? '',
              maxLines: 2,
              softWrap: true,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: 40.sp,
                  color: Color(0xFF333333),
                  fontWeight: FontWeight.bold),
            ).expand(),
            30.wb,
          ],
        ),
        20.hb,
        Row(
          children: [
            30.wb,
            Text(
              widget.akuVideo.subTitle ?? '',
              softWrap: true,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 24.sp,
                color: Color(0xFF333333),
              ),
            ),
            40.wb,
            Container(
              padding: EdgeInsets.only(top: 6.w),
              child: Text(
                _getDateTime(widget.akuVideo.createDTime ?? ''),
                softWrap: true,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 24.sp,
                  color: Color(0xFF999999),
                ),
              ),
            ),
            40.wb,
            Text(
              (widget.akuVideo.numberOfHits ?? 0).toString() + '人已学习',
              softWrap: true,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 24.sp,
                color: Color(0xFF999999),
              ),
            ),
          ],
        ),
        20.hb,
        widget.akuVideo.type == 1 ? _playVideo() : _playImageText()
      ],
    ));
  }

  _getDateTime(String date) {
    if (date.isEmpty) {
      return date;
    } else {
      DateTime? dateTime = DateUtil.getDateTime(date);
      return DateUtil.formatDate(dateTime, format: 'yyyy-MM-dd');
    }
  }

  _playVideo() {
    return Container(
      padding: EdgeInsets.only(top: 40.w, left: 30.w, right: 30.w),
      height: 460.w,
      child: _chewieController != null
          ? Chewie(
              controller: _chewieController!,
            )
          : SizedBox(),
    );
  }

  _playImageText() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: HtmlWidget(
        widget.akuVideo.textBody ?? '',
        textStyle: TextStyle(color: Color(0xFF333333)),
      ),
    );
  }
}
