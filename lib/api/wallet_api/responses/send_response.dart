import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'send_response.g.dart';

@JsonSerializable()
class SendResponse extends Equatable {
  final String status;
  final Map<String, dynamic> slate;

  SendResponse({
    this.status,
    this.slate,
  });

  @override
  List<Object> get props => [status, slate];

  factory SendResponse.fromJson(Map<String, dynamic> json) =>
      _$SendResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SendResponseToJson(this);
}