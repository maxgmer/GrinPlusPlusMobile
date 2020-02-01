import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class WalletChoiceState extends Equatable {
  final int counter;

  WalletChoiceState({
    @required this.counter,
  });

  factory WalletChoiceState.initial() {
    return WalletChoiceState(counter: 0);
  }

  WalletChoiceState copyWith({int counter}) {
    return WalletChoiceState(counter: counter ?? this.counter);
  }

  @override
  List<Object> get props => [counter];
}