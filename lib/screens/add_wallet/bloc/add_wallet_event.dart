import 'package:equatable/equatable.dart';
import 'package:grin_plus_plus/models/wallet.dart';

abstract class AddWalletEvent extends Equatable {
  const AddWalletEvent();

  @override
  List<Object> get props => [];
}

class ResetState extends AddWalletEvent {}
class CreateWalletLoginAndPassword extends AddWalletEvent {
  final String walletName;
  final String password;
  final String repeatPassword;
  final List<Wallet> existingWallets;

  const CreateWalletLoginAndPassword(
      this.walletName,
      this.password,
      this.repeatPassword,
      this.existingWallets);

  @override
  List<Object> get props => [walletName, password, repeatPassword, existingWallets];
}
