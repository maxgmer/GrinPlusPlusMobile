import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grin_plus_plus/api/wallet_api/wallet_api.dart';
import 'package:grin_plus_plus/models/wallet.dart';
import 'package:grin_plus_plus/screens/wallet_choice_screen/bloc/bloc.dart';
import 'package:grin_plus_plus/utils/data_utils.dart';

class WalletChoiceBloc extends Bloc<WalletChoiceEvent, WalletChoiceState> {
  final WalletApi repository;

  WalletChoiceBloc({this.repository});

  @override
  WalletChoiceState get initialState => WalletChoiceState.initial();

  @override
  Stream<WalletChoiceState> mapEventToState(WalletChoiceEvent event) async* {
    if (event is LoadWallets) {
      List<String> walletNames = await repository.getWallets();
      List<Wallet> wallets = [];
      for (String walletName in walletNames) {
        String latestLoginTime = DataUtils.loadWalletLatestLoginTime(walletName);
        wallets.add(Wallet(
          name: walletName,
          lastTimeVisited: latestLoginTime != null
              ? DateTime.parse(latestLoginTime)
              : null,
        ));
      }
      yield state.copyWith(wallets: wallets);
    }
  }
}