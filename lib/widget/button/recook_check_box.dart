
import 'package:new_recook/utils/headers.dart';

class RecookCheckBox extends StatelessWidget {
  final bool state;
  const RecookCheckBox({Key? key, this.state = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 32.w,
      width: 32.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          16.w
        ),
        border: state
            ? null
            : Border.all(
                width:2.w,
                color: Color(0xFFC9C9C9),
              ),
        color: state ? Color(0xFFDB2D2D) : Colors.transparent,
      ),
      child: Icon(
        Icons.check,
        color: Colors.white,
        size: 24.w,
      ),
    );
  }
}
