import 'package:dio/dio.dart';
import 'package:grin_plus_plus/api/dio_provider.dart';
import 'package:grin_plus_plus/api/wallet_api/responses/create_wallet_response.dart';
import 'package:grin_plus_plus/api/wallet_api/responses/restore_wallet_response.dart';

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
      }
    } catch (error) {
      print('Exception occured: $error');
    }
    return null;
  }

  Future restoreWallet(String username, String password, String seed) async {
    try {
      var response = await _dio.post(
        '/v1/wallet/owner/restore_wallet',
        options: Options(
          headers: {
            'username': username,
            'password': password,
          },
        ),
        data: {
          'wallet_seed': seed,
        },
      );
      if (response.statusCode == 200) {
        return RestoreWalletResponse.fromJson(response.data);
      }
    } catch (error) {
      print('Exception occured: $error');
    }
  }

  Future<List<String>> getWallets() async {
    try {
      var response = await _dio.get(
        '/v1/wallet/owner/accounts',
      );
      List<String> walletNames = [];
      if (response.statusCode == 200) {
        if (response.data != null) {
          for (var walletName in response.data as List) {
            walletNames.add(walletName.toString());
          }
        }
      }
      return walletNames;
    } catch (error) {
      print('Exception occured: $error');
      return [];
    }
  }
}
