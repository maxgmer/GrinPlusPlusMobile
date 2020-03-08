// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'restore_wallet_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RestoreWalletResponse _$RestoreWalletResponseFromJson(
    Map<String, dynamic> json) {
  return RestoreWalletResponse(
    sessionToken: json['session_token'] as String,
  );
}

Map<String, dynamic> _$RestoreWalletResponseToJson(
        RestoreWalletResponse instance) =>
    <String, dynamic>{
      'session_token': instance.sessionToken,
    };
