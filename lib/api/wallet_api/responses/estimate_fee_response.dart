import 'package:equatable/equatable.dart';
import 'package:grin_plus_plus/models/commitment.dart';
import 'package:json_annotation/json_annotation.dart';

part 'estimate_fee_response.g.dart';

@JsonSerializable()
class EstimateFeeResponse extends Equatable {
  @JsonKey(name: 'fee')
  final int fee;
  @JsonKey(name: 'inputs')
  final List<Commitment> inputs;
  @JsonKey(ignore: true)
  final String errorMessage;

  EstimateFeeResponse({
    this.fee,
    this.inputs,
    this.errorMessage,
  });

  @override
  List<Object> get props => [
    fee,
    inputs,
    errorMessage,
  ];

  factory EstimateFeeResponse.fromJson(Map<String, dynamic> json) =>
      _$EstimateFeeResponseFromJson(json);

  Map<String, dynamic> toJson() => _$EstimateFeeResponseToJson(this);
}