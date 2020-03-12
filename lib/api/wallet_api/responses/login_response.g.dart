// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginResponse _$LoginResponseFromJson(Map<String, dynamic> json) {
  return LoginResponse(
    sessionToken: json['session_token'] as String,
    torAddress: json['tor_address'] as String,
    listenerPort: json['listener_port'] as int,
  );
}

Map<String, dynamic> _$LoginResponseToJson(LoginResponse instance) =>
    <String, dynamic>{
      'session_token': instance.sessionToken,
      'tor_address': instance.torAddress,
      'listener_port': instance.listenerPort,
    };
