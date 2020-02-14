import 'package:equatable/equatable.dart';

class WalletScreenState extends Equatable {
  final bool refreshing;

  WalletScreenState({
    this.refreshing = false,
  });

  factory WalletScreenState.initial() {
    return WalletScreenState(
      refreshing: false,
    );
  }

  WalletScreenState copyWith({bool refreshing}) {
    return WalletScreenState(
      refreshing: refreshing ?? this.refreshing,
    );
  }

  @override
  List<Object> get props => [refreshing];
}