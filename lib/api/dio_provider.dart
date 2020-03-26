import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:grin_plus_plus/repositories/pending_notifications_repository.dart';
import 'package:grin_plus_plus/strings.dart';

class DioProvider {
  static Dio dio;
  static List<String> uriPathsToSkipErrorNotifications = [];

  static void _init() {
    dio = Dio();

    dio.options.baseUrl = DotEnv().env['OWNER_URL'];
    dio.options.validateStatus = (status) => status == 200;
    dio.interceptors.add(LogInterceptor(
      requestHeader: true,
      requestBody: true,
      responseHeader: true,
      responseBody: true,
    ));
    dio.interceptors.add(ErrorInterceptor());
  }

  static Dio get() {
    if (dio == null) {
      _init();
    }

    return dio;
  }
}

class ErrorInterceptor extends Interceptor {
  @override
  Future onError(DioError error) {
    if (!DioProvider.uriPathsToSkipErrorNotifications.contains(error.request.path)) {
      NotificationsRepository.showNotification(Notification(
        title: kErrorString,
        message: error.response.data.toString() ?? error.message,
        notificationType: NotificationType.failure,
      ));
    }
    return Future(() => error);
  }
}
