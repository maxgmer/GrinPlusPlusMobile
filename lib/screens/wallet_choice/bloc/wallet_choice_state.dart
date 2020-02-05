import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:grin_plus_plus/models/wallet.dart';

class WalletChoiceState extends Equatable {
  final List<Wallet> wallets;

  WalletChoiceState({
    @required this.wallets,
  });

  factory WalletChoiceState.initial() {
    return WalletChoiceState(
      wallets: [],
    );
  }

  WalletChoiceState copyWith({List<Wallet> wallets}) {
    return WalletChoiceState(
      wallets: wallets ?? this.wallets,
    );
  }

  @override
  List<Object> get props => [wallets];
}