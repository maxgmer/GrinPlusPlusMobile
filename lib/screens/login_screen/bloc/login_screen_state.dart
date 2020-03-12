import 'package:equatable/equatable.dart';

class LoginScreenState extends Equatable {
  final String passwordError;

  LoginScreenState({
    this.passwordError,
  });

  factory LoginScreenState.initial() {
    return LoginScreenState();
  }

  LoginScreenState copyWith({String passwordError}) {
    return LoginScreenState(
      passwordError: passwordError ?? this.passwordError,
    );
  }

  @override
  List<Object> get props => [passwordError];
}