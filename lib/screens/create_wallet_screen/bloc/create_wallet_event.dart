import 'package:equatable/equatable.dart';
import 'package:grin_plus_plus/models/wallet.dart';

abstract class CreateWalletEvent extends Equatable {
  const CreateWalletEvent();

  @override
  List<Object> get props => [];
}

class CreateWallet extends CreateWalletEvent {
  final String walletName;
  final String password;
  final String repeatPassword;
  final List<Wallet> existingWallets;

  const CreateWallet(
      this.walletName,
      this.password,
      this.repeatPassword,
      this.existingWallets);

  @override
  List<Object> get props => [walletName, password, repeatPassword, existingWallets];
}
