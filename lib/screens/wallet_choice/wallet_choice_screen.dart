import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grin_plus_plus/screens/root_screen/bloc/bloc.dart';
import 'package:grin_plus_plus/screens/screens.dart';
import 'package:grin_plus_plus/screens/wallet_choice/bloc/bloc.dart';
import 'package:grin_plus_plus/screens/wallet_choice/wallets_list_widget.dart';
import 'package:grin_plus_plus/screens/wallet_choice/welcome_screen_widget.dart';
import 'package:grin_plus_plus/strings.dart';

class WalletChoiceScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _WalletChoiceScreenState();
}

class _WalletChoiceScreenState extends State<WalletChoiceScreen> {
  RootBloc _rootBloc;
  WalletChoiceBloc _bloc;

  @override
  void initState() {
    super.initState();
    _rootBloc = BlocProvider.of<RootBloc>(context);
    _bloc = BlocProvider.of<WalletChoiceBloc>(context);
    _bloc.add(LoadWallets());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<WalletChoiceBloc, WalletChoiceState>(
        builder: (context, state) {
          if (state.wallets.length == 0) {
            return WelcomeScreen();
          } else {
            return WalletsList(state.wallets);
          }
        }
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _rootBloc.add(ChangeScreen(Screen.createWalletScreen)),
        child: Icon(
          Icons.add,
          color: Colors.black,
        ),
        tooltip: kAddWalletString,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}