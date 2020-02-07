import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:grin_plus_plus/models/wallet.dart';

class WalletChoiceState extends Equatable {
  final List<Wallet> wallets;
  final bool addButtonPressed;

  WalletChoiceState({
    @required this.wallets,
    this.addButtonPressed = false,
  });

  factory WalletChoiceState.initial() {
    return WalletChoiceState(
      wallets: [],
    );
  }

  WalletChoiceState copyWith({List<Wallet> wallets, bool addButtonPressed}) {
    return WalletChoiceState(
      wallets: wallets ?? this.wallets,
      addButtonPressed: addButtonPressed ?? this.addButtonPressed,
    );
  }

  @override
  List<Object> get props => [wallets, addButtonPressed];
}