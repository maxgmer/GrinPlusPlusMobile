import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grin_plus_plus/api/wallet_api/responses/login_response.dart';
import 'package:grin_plus_plus/api/wallet_api/wallet_api.dart';
import 'package:grin_plus_plus/repositories/session_repository.dart';
import 'package:grin_plus_plus/screens/root_screen/bloc/bloc.dart';
import 'package:grin_plus_plus/screens/screens.dart';
import 'package:grin_plus_plus/strings.dart';
import 'package:grin_plus_plus/utils/data_utils.dart';
import 'bloc.dart';

class LoginScreenBloc extends Bloc<LoginScreenEvent, LoginScreenState> {
  final RootBloc rootBloc;
  final WalletApi repository;

  LoginScreenBloc({
    @required this.rootBloc,
    @required this.repository,
  });

  @override
  LoginScreenState get initialState => LoginScreenState.initial();

  @override
  Stream<LoginScreenState> mapEventToState(LoginScreenEvent event) async* {
    if (event is Login) {
      String passwordError = _validatePassword(event.password);
      if (passwordError == null) {
        LoginResponse loginResponse = await repository.login(
            event.walletName, event.password);
        if (loginResponse != null) {
          SessionRepository.addSessionToken(Session(
            sessionToken: loginResponse.sessionToken,
            torAddress: loginResponse.torAddress,
            listenerPort: loginResponse.listenerPort,
          ));
          DataUtils.updateWalletLatestLoginTime(event.walletName);
          rootBloc.add(ChangeScreen(Screen.sendScreen));
          yield initialState;
        }
      } else {
        yield state.copyWith(passwordError: passwordError);
      }
    }
  }

  String _validatePassword(String password) {
    if (password == null || password.isEmpty) {
      return kPasswordCannotBeEmptyString;
    }
    return null;
  }
}