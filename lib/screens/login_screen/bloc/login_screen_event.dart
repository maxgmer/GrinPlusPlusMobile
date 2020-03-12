import 'package:equatable/equatable.dart';

abstract class LoginScreenEvent extends Equatable {
  const LoginScreenEvent();

  @override
  List<Object> get props => [];
}

class Login extends LoginScreenEvent {
  final String walletName;
  final String password;

  Login(this.walletName, this.password);

  @override
  List<Object> get props => [walletName, password];
}
