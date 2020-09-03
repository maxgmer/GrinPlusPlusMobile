// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'input_output.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InputOutput _$InputOutputFromJson(Map<String, dynamic> json) {
  return InputOutput(
    amount: json['amount'] as int,
    blockHeight: json['block_height'] as int,
    keychainPath: json['keychain_path'] as String,
    commitment: json['commitment'] as String,
    status: json['status'] as String,
    transactionId: json['transaction_id'] as int,
    label: json['label'] as String,
    mmrIndex: json['mmr_index'] as int,
  );
}

Map<String, dynamic> _$InputOutputToJson(InputOutput instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'block_height': instance.blockHeight,
      'keychain_path': instance.keychainPath,
      'commitment': instance.commitment,
      'status': instance.status,
      'transaction_id': instance.transactionId,
      'label': instance.label,
      'mmr_index': instance.mmrIndex,
    };
