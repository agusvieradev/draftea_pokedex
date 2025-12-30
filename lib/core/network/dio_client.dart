import 'package:dio/dio.dart';
import 'package:draftea_pokedex/core/config/app_config.dart';

class DioClient {
  static Dio create() {
    return Dio(
      BaseOptions(
        baseUrl: AppConfig.apiBaseUrl,
        connectTimeout: const Duration(seconds: AppConfig.connectionTimeout),
        receiveTimeout: const Duration(seconds: AppConfig.receiveTimeout),
      ),
    );
  }
}
