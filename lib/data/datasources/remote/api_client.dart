import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';

import '../../../core/constants/app_constants.dart';

class ApiClient {
  static Dio createDio({required String bearerToken}) {
    final dio = Dio(BaseOptions(
      baseUrl: AppConstants.BASE_URL,
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 30),
    ));

    dio.options.headers['Authorization'] = 'Bearer $bearerToken';
    dio.options.headers['Accept'] = 'application/json';

    (dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () {
      final client = HttpClient(context: SecurityContext.defaultContext);
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };

    dio.interceptors.add(LogInterceptor(
      request: true,
      requestHeader: true,
      requestBody: true,
      responseHeader: true,
      responseBody: true,
      error: true,
    ));

    return dio;
  }
}