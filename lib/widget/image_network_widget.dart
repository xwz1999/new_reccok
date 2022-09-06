import 'package:extended_image/extended_image.dart';
import 'package:new_recook/utils/headers.dart';

class ImageNetworkWidget extends StatefulWidget {
  final String url;
  final double? width;
  final double? height;
  final String placeholder;
  final BoxFit? fit;
  const ImageNetworkWidget({Key? key, required this.url, this.width, this.height, required this.placeholder, this.fit}) : super(key: key);

  @override
  _ImageNetworkWidgetState createState() => _ImageNetworkWidgetState();
}

class _ImageNetworkWidgetState extends State<ImageNetworkWidget> {
  @override
  Widget build(BuildContext context) {
    return  ExtendedImage.network(
      widget.url,
      width: widget.width,
      height: widget.height,
      fit: BoxFit.fill,
      cache: true,
      loadStateChanged: (ExtendedImageState state) {
        switch (state.extendedImageLoadState) {
          case LoadState.completed:
            return ExtendedRawImage(
              image: state.extendedImageInfo?.image,
              width: widget.width,
              height: widget.height,
              fit: widget.fit,
            );
          case LoadState.failed:
            return GestureDetector(
              child: Image.asset(
                widget.placeholder,
                fit: widget.fit,
              ),
              onTap: () {
                state.reLoadImage();
              },
            );
          case LoadState.loading:
            // TODO: Handle this case.
            return null;
        }

      },
    );
  }
}
