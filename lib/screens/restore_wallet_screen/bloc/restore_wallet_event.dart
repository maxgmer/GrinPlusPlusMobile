import 'package:equatable/equatable.dart';
import 'package:grin_plus_plus/models/wallet.dart';

abstract class RestoreWalletEvent extends Equatable {
  const RestoreWalletEvent();

  @override
  List<Object> get props => [];
}
class RestoreWallet extends RestoreWalletEvent {
  final String walletName;
  final String password;
  final List<String> seedWords;
  final List<Wallet> existingWallets;

  RestoreWallet({
    this.walletName,
    this.password,
    this.seedWords,
    this.existingWallets,
  });

  @override
  List<Object> get props => [
    walletName,
    password,
    seedWords,
    existingWallets,
  ];
}
class SetSeedWordsNumber extends RestoreWalletEvent {
  final int seedWordsNumber;

  SetSeedWordsNumber(this.seedWordsNumber);

  @override
  List<Object> get props => [seedWordsNumber];
}