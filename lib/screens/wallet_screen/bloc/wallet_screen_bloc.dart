import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grin_plus_plus/screens/wallet_screen/bloc/wallet_screen_event.dart';
import 'package:grin_plus_plus/screens/wallet_screen/bloc/wallet_screen_state.dart';

class WalletScreenBloc extends Bloc<WalletScreenEvent, WalletScreenState> {
  WalletScreenBloc();

  @override
  WalletScreenState get initialState => WalletScreenState.initial();

  @override
  Stream<WalletScreenState> mapEventToState(WalletScreenEvent event) async* {
    if (event is RefreshWallet) {
      if (state.refreshing) return;

      yield state.copyWith(refreshing: true);
      await Future.delayed(Duration(seconds: 3));
      yield state.copyWith(refreshing: false);
    }
    if (event is ResetState) {
      yield initialState;
    }
  }
}