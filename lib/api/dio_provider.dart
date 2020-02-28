import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:grin_plus_plus/repositories/session_repository.dart';

class DioProvider {
  static Dio dio;

  static void _init() {
    dio = Dio();

    dio.options.baseUrl = DotEnv().env['OWNER_URL'];
    dio.options.connectTimeout = 15000;
    dio.options.receiveTimeout = 15000;
    dio.options.validateStatus = (status) => status < 500;
    dio.interceptors.add(LogInterceptor(
      requestHeader: true,
      requestBody: true,
      responseHeader: true,
      responseBody: true,
    ));
    dio.interceptors.add(TokenInterceptor());
  }

  static Dio get() {
    if (dio == null) {
      _init();
    }

    return dio;
  }
}

class TokenInterceptor extends Interceptor {
  @override
  Future onResponse(Response response) {
    try {
      if (response.data['session_token'] != null) {
        SessionRepository.addSessionToken(response.data['session_token']);
      }
    } catch (error) {}
    return Future(() => response);
  }
}
