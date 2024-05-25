import 'package:flutter_solidart/flutter_solidart.dart';

class HomeController {
  Signal selectedIndex = Signal(0);

  changeSelectedIndex(int newIndex) {
    selectedIndex.value = newIndex;
  }
}
