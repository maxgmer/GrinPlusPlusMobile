// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'send_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SendResponse _$SendResponseFromJson(Map<String, dynamic> json) {
  return SendResponse(
    status: json['status'] as String,
    slate: json['slate'] as Map<String, dynamic>,
  );
}

Map<String, dynamic> _$SendResponseToJson(SendResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'slate': instance.slate,
    };
