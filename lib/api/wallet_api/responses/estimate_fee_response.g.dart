// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'estimate_fee_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EstimateFeeResponse _$EstimateFeeResponseFromJson(Map<String, dynamic> json) {
  return EstimateFeeResponse(
    fee: json['fee'] as int,
    inputs: (json['inputs'] as List)
        ?.map((e) =>
            e == null ? null : InputOutput.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$EstimateFeeResponseToJson(
        EstimateFeeResponse instance) =>
    <String, dynamic>{
      'fee': instance.fee,
      'inputs': instance.inputs,
    };
