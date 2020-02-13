import 'package:equatable/equatable.dart';

abstract class WalletScreenEvent extends Equatable {
  const WalletScreenEvent();

  @override
  List<Object> get props => [];
}

class ShowWalletInfo extends WalletScreenEvent {}
class HideWalletInfo extends WalletScreenEvent {}