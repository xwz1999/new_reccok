

import 'package:bot_toast/bot_toast.dart';
import 'package:new_recook/utils/headers.dart';
import 'package:new_recook/utils/text_utils.dart';
import 'package:new_recook/widget/input_view.dart';

typedef PlusMinusViewCallback = Function(int num);

class PlusMinusView extends StatefulWidget {
  final int minValue;
  final int? maxValue;
  final int? initialValue;
  final TextInputChangeCallBack? onBeginInput;
  final PlusMinusViewCallback onValueChanged;
  final TextInputChangeCallBack? onInputComplete;

  const PlusMinusView(
      {Key? key, this.minValue = 1,
      this.maxValue = 9999,
      required this.onValueChanged,
      this.onInputComplete,
      this.initialValue,
      this.onBeginInput});

  @override
  State<StatefulWidget> createState() {
    return _PlusMinusViewState();
  }
}

class _PlusMinusViewState extends State<PlusMinusView> {
  TextEditingController? _controller;

  int lastValue = 1;

  @override
  void initState() {
    super.initState();
    int initial = widget.initialValue ?? widget.minValue;
    _controller = TextEditingController(text: initial.toString());

  }


@override
  void dispose() {
    super.dispose();
    _controller!.dispose();
  }




  @override
  Widget build(BuildContext context) {
    // if (widget.initialValue != null) {
    //   _controller.text = widget.initialValue.toString();
    // }
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {},
      child: Container(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Spacer(),
            GestureDetector(
              child: Container(
                width: 50.w,
                height: 50.w,
                padding: EdgeInsets.symmetric(horizontal: 7, vertical: 0),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 241, 242, 244),

                ),
                child: Icon(
                  Icons.remove,
                  color: Colors.grey[500],
                  size: 25.w,
                ),

              ),
              onTap: _controller!.text == ''
                  ? (){

              }
                  : int.parse(_controller!.text) <= widget.minValue
                  ? () {
                BotToast.showText(text: '已是最低数量');

              }
                  : () {
                int num = int.parse(_controller!.text);
                num--;
                if (num <= widget.minValue) {
                  num = widget.minValue;
                }
                _controller!.text = "$num";

                if ((num == widget.minValue &&
                    lastValue != widget.minValue) ||
                    (lastValue == widget.maxValue)) {
                  setState(() {});
                }
                lastValue = num;
                widget.onInputComplete!(num.toString());
              },
            ),

            Container(
              height: 25,
              width: 40,
              color: Color.fromARGB(255, 241, 242, 244),
              margin: EdgeInsets.symmetric(horizontal: 2),
              child: InputView(
                textStyle: TextStyle(fontSize: 26.sp,color:Colors.black ),
                padding: EdgeInsets.symmetric(horizontal: 2),
                showClear: false,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                onBeginInput: widget.onBeginInput,
                onInputComplete: (value) {
                  if (TextUtils.isEmpty(value, whiteSpace: true)) {
                    _controller!.text = lastValue.toString();
                    // value = lastValue.toString();
                  } else {
                    if (int.parse(value) <= widget.minValue) {
                      _controller!.text = "${widget.minValue}";
                    } else if (int.parse(value) >= widget.maxValue!) {
                        BotToast.showText(text: '已经达到最大购买数量!');
                      _controller!.text = "${widget.maxValue}";
                    }
                    lastValue = int.parse(_controller!.text);
                    setState(() {});
                  }
                  widget.onInputComplete!(lastValue.toString());
                },
                controller: _controller,
                onValueChanged: (string) {
                  if(string.isEmpty){
                    widget.onValueChanged(0);
                    _controller!.text = '0';
                  } else {
                    widget.onValueChanged(int.parse(_controller!.text));
                  }
                },
              ),
            ),
            GestureDetector(
              child: Container(
                width: 50.w,
                height: 50.w,
                padding: EdgeInsets.symmetric(horizontal: 7, vertical: 0),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 241, 242, 244),

                ),
                child: Icon(

                  Icons.add,
                  color: Colors.grey[500],
                  size: 25.w,
                ),

              ),
              onTap:  _controller!.text == ''
                  ? null
                  : int.parse(_controller!.text) >= widget.maxValue!
                  ? () {
                BotToast.showText(text: '已经达到最大购买数量!');
              }
                  : () {
                int num = int.parse(_controller!.text);
                num++;
                _controller!.text = "$num";
                if (lastValue == widget.minValue ||
                    (num == widget.maxValue &&
                        lastValue != widget.maxValue)) {
                  setState(() {});
                }
                lastValue = num;
                widget.onInputComplete!(num.toString());
              },
            ),

            20.wb,
          ],
        ),
      ),
    );
  }
}
