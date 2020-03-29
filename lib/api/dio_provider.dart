import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:grin_plus_plus/repositories/pending_notifications_repository.dart';
import 'package:grin_plus_plus/strings.dart';
import 'package:json_rpc_2/json_rpc_2.dart' as JsonRpc;
import 'package:stream_channel/stream_channel.dart';
import "package:web_socket_channel/html.dart";

class DioProvider {
  static Dio _dio;
  static JsonRpc.Client _rpcClient;
  static List<String> uriPathsToSkipErrorNotifications = [];

  static void _init() {
    _dio = Dio();
    HtmlWebSocketChannel socket = HtmlWebSocketChannel.connect('ws://localhost:4321');
    _rpcClient = JsonRpc.Client(StreamChannel.withGuarantees(socket);
    _rpcClient.listen();

    _dio.options.baseUrl = DotEnv().env['OWNER_URL'];
    _dio.options.validateStatus = (status) => status == 200;
    _dio.interceptors.add(LogInterceptor(
      requestHeader: true,
      requestBody: true,
      responseHeader: true,
      responseBody: true,
    ));
    _dio.interceptors.add(ErrorInterceptor());
  }

  static Dio getDio() {
    if (_dio == null) {
      _init();
    }
    return _dio;
  }

  static JsonRpc.Client getRpc() {
    if (_rpcClient == null) {
      _init();
    }
    return _rpcClient;
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
