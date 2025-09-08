
import 'package:get/get.dart';
import 'package:mooviz/data/datasources/local/hive_service.dart';

import '../data/datasources/remote/api_client.dart';
import '../data/datasources/remote/movie_api_service.dart';
import '../data/repositories/movie_repository.dart';
import 'constants/app_constants.dart';



class CommonBindings extends Bindings {
  @override
  void dependencies() {
    final dio = ApiClient.createDio(bearerToken: AppConstants.ACCESS_TOKEN);
    final api = MovieApiService(dio);
    final hiveService = Get.find<HiveService>();
    Get.put<MovieApiService>(api, permanent: true);
    Get.put<MovieRepository>(MovieRepository(api: api, hive: hiveService), permanent: true,);
  }
}
