import 'package:equatable/equatable.dart';
import 'package:grin_plus_plus/models/wallet.dart';

abstract class WalletChoiceEvent extends Equatable {
  const WalletChoiceEvent();

  @override
  List<Object> get props => [];
}

class AddWallet extends WalletChoiceEvent {}
class ReturnToMainScreen extends WalletChoiceEvent {}

class NewWallet extends WalletChoiceEvent {
  final Wallet wallet;

  NewWallet(this.wallet);

  @override
  List<Object> get props => [wallet];
}
