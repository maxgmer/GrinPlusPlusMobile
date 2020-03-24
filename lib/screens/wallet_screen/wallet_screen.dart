import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grin_plus_plus/models/wallet.dart';
import 'package:grin_plus_plus/screens/wallet_screen/bloc/bloc.dart';
import 'package:grin_plus_plus/screens/wallet_screen/bloc/wallet_screen_bloc.dart';
import 'package:grin_plus_plus/screens/wallet_screen/funds_block.dart';
import 'package:grin_plus_plus/screens/wallet_screen/refresh_button.dart';
import 'package:grin_plus_plus/screens/wallet_screen/transactions_list.dart';
import 'package:grin_plus_plus/screens/wallet_screen/wallet_screen_fab.dart';

class WalletScreen extends StatefulWidget {
  final Wallet wallet;

  WalletScreen(this.wallet);

  @override
  State<StatefulWidget> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  WalletScreenBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<WalletScreenBloc>(context);
    _bloc.add(RefreshWallet());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: FundsBlock(),
          ),
          Expanded(
            child: Stack(
              children: <Widget>[
                TransactionsList(),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 75),
                    child: RefreshButton(_bloc),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: WalletScreenFab(_bloc),
    );
  }
}