import 'package:equatable/equatable.dart';

class CreateWalletState extends Equatable {
  final String walletNameError;
  final String passwordError;

  CreateWalletState({
    this.walletNameError,
    this.passwordError,
  });

  factory CreateWalletState.initial() {
    return CreateWalletState();
  }

  CreateWalletState copyWith({String walletNameError, String passwordError,
    bool walletCreatedSuccessfully, String newWalletSeed}) {
    return CreateWalletState(
      walletNameError: walletNameError,
      passwordError: passwordError,
    );
  }

  @override
  List<Object> get props => [
    walletNameError,
    passwordError,
  ];
}