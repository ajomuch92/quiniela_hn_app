import 'package:flutter_solidart/flutter_solidart.dart';
import 'package:quiniela_hn_app/services/AuthService.dart';

class HomeController {
  Signal selectedIndex = Signal(0);

  changeSelectedIndex(int newIndex) {
    selectedIndex.value = newIndex;
  }

  logoutFn() {
    logout();
  }
}
