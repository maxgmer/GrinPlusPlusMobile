// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transfer_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransferResponse _$TransferResponseFromJson(Map<String, dynamic> json) {
  return TransferResponse(
    status: json['status'] as String,
    slate: json['slate'] as Map<String, dynamic>,
  );
}

Map<String, dynamic> _$TransferResponseToJson(TransferResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'slate': instance.slate,
    };
