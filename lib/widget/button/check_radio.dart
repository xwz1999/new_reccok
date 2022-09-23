
import 'package:flutter/cupertino.dart';
import 'package:new_recook/utils/headers.dart';

class CheckRadio<T> extends StatefulWidget {
  final T? value;
  final List<T>? groupValue;
  final Widget? indent;
  final Color? backColor;

  CheckRadio(
      {Key? key, this.value, this.groupValue, this.indent, this.backColor})
      : super(key: key);

  @override
  _CheckRadioState createState() => _CheckRadioState();
}

class _CheckRadioState extends State<CheckRadio> {
  bool get _selected {
    if (widget.groupValue!.contains(widget.value)) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      height: 40.w,
      width: 40.w,
      decoration: BoxDecoration(
        color: widget.backColor ?? themeColor.withOpacity(_selected ? 1 : 0),
        border: Border.all(
          color: widget.backColor != null
              ? Color(0xFFBBBBBB)
              : (_selected ? themeColor : Color(0xFF979797)),
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
        opacity: _selected ? 1 : 0,
        child: widget.indent ??
            Icon(
              CupertinoIcons.checkmark,
              color: Colors.white,
              size: 28.w,
            ),
      ),
    );
  }
}
