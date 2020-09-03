import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'transfer_response.g.dart';

@JsonSerializable()
class TransferResponse extends Equatable {
  final String status;
  final Map<String, dynamic> slate;

  TransferResponse({
    this.status,
    this.slate,
  });

  @override
  List<Object> get props => [status, slate];

  factory TransferResponse.fromJson(Map<String, dynamic> json) =>
      _$TransferResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TransferResponseToJson(this);
}