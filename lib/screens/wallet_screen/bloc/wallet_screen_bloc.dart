import 'dart:async';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grin_plus_plus/api/wallet_api/wallet_api.dart';
import 'package:grin_plus_plus/models/wallet_info.dart';
import 'package:grin_plus_plus/repositories/pending_notifications_repository.dart';
import 'package:grin_plus_plus/repositories/session_repository.dart';
import 'package:grin_plus_plus/screens/root_screen/bloc/bloc.dart';
import 'package:grin_plus_plus/screens/screens.dart';
import 'package:grin_plus_plus/screens/wallet_screen/bloc/wallet_screen_event.dart';
import 'package:grin_plus_plus/screens/wallet_screen/bloc/wallet_screen_state.dart';
import 'package:grin_plus_plus/strings.dart';

class WalletScreenBloc extends Bloc<WalletScreenEvent, WalletScreenState> {
  final RootBloc rootBloc;
  final WalletApi repository;

  WalletScreenBloc({
    @required this.rootBloc,
    @required this.repository,
  });

  @override
  WalletScreenState get initialState => WalletScreenState.initial();

  @override
  Stream<WalletScreenState> mapEventToState(WalletScreenEvent event) async* {
    if (event is ResetState) {
      yield initialState;
    }
    if (event is Logout) {
      Session session = SessionRepository.currentSession;
      await repository.logout(session.sessionToken);
      rootBloc.add(ChangeScreen(Screen.walletChoiceScreen));
      yield initialState;
    }
    if (event is RefreshWallet) {
      if (state.refreshing) return;

      yield state.copyWith(refreshing: true);
      Session session = SessionRepository.currentSession;
      await repository.updateWallet(session.sessionToken);
      WalletInfo walletInfo = await repository.getWalletSummary(session.sessionToken);
      if (walletInfo != null) {
        walletInfo.transactions?.sort();
        yield state.copyWith(
          refreshing: false,
          transactions: walletInfo.transactions,
          total: walletInfo.total / pow(10, 9),
          immature: walletInfo.amountImmature / pow(10, 9),
          unconfirmed: walletInfo.amountAwaitingConfirmation / pow(10, 9),
          locked: walletInfo.amountLocked / pow(10, 9),
          spendable: walletInfo.amountCurrentlySpendable / pow(10, 9),
        );
      } else {
        NotificationsRepository.showNotification(Notification(
          title: kSomethingWentWrongString,
          message: kWalletNotRefreshedString,
          notificationType: NotificationType.failure,
        ));
        yield state.copyWith(refreshing: false);
      }
    }
  }
}