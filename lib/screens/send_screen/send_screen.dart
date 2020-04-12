import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grin_plus_plus/models/wallet.dart';
import 'package:grin_plus_plus/screens/root_screen/bloc/bloc.dart';
import 'package:grin_plus_plus/screens/screens.dart';
import 'package:grin_plus_plus/screens/send_screen/bloc/bloc.dart';
import 'package:grin_plus_plus/screens/send_screen/file_saved_screen.dart';
import 'package:grin_plus_plus/screens/send_screen/transaction_fields.dart';
import 'package:grin_plus_plus/screens/send_screen/transport_choice_buttons.dart';
import 'package:grin_plus_plus/screens/wallet_screen/funds_block.dart';
import 'package:grin_plus_plus/strings.dart';

class SendScreen extends StatefulWidget {
  final Wallet wallet;

  SendScreen(this.wallet);

  @override
  State<StatefulWidget> createState() => _SendScreenState();
}

class _SendScreenState extends State<SendScreen> {
  RootBloc _rootBloc;
  SendScreenBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<SendScreenBloc>(context);
    _rootBloc = BlocProvider.of<RootBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SendScreenBloc, SendScreenState>(
      builder: (context, state) {
        if (state.transactionFilePath != null) {
          return TransactionFileSavedScreen(_bloc, state.transactionFilePath);
        }
        return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 24,
                  ),
                  child: FundsBlock(),
                ),
                Column(
                  children: <Widget>[
                    TransportChoiceButtons(),
                    TransactionFields(),
                  ],
                ),
              ],
            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          floatingActionButton: FloatingActionButton(
            onPressed: () => _rootBloc.add(ChangeScreen(Screen.walletScreen)),
            child: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            tooltip: kReturnToWalletString,
          ),
        );
      }
    );
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.close();
  }
}