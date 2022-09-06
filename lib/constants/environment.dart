import 'package:power_logger/power_logger.dart';

class DevEV {
  static final DevEV _instance = DevEV._();

  DevEV._();

  static DevEV get instance => _instance;

  bool dev = false;

  void setEnvironment(context, {required bool environment}) {
    dev = environment;
    PowerLogger.start(context, debug: dev);
  }
}
