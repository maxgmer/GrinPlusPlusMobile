import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc.dart';

class SendScreenBloc extends Bloc<SendScreenEvent, SendScreenState> {
  SendScreenBloc();

  @override
  SendScreenState get initialState => SendScreenState.initial();

  @override
  Stream<SendScreenState> mapEventToState(SendScreenEvent event) async* {
    if (event is ChangeTransportType) {
      yield state.copyWith(transportType: event.transportType);
    }
  }
}