import 'package:equatable/equatable.dart';

abstract class AddWalletEvent extends Equatable {
  const AddWalletEvent();

  @override
  List<Object> get props => [];
}

class CreateWallet extends AddWalletEvent {
  final String walletName;
  final String password;

  const CreateWallet(this.walletName, this.password);

  @override
  List<Object> get props => [walletName, password];
}
