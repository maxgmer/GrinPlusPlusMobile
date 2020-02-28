import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grin_plus_plus/screens/add_wallet/create_wallet_screen.dart';
import 'package:grin_plus_plus/screens/wallet_choice/bloc/bloc.dart';
import 'bloc/bloc.dart';

class AddWalletScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AddWalletScreenState();
}

class _AddWalletScreenState extends State<AddWalletScreen> {
  AddWalletBloc _bloc;
  WalletChoiceBloc _walletChoiceBloc;

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<AddWalletBloc>(context);
    _walletChoiceBloc = BlocProvider.of<WalletChoiceBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddWalletBloc, AddWalletState>(
      listener: (context, state) {
        if (state.walletCreatedSuccessfully) {
          _walletChoiceBloc.add(NewWallet(state.newWallet));
          _bloc.add(ResetState());
        }
      },
      builder: (context, state) {
        switch (state.screen) {
          case AddWalletScreenState.creatingWallet: return CreateWalletScreen();
          case AddWalletScreenState.restoringWallet: return null;
          case AddWalletScreenState.showingSeed: return Text('showing seed');
          case AddWalletScreenState.verifyingSeed: return null;
        }
        return null;
      }
    );
  }
}