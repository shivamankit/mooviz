import 'package:get/get.dart';
import 'package:mooviz/core/constants/page_routes_constants.dart';
import 'package:mooviz/modules/bookmarks/di/bookmarks_binding.dart';
import 'package:mooviz/modules/home/di/home_binding.dart';
import 'package:mooviz/modules/search/di/search_binding.dart';
import '../modules/landing/di/landing_binding.dart';
import '../modules/landing/ui/landing_page.dart';
import '../modules/splash/di/splash_binding.dart';
import '../modules/splash/ui/splash_page.dart';




class StorePageRoutes {
  static List<GetPage> mainRouteList = [
    GetPage(
        name: PageRouteConstants.splashPage,
        transition: Transition.cupertino,
        page: () => SplashPage(),
        bindings: [SplashBinding()]),
    GetPage(
        name: PageRouteConstants.landingPage,
        transition: Transition.cupertino,
        page: () => LandingPage(),
        bindings: [
          LandingBinding(),
          HomeBinding(),
          SearchBinding(),
          BookmarksBinding(),
        ]),
  ];
}
