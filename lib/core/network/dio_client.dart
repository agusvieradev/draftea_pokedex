import 'package:dio/dio.dart';

class DioClient {
  static Dio create() {
    return Dio(
      BaseOptions(
        baseUrl: 'https://pokeapi.co/api/v2', //! ENV
        connectTimeout: const Duration(seconds: 10), //! ENV
        receiveTimeout: const Duration(seconds: 10), //! ENV
      ),
    );
  }
}
