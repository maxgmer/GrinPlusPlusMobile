import 'package:equatable/equatable.dart';
import 'package:grin_plus_plus/models/wallet.dart';

enum AddWalletScreenState {
  creatingWallet,
  restoringWallet,
  showingSeed,
  verifyingSeed,
}
class AddWalletState extends Equatable {
  final Wallet newWallet;
  final String walletNameError;
  final String passwordError;
  final bool walletCreatedSuccessfully;
  final String seed;
  final AddWalletScreenState screen;

  AddWalletState({
    this.newWallet,
    this.walletNameError,
    this.passwordError,
    this.walletCreatedSuccessfully,
    this.seed,
    this.screen,
  });

  factory AddWalletState.initial() {
    return AddWalletState(
      walletCreatedSuccessfully: false,
      screen: AddWalletScreenState.creatingWallet,
    );
  }

  AddWalletState copyWith({Wallet wallet, String walletNameError,
    String passwordError, bool walletCreatedSuccessfully, String seed,
    AddWalletScreenState screen}) {
    return AddWalletState(
      newWallet: wallet ?? this.newWallet,
      walletNameError: walletNameError,
      passwordError: passwordError,
      walletCreatedSuccessfully: walletCreatedSuccessfully ?? this.walletCreatedSuccessfully,
      seed: seed ?? this.seed,
      screen: screen ?? this.screen,
    );
  }

  @override
  List<Object> get props => [
    walletNameError,
    passwordError,
    newWallet,
    seed,
    screen,
  ];
}