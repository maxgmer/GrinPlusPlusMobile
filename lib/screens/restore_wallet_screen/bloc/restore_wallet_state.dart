import 'package:equatable/equatable.dart';

class RestoreWalletState extends Equatable {
  final int seedWordsNumber;
  final String walletNameError;
  final String passwordError;

  RestoreWalletState({
    this.seedWordsNumber = 24,
    this.walletNameError,
    this.passwordError,
  });

  factory RestoreWalletState.initial() {
    return RestoreWalletState();
  }

  RestoreWalletState copyWith({
    int seedWordsNumber,
    String walletNameError,
    String passwordError,
  }) {
    return RestoreWalletState(
      seedWordsNumber: seedWordsNumber ?? this.seedWordsNumber,
      walletNameError: walletNameError ?? this.walletNameError,
      passwordError: passwordError ?? this.passwordError,
    );
  }

  @override
  List<Object> get props => [
    seedWordsNumber,
    walletNameError,
    passwordError,
  ];
}