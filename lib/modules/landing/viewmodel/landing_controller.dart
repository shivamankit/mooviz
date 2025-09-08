import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:mooviz/modules/bookmarks/ui/bookmarks_page.dart';
import 'package:mooviz/modules/home/ui/home_page.dart';
import 'package:mooviz/modules/search/ui/search_page.dart';

class LandingController extends GetxController {
  var selectedIndex = 0.obs;

  final pages = [
    HomePage(),
    SearchPage(),
    BookmarksPage(),
  ];

  void onItemTapped(int index) {
    selectedIndex.value = index;
  }
}
