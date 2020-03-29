import 'package:dio/dio.dart';
import 'package:grin_plus_plus/api/dio_provider.dart';
import 'package:grin_plus_plus/api/wallet_api/responses/create_wallet_response.dart';
import 'package:grin_plus_plus/api/wallet_api/responses/estimate_fee_response.dart';
import 'package:grin_plus_plus/api/wallet_api/responses/login_response.dart';
import 'package:grin_plus_plus/api/wallet_api/responses/restore_wallet_response.dart';
import 'package:grin_plus_plus/models/commitment.dart';
import 'package:grin_plus_plus/models/wallet_info.dart'
;import 'package:json_rpc_2/json_rpc_2.dart' as JsonRpc;

class WalletApi {
  final Dio _dio = DioProvider.getDio();

  WalletApi() {
    DioProvider.uriPathsToSkipErrorNotifications
        .add('/v1/wallet/owner/estimate_fee');
  }

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

  Future<List<Commitment>> getOutputs(String sessionToken) async {
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
        return Commitment.fromJsonToList(response.data['outputs']);
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

  Future<EstimateFeeResponse> estimateFee(String sessionToken, int amount, String strategy, List<Commitment> inputs) async {
    try {
      var response = await _dio.post(
        '/v1/wallet/owner/estimate_fee',
        data: {
          'amount': amount,
          'fee_base': 1000000,
          'selection_strategy': {
            'strategy': strategy,
            'inputs': inputs,
          },
        },
        options: Options(
          headers: {
            'session_token': sessionToken,
          },
        ),
      );
      if (response.statusCode == 200) {
        return EstimateFeeResponse.fromJson(response.data);
      }
    } on DioError catch (error) {
      print('Exception occured: $error');
      return EstimateFeeResponse(errorMessage: error.response.data);
    } catch (error) {
      print('Exception occured: $error');
    }
    return null;
  }
  reqJSON['session_token'] = global.session_token;
  reqJSON['amount'] = amount;
  reqJSON['fee_base'] = 1000000;
  reqJSON['selection_strategy'] = {
  strategy: strategy,
  inputs: inputs
  };

  reqJSON['address'] = address;

  if (message != null && message.length > 0) {
  reqJSON['message'] = message;
  }

  var postJSON = new Object();
  if (grinjoin == true) {
  postJSON['method'] = 'JOIN';
  postJSON['grinjoin_address'] = GRINJOIN_ADDRESS;
  } else {
  postJSON['method'] = 'STEM';
  }
  reqJSON["post_tx"] = postJSON;

  RPCClient.call('send', reqJSON, function (response, error) {
    if (error != null) {
      callback({
        success: false,
        data: error
      });
    } else if (response.error != null) {
      callback({
        success: false,
        message: response.error.message,
        data: response.error.data
      });
    } else {
      callback({
        success: true,
        data: response.result
      });
    }
  });
  Future send(String sessionToken, int amount, String strategy,
      String address, String message, bool grinJoin) async {
    try {
      JsonRpc.Client().sendRequest(method)
    } catch (error) {
      print('Exception occured: $error');
    }
  }
}
