import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../../../core/constants/app_colors.dart';
import '../viewmodel/splash_controller.dart';

class SplashPage extends StatelessWidget {
  SplashPage({
    super.key,
  });

  var splashController = Get.find<SplashController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Center(
        child: Lottie.asset("assets/animations/mooviz_logo_animation.json"),
      ),
    );
  }
}
