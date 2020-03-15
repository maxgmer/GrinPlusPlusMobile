import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grin_plus_plus/api/wallet_api/wallet_api.dart';
import 'package:grin_plus_plus/models/wallet_info.dart';
import 'package:grin_plus_plus/repositories/pending_notifications_repository.dart';
import 'package:grin_plus_plus/repositories/session_repository.dart';
import 'package:grin_plus_plus/screens/root_screen/bloc/bloc.dart';
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
    if (event is RefreshWallet) {
      if (state.refreshing) return;

      yield state.copyWith(refreshing: true);
      Session session = SessionRepository.currentSession;
      await repository.updateWallet(session.sessionToken);
      WalletInfo walletInfo = await repository.getWalletSummary(session.sessionToken);
      if (walletInfo != null) {
        yield state.copyWith(
          refreshing: false,
          transactions: walletInfo.transactions,
          total: walletInfo.total / 1000000000,
          immature: walletInfo.amountImmature / 1000000000,
          unconfirmed: walletInfo.amountAwaitingConfirmation / 1000000000,
          locked: walletInfo.amountLocked / 1000000000,
          spendable: walletInfo.amountCurrentlySpendable / 1000000000,
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