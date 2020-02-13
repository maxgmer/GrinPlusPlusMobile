import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grin_plus_plus/screens/root_screen/bloc/bloc.dart';
import 'package:grin_plus_plus/screens/root_screen/screens.dart';

class RootBloc extends Bloc<RootEvent, RootState> {
  @override
  RootState get initialState => RootState.initial();

  @override
  Stream<RootState> mapEventToState(RootEvent event) async* {
    if (event is AppPaused) {
      yield state.copyWith(currentScreen: Screen.walletChoiceScreen);
    }
    if (event is ChangeScreen) {
      Map<Screen, Object> screenData;
      if (event.additionalData != null) {
        screenData = Map.from(state.screenData);
        screenData[event.screen] = event.additionalData;
      }
      yield state.copyWith(
        currentScreen: event.screen,
        screenData: screenData,
      );
    }
  }
}