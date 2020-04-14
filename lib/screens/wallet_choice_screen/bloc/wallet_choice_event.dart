import 'package:equatable/equatable.dart';

abstract class WalletChoiceEvent extends Equatable {
  const WalletChoiceEvent();

  @override
  List<Object> get props => [];
}

class LoadWallets extends WalletChoiceEvent {}
