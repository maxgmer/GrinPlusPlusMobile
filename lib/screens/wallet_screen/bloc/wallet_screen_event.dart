import 'package:equatable/equatable.dart';

abstract class WalletScreenEvent extends Equatable {
  const WalletScreenEvent();

  @override
  List<Object> get props => [];
}

class RefreshWallet extends WalletScreenEvent {}
class Logout extends WalletScreenEvent {}
class ResetState extends WalletScreenEvent {}