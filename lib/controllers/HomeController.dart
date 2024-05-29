import 'package:flutter/material.dart';
import 'package:flutter_solidart/flutter_solidart.dart';
import 'package:quiniela_hn_app/models/Group.dart';
import 'package:quiniela_hn_app/models/User.dart';
import 'package:quiniela_hn_app/services/AuthService.dart';
import 'package:quiniela_hn_app/services/GroupService.dart';

class HomeController {
  Signal selectedIndex = Signal(0);
  Signal areOnlyMyGroups = Signal(false);
  PageController pageController = PageController();
  late Resource<List<Group>> groupsResource;
  User user = getMyUser();

  HomeController() {
    groupsResource =
        Resource<List<Group>>(fetcher: getGroupsFn, source: areOnlyMyGroups);
  }

  Future<List<Group>> getGroupsFn() async {
    try {
      return getUniqueGroups(areOnlyMyGroups.value
          ? 'groupId.userId="${user.id}"'
          : 'userId="${user.id}"');
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }

  changeSelectedIndex(int newIndex) {
    selectedIndex.value = newIndex;
    pageController.jumpToPage(newIndex);
  }

  onCheckedChanged(bool newVal) {
    areOnlyMyGroups.value = newVal;
  }

  logoutFn() {
    logout();
  }
}
