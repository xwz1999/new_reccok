import 'package:new_recook/utils/headers.dart';


class TextReButton extends StatelessWidget {

  final VoidCallback? onPressed;
  final double? width;
  final double? height;
  final String? text;
  final Color? color;
  final TextStyle? style;
  final BoxDecoration? boxDecoration;
  const TextReButton(
      {Key? key, this.onPressed, this.width, this.height, this.text, this.color, this.style, this.boxDecoration})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        alignment: Alignment.center,
        decoration: boxDecoration != null
            ? boxDecoration:null,
        width: width,
        height: height,
        color: color==null? Colors.transparent:color,
        child: Text(
            text??"",style: style==null?TextStyle(
          fontSize: 30.sp,color: Color(0xFF333333)
        ):style,
        ),
      ),
    );
  }
}
