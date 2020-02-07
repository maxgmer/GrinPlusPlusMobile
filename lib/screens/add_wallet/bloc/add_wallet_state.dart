import 'package:equatable/equatable.dart';
import 'package:grin_plus_plus/models/wallet.dart';

class AddWalletState extends Equatable {
  final Wallet newWallet;
  final String walletNameError;
  final String passwordError;

  AddWalletState({
    this.newWallet,
    this.walletNameError,
    this.passwordError,
  });

  factory AddWalletState.initial() {
    return AddWalletState();
  }

  AddWalletState copyWith({Wallet wallet, String walletNameError, String passwordError}) {
    return AddWalletState(
      newWallet: wallet ?? this.newWallet,
      walletNameError: walletNameError,
      passwordError: passwordError,
    );
  }

  @override
  List<Object> get props => [walletNameError, passwordError, newWallet];
}