// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'foreign_receive_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ForeignReceiveResponse _$ForeignReceiveResponseFromJson(
    Map<String, dynamic> json) {
  return ForeignReceiveResponse(
    isSuccess: json['isSuccess'] as bool,
    slate: json['slate'] as Map<String, dynamic>,
    error: json['error'] as String,
  );
}

Map<String, dynamic> _$ForeignReceiveResponseToJson(
        ForeignReceiveResponse instance) =>
    <String, dynamic>{
      'isSuccess': instance.isSuccess,
      'slate': instance.slate,
      'error': instance.error,
    };
