// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Transaction _$TransactionFromJson(Map<String, dynamic> json) {
  return Transaction(
    amountCredited: json['amount_credited'] as int,
    amountDebited: json['amount_debited'] as int,
    confirmedHeight: json['confirmed_height'] as int,
    creationTime: json['creation_date_time'] as int,
    slateId: json['slate_id'] as String,
    slateMessage: json['slate_message'] as String,
    fee: json['fee'] as int,
    id: json['id'] as int,
    type: json['type'] as String,
    outputs: (json['outputs'] as List)
        ?.map((e) =>
            e == null ? null : InputOutput.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$TransactionToJson(Transaction instance) =>
    <String, dynamic>{
      'amount_credited': instance.amountCredited,
      'amount_debited': instance.amountDebited,
      'confirmed_height': instance.confirmedHeight,
      'creation_date_time': instance.creationTime,
      'slate_id': instance.slateId,
      'slate_message': instance.slateMessage,
      'fee': instance.fee,
      'id': instance.id,
      'type': instance.type,
      'outputs': instance.outputs,
    };
