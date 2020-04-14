import 'package:equatable/equatable.dart';
import 'package:grin_plus_plus/models/transaction.dart';

class WalletScreenState extends Equatable {
  final bool refreshing;
  final List<Transaction> transactions;
  final Transaction selectedTransaction;
  final double total;
  final double immature;
  final double unconfirmed;
  final double locked;
  final double spendable;

  WalletScreenState({
    this.refreshing = false,
    this.transactions,
    this.selectedTransaction,
    this.total,
    this.immature,
    this.unconfirmed,
    this.locked,
    this.spendable,
  });

  factory WalletScreenState.initial() {
    return WalletScreenState(
      refreshing: false,
      transactions: [],
      selectedTransaction: null,
      total: 0,
      immature: 0,
      unconfirmed: 0,
      locked: 0,
      spendable: 0,
    );
  }

  WalletScreenState copyWith({bool refreshing, List<Transaction> transactions,
    double total, double immature, double unconfirmed, double locked, double spendable,
    Transaction selectedTransaction}) {
    return WalletScreenState(
      refreshing: refreshing ?? this.refreshing,
      transactions: transactions ?? this.transactions,
      selectedTransaction: selectedTransaction ?? this.selectedTransaction,
      total: total ?? this.total,
      immature: immature ?? this.immature,
      unconfirmed: unconfirmed ?? this.unconfirmed,
      locked: locked ?? this.locked,
      spendable: spendable ?? this.spendable,
    );
  }

  @override
  List<Object> get props => [
    refreshing,
    transactions,
    selectedTransaction,
    total,
    immature,
    unconfirmed,
    locked,
    spendable,
  ];
}