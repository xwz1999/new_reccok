import 'dart:async';
import 'dart:io';

class TickTool {
  DateTime? _start;
  DateTime? _end;
  TickTool();
  Timer? timer;
  static const List<String> _boxTick = ['⌜', '⌝', '⌟', '⌞'];
  void start() {
    _start = DateTime.now();
    timer = Timer.periodic(Duration(milliseconds: 80), (timer) {
      var temp = timer.tick;
      getLog(extra: _boxTick[temp % 4]);
    });
  }

  void end() {
    _end = DateTime.now();
    timer?.cancel();
  }

  Duration get duration => _end!.difference(_start!);
  Duration get spend => DateTime.now().difference(_start!);
  void getLog({String extra = ''}) => stdout.write(
      '\r${spend.inSeconds}.${(spend.inMilliseconds / 1000.0).toStringAsFixed(2).split('.')[1]}s spend $extra');
}
