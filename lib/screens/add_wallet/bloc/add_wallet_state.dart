import 'package:equatable/equatable.dart';
import 'package:grin_plus_plus/models/wallet.dart';

class AddWalletState extends Equatable {
  final Wallet newWallet;
  final String walletNameError;
  final String passwordError;
  final bool walletCreatedSuccessfully;

  AddWalletState({
    this.newWallet,
    this.walletNameError,
    this.passwordError,
    this.walletCreatedSuccessfully,
  });

  factory AddWalletState.initial() {
    return AddWalletState(walletCreatedSuccessfully: false);
  }

  AddWalletState copyWith({Wallet wallet, String walletNameError,
    String passwordError, bool walletCreatedSuccessfully}) {
    return AddWalletState(
      newWallet: wallet ?? this.newWallet,
      walletNameError: walletNameError,
      passwordError: passwordError,
      walletCreatedSuccessfully: walletCreatedSuccessfully ?? this.walletCreatedSuccessfully,
    );
  }

  @override
  List<Object> get props => [walletNameError, passwordError, newWallet];
}