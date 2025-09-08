import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'core/common_binding.dart';
import 'core/constants/page_routes_constants.dart';
import 'core/store_page_routes.dart';
import 'data/datasources/local/hive_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final hiveService = HiveService();
  await hiveService.init();
  Get.put<HiveService>(hiveService, permanent: true);
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mooviz',
      initialBinding: CommonBindings(),
      initialRoute: PageRouteConstants.splashPage,
      getPages: StorePageRoutes.mainRouteList,
    );
  }
}
