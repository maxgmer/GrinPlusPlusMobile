import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grin_plus_plus/api/wallet_api/responses/restore_wallet_response.dart';
import 'package:grin_plus_plus/api/wallet_api/wallet_api.dart';
import 'package:grin_plus_plus/models/wallet.dart';
import 'package:grin_plus_plus/repositories/pending_notifications_repository.dart';
import 'package:grin_plus_plus/screens/restore_wallet_screen/bloc/bloc.dart';
import 'package:grin_plus_plus/screens/root_screen/bloc/bloc.dart';
import 'package:grin_plus_plus/screens/screens.dart';
import 'package:grin_plus_plus/screens/wallet_choice_screen/bloc/bloc.dart';
import 'package:grin_plus_plus/screens/wallet_choice_screen/bloc/wallet_choice_bloc.dart';
import 'package:grin_plus_plus/strings.dart';

class RestoreWalletBloc extends Bloc<RestoreWalletEvent, RestoreWalletState> {
  final RootBloc rootBloc;
  final WalletChoiceBloc walletChoiceBloc;
  final WalletApi repository;

  RestoreWalletBloc({
    @required this.rootBloc,
    @required this.repository,
    @required this.walletChoiceBloc,
  });

  @override
  RestoreWalletState get initialState => RestoreWalletState.initial();

  @override
  Stream<RestoreWalletState> mapEventToState(RestoreWalletEvent event) async* {
    if (event is SetSeedWordsNumber) {
      yield state.copyWith(seedWordsNumber: event.seedWordsNumber);
    }
    if (event is RestoreWallet) {
      String walletError = _validateWalletName(event.walletName, event.existingWallets);
      String passwordError = _validatePassword(event.password);

      if (walletError == null && passwordError == null) {
        RestoreWalletResponse response = await repository.restoreWallet(
          event.walletName, event.password,
          event.seedWords.fold('', ((word1, word2) => '$word1 $word2')).trim(),
        );
        if (response != null) {
          repository.updateWallet(response.sessionToken);
          NotificationsRepository.showNotification(Notification(
            title: kSuccessString,
            message: kWalletRestoredString,
            notificationType: NotificationType.success,
          ));
          walletChoiceBloc.add(LoadWallets());
          rootBloc.add(ChangeScreen(Screen.walletChoiceScreen));
          yield initialState;
        }
      } else {
        yield state.copyWith(
          walletNameError: walletError,
          passwordError: passwordError,
        );
      }
    }
  }

  String _validateWalletName(String walletName, List<Wallet> existingWallets) {
    if (walletName == null || walletName.length == 0) {
      return kWalletNeedsNameString;
    }
    for (Wallet wallet in existingWallets) {
      if (wallet.name == walletName) {
        return kWalletWithSuchNameExistsString;
      }
    }
    return null;
  }

  String _validatePassword(String password) {
    if (password == null || password.length == 0) {
      return kPasswordCannotBeEmptyString;
    }
    return null;
  }
}