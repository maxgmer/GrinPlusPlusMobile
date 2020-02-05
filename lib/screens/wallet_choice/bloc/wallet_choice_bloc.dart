import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grin_plus_plus/models/wallet.dart';
import 'package:grin_plus_plus/screens/wallet_choice/bloc/bloc.dart';

class WalletChoiceBloc extends Bloc<WalletChoiceEvent, WalletChoiceState> {
  @override
  WalletChoiceState get initialState => WalletChoiceState.initial();

  @override
  Stream<WalletChoiceState> mapEventToState(WalletChoiceEvent event) async* {
    if (event is CreateWallet) {
      yield state.copyWith(
        wallets: state.wallets..add(
          Wallet(name: 'New wallet'),
        ),
      );
    }
  }
}