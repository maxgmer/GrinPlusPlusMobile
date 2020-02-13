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
    if (event is ShowWalletInfo) {
      yield state.copyWith(showingWalletInfo: true);
    }
    if (event is HideWalletInfo) {
      yield state.copyWith(showingWalletInfo: false);
    }
  }
}