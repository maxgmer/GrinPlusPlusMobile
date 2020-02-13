import 'package:equatable/equatable.dart';

class WalletScreenState extends Equatable {
  final bool showingWalletInfo;

  WalletScreenState({
    this.showingWalletInfo,
  });

  factory WalletScreenState.initial() {
    return WalletScreenState(
      showingWalletInfo: false,
    );
  }

  WalletScreenState copyWith({bool showingWalletInfo}) {
    return WalletScreenState(
      showingWalletInfo: showingWalletInfo ?? this.showingWalletInfo,
    );
  }

  @override
  List<Object> get props => [showingWalletInfo];
}