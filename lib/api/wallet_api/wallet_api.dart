import 'package:dio/dio.dart';
import 'package:grin_plus_plus/api/dio_provider.dart';
import 'package:grin_plus_plus/api/wallet_api/responses/create_wallet_response.dart';
import 'package:grin_plus_plus/api/wallet_api/responses/login_response.dart';
import 'package:grin_plus_plus/api/wallet_api/responses/restore_wallet_response.dart';
import 'package:grin_plus_plus/models/output.dart';
import 'package:grin_plus_plus/models/wallet_info.dart';

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
    return null;
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
    }
    return [];
  }

  Future<LoginResponse> login(String walletName, String password) async {
    try {
      var response = await _dio.post(
        '/v1/wallet/owner/login',
        options: Options(
          headers: {
            'username': walletName,
            'password': password,
          },
        ),
      );
      if (response.statusCode == 200) {
        return LoginResponse.fromJson(response.data);
      }
    } catch (error) {
      print('Exception occured: $error');
    }
    return null;
  }

  Future<bool> logout(String sessionToken) async {
    try {
      var response = await _dio.post(
        '/v1/wallet/owner/logout',
        options: Options(
          headers: {
            'session_token': sessionToken,
          },
        ),
      );
      if (response.statusCode == 200) {
        return true;
      }
    } catch (error) {
      print('Exception occured: $error');
    }
    return false;
  }

  Future<bool> updateWallet(String sessionToken, {bool fromGenesis}) async {
    try {
      var queryParameters;
      if (fromGenesis != null) {
        queryParameters = {
          'fromGenesis': fromGenesis,
        };
      }
      var response = await _dio.post(
        '/v1/wallet/owner/update_wallet',
        queryParameters: queryParameters,
        options: Options(
          headers: {
            'session_token': sessionToken,
          },
        ),
      );
      if (response.statusCode == 200) {
        return true;
      }
    } catch (error) {
      print('Exception occured: $error');
    }
    return false;
  }

  Future<List<Output>> getOutputs(String sessionToken) async {
    try {
      var response = await _dio.get(
        '/v1/wallet/owner/retrieve_outputs',
        queryParameters: {
          'show_spent': true,
          'show_canceled': true,
        },
        options: Options(
          headers: {
            'session_token': sessionToken,
          },
        ),
      );
      if (response.statusCode == 200) {
        return Output.fromJsonToList(response.data['outputs']);
      }
    } catch (error) {
      print('Exception occured: $error');
    }
    return null;
  }

  Future<WalletInfo> getWalletSummary(String sessionToken) async {
    try {
      var response = await _dio.get(
        '/v1/wallet/owner/retrieve_summary_info',
        options: Options(
          headers: {
            'session_token': sessionToken,
          },
        ),
      );
      if (response.statusCode == 200) {
        return WalletInfo.fromJson(response.data);
      }
    } catch (error) {
      print('Exception occured: $error');
    }
    return null;
  }
}
