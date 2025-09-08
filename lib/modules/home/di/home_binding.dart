import 'package:get/get.dart';

import '../../../data/repositories/movie_repository.dart';
import '../viewmodel/home_controller.dart';

class HomeBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController(repository: Get.find<MovieRepository>(),), fenix: true);
  }

}