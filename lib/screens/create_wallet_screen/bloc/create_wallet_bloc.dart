import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grin_plus_plus/api/wallet_api/create_wallet_response.dart';
import 'package:grin_plus_plus/api/wallet_api/wallet_api.dart';
import 'package:grin_plus_plus/models/wallet.dart';
import 'package:grin_plus_plus/repositories/pending_notifications_repository.dart';
import 'package:grin_plus_plus/screens/create_wallet_screen/bloc/bloc.dart';
import 'package:grin_plus_plus/strings.dart';

class CreateWalletBloc extends Bloc<CreateWalletEvent, CreateWalletState> {
  final WalletApi repository;

  CreateWalletBloc({@required this.repository});

  @override
  CreateWalletState get initialState => CreateWalletState.initial();

  @override
  Stream<CreateWalletState> mapEventToState(CreateWalletEvent event) async* {
    if (event is CreateWallet) {
      String walletName = event.walletName;
      String password = event.password;
      String repeatPassword = event.repeatPassword;

      String nameError = _validateWalletName(walletName, event.existingWallets);
      String passwordError = _validatePassword(password, repeatPassword);

      if (nameError == null && passwordError == null) {
        CreateWalletResponse createWalletResponse = await repository.createWallet(walletName, password);
        if (createWalletResponse != null) {
          if (createWalletResponse.failedMessage != null) {
            NotificationsRepository.showNotification(Notification(
              title: kErrorString,
              message: createWalletResponse.failedMessage,
              notificationType: NotificationType.failure,
            ));
          }
          yield state.copyWith(
            walletNameError: null,
            passwordError: null,
            newWalletSeed: createWalletResponse.walletSeed,
          );
        }
      } else {
        yield state.copyWith(
          walletNameError: nameError,
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

  String _validatePassword(String password, String repeatPassword) {
    if (password == null || password.length < 4) {
      return kPasswordShortString;
    }
    if (password != repeatPassword) {
      return kPasswordsDontMatchString;
    }
    return null;
  }
}