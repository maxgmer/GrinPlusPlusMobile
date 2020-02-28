import 'package:dio/dio.dart';
import 'package:grin_plus_plus/api/dio_provider.dart';
import 'package:grin_plus_plus/api/wallet_api/create_wallet_response.dart';
import 'package:grin_plus_plus/strings.dart';

class WalletApi {
  final Dio _dio = DioProvider.get();

  Future<CreateWalletResponse> createWallet(String username, String password) async {
    try {
      var response = await _dio.post(
        '/v1/wallet/owner/create_wallet',
        options: Options(
          headers: {
            'username': username,
            'password': password,
          },
        ),
      );
      if (response.statusCode == 200) {
        return CreateWalletResponse.fromJson(response.data);
      } else {
        return CreateWalletResponse(failedMessage: response.data ?? kCouldNotCreateWalletString);
      }
    } catch (error, stacktrace) {
      print('Exception occured: $error stackTrace: $stacktrace');
      return null;
    }
  }
}
