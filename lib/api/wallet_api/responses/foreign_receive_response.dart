import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'foreign_receive_response.g.dart';

@JsonSerializable()
class ForeignReceiveResponse extends Equatable {
  final bool isSuccess;
  final Map<String, dynamic> slate;
  final String error;

  ForeignReceiveResponse({
    this.isSuccess,
    this.slate,
    this.error,
  });

  @override
  List<Object> get props => [
    isSuccess,
    slate,
    error,
  ];

  factory ForeignReceiveResponse.fromJson(Map<String, dynamic> json) =>
      _$ForeignReceiveResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ForeignReceiveResponseToJson(this);
}