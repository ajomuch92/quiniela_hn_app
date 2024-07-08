import 'package:flutter/material.dart';
import 'package:flutter_solidart/flutter_solidart.dart';
import 'package:quiniela_hn_app/models/Tournament.dart';
import 'package:quiniela_hn_app/models/User.dart';
import 'package:quiniela_hn_app/services/AuthService.dart';
import 'package:quiniela_hn_app/services/TournamentsService.dart';

class HomeController {
  Signal selectedIndex = Signal(0);
  Signal areOnlyMyGroups = Signal(false);
  PageController pageController = PageController();
  late Resource<List<Tournament>> groupsResource;
  User user = getMyUser();

  HomeController() {
    groupsResource = Resource<List<Tournament>>(fetcher: getTournamentsFn);
  }

  // Future<List<Tournament>> getGroupsFn() async {
  //   try {
  //     return getUniqueGroups(areOnlyMyGroups.value
  //         ? 'groupId.userId="${user.id}"'
  //         : 'userId="${user.id}"');
  //   } catch (e) {
  //     print(e.toString());
  //     rethrow;
  //   }
  // }

  Future<List<Tournament>> getTournamentsFn() async {
    try {
      return getTournaments('active=true');
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }

  changeSelectedIndex(int newIndex) {
    selectedIndex.value = newIndex;
    pageController.jumpToPage(newIndex);
  }

  changeOnlySelectedIndex(int newIndex) {
    selectedIndex.value = newIndex;
  }

  logoutFn() {
    logout();
  }
}
