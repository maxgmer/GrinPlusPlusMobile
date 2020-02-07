import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grin_plus_plus/screens/wallet_choice/bloc/bloc.dart';

class WalletChoiceBloc extends Bloc<WalletChoiceEvent, WalletChoiceState> {
  @override
  WalletChoiceState get initialState => WalletChoiceState.initial();

  @override
  Stream<WalletChoiceState> mapEventToState(WalletChoiceEvent event) async* {
    if (event is AddWallet) {
      yield state.copyWith(addButtonPressed: true);
    }
    if (event is ReturnToMainScreen) {
      yield state.copyWith(addButtonPressed: false);
    }
  }
}