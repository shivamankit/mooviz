import 'package:get/get.dart';

import '../../../core/constants/page_routes_constants.dart';

class SplashController extends GetxController {

  @override
  void onInit() {
    super.onInit();
    Future.delayed(const Duration(seconds: 3), () {
      Get.offAndToNamed(PageRouteConstants.landingPage);
    });
  }
}
