import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grin_plus_plus/native_api/native_api.dart';
import 'package:grin_plus_plus/screens/wallet_choice/bloc/bloc.dart';

class WalletChoiceBloc extends Bloc<WalletChoiceEvent, WalletChoiceState> {
  @override
  WalletChoiceState get initialState => WalletChoiceState.initial();

  @override
  Stream<WalletChoiceState> mapEventToState(WalletChoiceEvent event) async* {
    if (event is LoadIncrementedCounter) {
      yield state.copyWith(counter: NativeApi.incrementAndLoadCounter());
    }
  }
}