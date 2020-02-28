// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_wallet_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateWalletResponse _$CreateWalletResponseFromJson(Map<String, dynamic> json) {
  return CreateWalletResponse(
    sessionToken: json['session_token'] as String,
    walletSeed: json['wallet_seed'] as String,
  );
}

Map<String, dynamic> _$CreateWalletResponseToJson(
        CreateWalletResponse instance) =>
    <String, dynamic>{
      'session_token': instance.sessionToken,
      'wallet_seed': instance.walletSeed,
    };
