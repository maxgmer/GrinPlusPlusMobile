import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:grin_plus_plus/api/dio_provider.dart';
import 'package:grin_plus_plus/api/rpc_client.dart';
import 'package:grin_plus_plus/api/wallet_api/responses/create_wallet_response.dart';
import 'package:grin_plus_plus/api/wallet_api/responses/estimate_fee_response.dart';
import 'package:grin_plus_plus/api/wallet_api/responses/login_response.dart';
import 'package:grin_plus_plus/api/wallet_api/responses/restore_wallet_response.dart';
import 'package:grin_plus_plus/api/wallet_api/responses/transfer_response.dart';
import 'package:grin_plus_plus/models/input_output.dart';
import 'package:grin_plus_plus/models/transaction.dart';
import 'package:grin_plus_plus/models/wallet_info.dart';

class WalletApi {
  final Dio _dio = NetworkUtilProvider.getDio();
  final RpcClient _rpcClient = NetworkUtilProvider.getRpc();
  static WalletApi _api;

  WalletApi._internal() {
    NetworkUtilProvider.uriPathsToSkipErrorNotifications
        .add('/wallet/owner/estimate_fee');
  }

  factory WalletApi() {
    if (_api == null) {
      _api = WalletApi._internal();
    }
    return _api;
  }

  Future<CreateWalletResponse> createWallet(String username, String password) async {
    try {
      var response = await _dio.post(
        '/wallet/owner/create_wallet',
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
        '/wallet/owner/restore_wallet',
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
        '/wallet/owner/accounts',
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
        '/wallet/owner/login',
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
        '/wallet/owner/logout',
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
        '/wallet/owner/update_wallet',
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

  Future<List<InputOutput>> getOutputs(String sessionToken) async {
    try {
      var response = await _dio.get(
        '/wallet/owner/retrieve_outputs',
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
        return InputOutput.fromJsonToList(response.data['outputs']);
      }
    } catch (error) {
      print('Exception occured: $error');
    }
    return null;
  }

  Future<WalletInfo> getWalletSummary(String sessionToken) async {
    try {
      var response = await _dio.get(
        '/wallet/owner/retrieve_summary_info',
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

  Future<Transaction> getTransactionInfo(String sessionToken, int txId) async {
    try {
      var response = await _dio.get(
        '/wallet/owner/retrieve_txs',
        queryParameters: {'id': txId},
        options: Options(
          headers: {
            'session_token': sessionToken,
          },
        ),
      );

      if (response.statusCode == 200) {
        return Transaction.fromJson(response.data['transactions'][0]);
      }
    } catch (error) {
      print('Exception occured: $error');
    }
    return null;
  }

  Future cancelTransaction(String sessionToken, int txId) async {
    try {
      var response = await _dio.post(
        '/wallet/owner/cancel_tx',
        queryParameters: {'id': txId},
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

  Future<EstimateFeeResponse> estimateFee(String sessionToken, int amount, String strategy, List<InputOutput> inputs) async {
    try {
      var response = await _dio.post(
        '/wallet/owner/estimate_fee',
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

  Future<TransferResponse> send(String sessionToken, int amount, String strategy,
      String address, String message, bool grinJoin) async {
    try {
      Map<String, dynamic> reqJson = {
        'session_token': sessionToken,
        'amount': amount,
        'fee_base': 1000000,
        'selection_strategy': {
          'strategy': strategy,
        },
      };

      if (address != null && address.isNotEmpty) {
        reqJson.addAll({'address': address});
      }

      if (message != null && message.isNotEmpty) {
        reqJson.addAll({'message': message});
      }

      var postJson;
      if (grinJoin) {
        postJson = {
          'method': 'JOIN',
          'grinjoin_address': DotEnv().env['GRINJOIN_ADDRESS'],
        };
      } else {
        postJson = {
          'method': 'STEM',
        };
      }
      reqJson.addAll({'post_tx': postJson});

      return TransferResponse.fromJson(
        await _rpcClient.call('send', reqJson),
      );
    } catch (error) {
      print('Exception occured: $error');
      return null;
    }
  }

  Future<TransferResponse> receive(String sessionToken,
      Map<String, dynamic> slate, String address, String message) async {
    try {
      Map<String, dynamic> reqJson = {
        'session_token': sessionToken,
        'slate': slate,
      };

      if (address != null && address.isNotEmpty) {
        reqJson.addAll({'address': address});
      }

      if (message != null && message.isNotEmpty) {
        reqJson.addAll({'message': message});
      }

      return TransferResponse.fromJson(
        await _rpcClient.call('receive', reqJson),
      );
    } catch (error) {
      print('Exception occured: $error');
    }
    return null;
  }

  Future<TransferResponse> finalize(String sessionToken,
      Map<String, dynamic> slate, bool grinJoin) async {
    try {
      Map<String, dynamic> reqJson = {
        'session_token': sessionToken,
        'slate': slate,
      };

      var postJson;
      if (grinJoin) {
        postJson = {
          'method': 'JOIN',
          'grinjoin_address': DotEnv().env['GRINJOIN_ADDRESS'],
        };
      } else {
        postJson = {
          'method': 'STEM',
        };
      }
      reqJson.addAll({'post_tx': postJson});

      return TransferResponse.fromJson(
        await _rpcClient.call('finalize', reqJson),
      );
    } catch (error) {
      print('Exception occured: $error');
    }
    return null;
  }
}
