import 'package:new_recook/utils/headers.dart';

///图片button
class ImgButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final double? width;
  final double? height;
  final String? path;

  const ImgButton(
      {Key? key, this.onPressed, this.width, this.height, this.path})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Image.asset(path!, height: height, width: width),
    );
  }
}
