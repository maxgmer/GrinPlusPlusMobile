import 'package:equatable/equatable.dart';

class CreateWalletState extends Equatable {
  final String walletNameError;
  final String passwordError;
  final String newWalletSeed;

  CreateWalletState({
    this.walletNameError,
    this.passwordError,
    this.newWalletSeed,
  });

  factory CreateWalletState.initial() {
    return CreateWalletState();
  }

  CreateWalletState copyWith({String walletNameError, String passwordError,
    bool walletCreatedSuccessfully, String newWalletSeed}) {
    return CreateWalletState(
      walletNameError: walletNameError,
      passwordError: passwordError,
      newWalletSeed: newWalletSeed ?? this.newWalletSeed,
    );
  }

  @override
  List<Object> get props => [
    walletNameError,
    passwordError,
    newWalletSeed,
  ];
}