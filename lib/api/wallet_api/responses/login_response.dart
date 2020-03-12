import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'login_response.g.dart';

@JsonSerializable()
class LoginResponse extends Equatable {
  @JsonKey(name: 'session_token')
  final String sessionToken;
  @JsonKey(name: 'tor_address')
  final String torAddress;
  @JsonKey(name: 'listener_port')
  final int listenerPort;

  LoginResponse({
    this.sessionToken,
    this.torAddress,
    this.listenerPort,
  });

  @override
  List<Object> get props => [
    sessionToken,
    torAddress,
    listenerPort,
  ];

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}