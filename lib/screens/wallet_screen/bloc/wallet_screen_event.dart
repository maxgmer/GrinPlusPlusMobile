import 'package:equatable/equatable.dart';
import 'package:grin_plus_plus/models/transaction.dart';

abstract class WalletScreenEvent extends Equatable {
  const WalletScreenEvent();

  @override
  List<Object> get props => [];
}
class ShowTxDetails extends WalletScreenEvent {
  final Transaction transaction;

  ShowTxDetails(this.transaction);

  @override
  List<Object> get props => [transaction];
}
class CancelTransaction extends WalletScreenEvent {
  final Transaction transaction;

  CancelTransaction(this.transaction);

  @override
  List<Object> get props => [transaction];
}
class RefreshWallet extends WalletScreenEvent {}
class Logout extends WalletScreenEvent {}
class ResetState extends WalletScreenEvent {}