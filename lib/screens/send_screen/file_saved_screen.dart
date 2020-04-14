import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grin_plus_plus/colors.dart';
import 'package:grin_plus_plus/screens/send_screen/bloc/bloc.dart';
import 'package:grin_plus_plus/screens/wallet_screen/bloc/bloc.dart';
import 'package:grin_plus_plus/strings.dart';

class TransactionFileSavedScreen extends StatelessWidget {
  final String txFilePath;

  TransactionFileSavedScreen(this.txFilePath);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          child: Text(
            '$kTxFileSavedToString $txFilePath.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              color: kColorAlmostWhite,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          BlocProvider.of<WalletScreenBloc>(context).add(RefreshWallet());
          BlocProvider.of<SendScreenBloc>(context).add(AcknowledgeTxFilePath());
        },
        child: Icon(
          Icons.done,
          color: Colors.black,
        ),
        tooltip: kOkString,
      ),
    );
  }
}