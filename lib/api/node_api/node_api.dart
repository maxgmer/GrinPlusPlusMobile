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
}
