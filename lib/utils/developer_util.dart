class DeveloperUtil {
  static bool _dev = false;

  static setDev(bool state) {
    _dev = state;
  }

  static bool get dev => _dev;
}
