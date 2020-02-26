import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grin_plus_plus/screens/add_wallet/add_wallet_screen.dart';
import 'package:grin_plus_plus/screens/wallet_choice/bloc/bloc.dart';
import 'package:grin_plus_plus/screens/wallet_choice/wallet_choice_fab.dart';
import 'package:grin_plus_plus/screens/wallet_choice/wallets_list_widget.dart';
import 'package:grin_plus_plus/screens/wallet_choice/welcome_screen_widget.dart';

class WalletChoiceScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _WalletChoiceScreenState();
}

class _WalletChoiceScreenState extends State<WalletChoiceScreen> {
  WalletChoiceBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<WalletChoiceBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocBuilder<WalletChoiceBloc, WalletChoiceState>(
        builder: (context, state) {
          if (state.addButtonPressed) {
            return AddWalletScreen();
          }

          if (state.wallets.length == 0) {
            return WelcomeScreen();
          } else {
            return WalletsList(state.wallets);
          }
        }
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: WalletChoiceFab(_bloc),
    );
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }
}