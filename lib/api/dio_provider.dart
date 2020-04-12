import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:grin_plus_plus/api/rpc_client.dart';
import 'package:grin_plus_plus/repositories/pending_notifications_repository.dart';
import 'package:grin_plus_plus/strings.dart';

class NetworkUtilProvider {
  static Dio _dio;
  static RpcClient _rpcClient;
  static List<String> uriPathsToSkipErrorNotifications = [];

  static void _init() {
    _dio = Dio();

    _dio.options.baseUrl = DotEnv().env['OWNER_URL'];
    _dio.options.validateStatus = (status) => status == 200;
    _dio.interceptors.add(LogInterceptor(
      requestHeader: true,
      requestBody: true,
      responseHeader: true,
      responseBody: true,
    ));
    _dio.interceptors.add(ErrorInterceptor());

    _rpcClient = RpcClient(DotEnv().env['RPC_OWNER_URL']);
  }

  static Dio getDio() {
    if (_dio == null) {
      _init();
    }
    return _dio;
  }

  static RpcClient getRpc() {
    if (_rpcClient == null) {
      _init();
    }
    return _rpcClient;
  }
}

class ErrorInterceptor extends Interceptor {
  @override
  Future onError(DioError error) {
    if (!NetworkUtilProvider.uriPathsToSkipErrorNotifications.contains(error.request.path)) {
      NotificationsRepository.showNotification(Notification(
        title: kErrorString,
        message: error.response.data.toString() ?? error.message,
        notificationType: NotificationType.failure,
      ));
    }
    return Future(() => error);
  }
}
