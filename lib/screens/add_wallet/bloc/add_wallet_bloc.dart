import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grin_plus_plus/models/wallet.dart';
import 'package:grin_plus_plus/screens/add_wallet/bloc/add_wallet_event.dart';
import 'package:grin_plus_plus/screens/add_wallet/bloc/add_wallet_state.dart';
import 'package:grin_plus_plus/strings.dart';

class AddWalletBloc extends Bloc<AddWalletEvent, AddWalletState> {
  @override
  AddWalletState get initialState => AddWalletState.initial();

  @override
  Stream<AddWalletState> mapEventToState(AddWalletEvent event) async* {
    if (event is CreateWallet) {
      String walletName = event.walletName;
      String password = event.password;
      String repeatPassword = event.repeatPassword;

      String nameError = _validateWalletName(walletName, event.existingWallets);
      String passwordError = _validatePassword(password, repeatPassword);

      if (nameError == null && passwordError == null) {
        yield state.copyWith(
          walletNameError: null,
          passwordError: null,
          wallet: Wallet(name: walletName),
        );
      } else {
        yield state.copyWith(
          walletNameError: nameError,
          passwordError: passwordError,
        );
      }
    }
    if (event is ResetState) {
      yield AddWalletState.initial();
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