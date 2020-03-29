import 'dart:async';
import 'dart:math';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grin_plus_plus/api/wallet_api/responses/estimate_fee_response.dart';
import 'package:grin_plus_plus/api/wallet_api/wallet_api.dart';
import 'package:grin_plus_plus/models/selection_strategy.dart';
import 'package:grin_plus_plus/repositories/session_repository.dart';
import 'package:grin_plus_plus/screens/root_screen/bloc/bloc.dart';
import 'bloc.dart';

class SendScreenBloc extends Bloc<SendScreenEvent, SendScreenState> {
  RootBloc rootBloc;
  WalletApi repository;

  SendScreenBloc({
    this.rootBloc,
    this.repository,
  });

  @override
  SendScreenState get initialState => SendScreenState.initial();

  @override
  Stream<SendScreenState> mapEventToState(SendScreenEvent event) async* {
    if (event is ChangeTransportType) {
      yield state.copyWith(transportType: event.transportType);
    }
    if (event is Send) {
      Session session = SessionRepository.currentSession;
      await repository.send(
        session.sessionToken,
        event.amount * pow(10, 9),
        SelectionStrategy.smallest,
        event.,
        message,
        grinJoin,
      );
    }
    if (event is AmountChanged) {
      Session session = SessionRepository.currentSession;
      EstimateFeeResponse response = await repository.estimateFee(
        session.sessionToken,
        ((event.amount ?? 0) * pow(10, 9)).round(),
        SelectionStrategy.smallest,
        [],
      );
      if (response.errorMessage == null) {
        if (event.amount == null || event.amount == 0) {
          yield state.copyWith(
            amountError: 'Amount cannot be 0',
            estimatedFee: 0,
          );
        } else {
          yield state.copyWith(
            amountError: '',
            estimatedFee: response.fee / pow(10, 9),
          );
        }
      } else {
        yield state.copyWith(
          amountError: response.errorMessage,
          estimatedFee: 0,
        );
      }
    }
  }
}