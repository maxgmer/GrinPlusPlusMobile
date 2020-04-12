import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class RpcClient {
  Dio _dio;
  String url;

  RpcClient(this.url) {
    _dio = Dio();
    _dio.options.baseUrl = DotEnv().env['RPC_OWNER_URL'];
    _dio.options.validateStatus = (status) => status == 200;
    _dio.interceptors.add(LogInterceptor(
      requestHeader: true,
      requestBody: true,
      responseHeader: true,
      responseBody: true,
    ));
  }

  Future call(String method, Map<String, dynamic> params) async {
    try {
      var body =  {
        'jsonrpc': '2.0',
        'method': method,
        'params': params,
        'id': params.hashCode,
      };
      var response = await _dio.post('/', data: body);
      return response.data['result'];
    } catch (error) {
      print('Exception occured: $error');
    }
  }
}

class RpcError {
  final int code;
  String message;
  dynamic data;

  static const Map<int, String> codeMeanings = {
    -32700: 'Parse error. Invalid JSON was received by the server. An error occurred on the server while parsing the JSON text.',
    -32600: 'Invalid Request. The JSON sent is not a valid Request object.',
    -32601: 'Method not found. The method does not exist or is not available.',
    -32602: 'Invalid params. Invalid method parameter(s).',
    -32603: 'Internal error.	Internal JSON-RPC error.',
  };

  RpcError({
    this.code,
    this.message,
    this.data,
  }) {
    if (message == null || message.isEmpty) {
      message = codeMeanings[code];
    }
  }
}
