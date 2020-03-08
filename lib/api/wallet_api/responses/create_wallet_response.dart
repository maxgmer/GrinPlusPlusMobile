import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'create_wallet_response.g.dart';

@JsonSerializable()
class CreateWalletResponse extends Equatable {
  @JsonKey(name: 'session_token')
  final String sessionToken;
  @JsonKey(name: 'wallet_seed')
  final String walletSeed;

  CreateWalletResponse({
    this.sessionToken,
    this.walletSeed,
  });

  @override
  List<Object> get props => [sessionToken, walletSeed];

  factory CreateWalletResponse.fromJson(Map<String, dynamic> json) =>
      _$CreateWalletResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CreateWalletResponseToJson(this);
}