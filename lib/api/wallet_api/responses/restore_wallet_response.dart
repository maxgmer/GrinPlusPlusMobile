import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'restore_wallet_response.g.dart';

@JsonSerializable()
class RestoreWalletResponse extends Equatable {
  @JsonKey(name: 'session_token')
  final String sessionToken;

  RestoreWalletResponse({
    this.sessionToken,
  });

  @override
  List<Object> get props => [sessionToken];

  factory RestoreWalletResponse.fromJson(Map<String, dynamic> json) =>
      _$RestoreWalletResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RestoreWalletResponseToJson(this);
}