import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grin_plus_plus/colors.dart';
import 'package:grin_plus_plus/screens/wallet_screen/bloc/bloc.dart';
import 'package:grin_plus_plus/screens/wallet_screen/bloc/wallet_screen_bloc.dart';
import 'package:grin_plus_plus/screens/wallet_screen/funds_block.dart';
import 'package:grin_plus_plus/screens/wallet_screen/refresh_button.dart';
import 'package:grin_plus_plus/screens/wallet_screen/transactions_list.dart';
import 'package:grin_plus_plus/screens/wallet_screen/tx_details_panel.dart';
import 'package:grin_plus_plus/screens/wallet_screen/wallet_screen_fab.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class WalletScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  WalletScreenBloc _bloc;
  PanelController _panelController;

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<WalletScreenBloc>(context);
    _panelController = PanelController();
    _bloc.add(RefreshWallet());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SlidingUpPanel(
        minHeight: 0.0,
        maxHeight: MediaQuery.of(context).size.height * 0.9,
        controller: _panelController,
        color: kColorBackgroundGrey,
        backdropTapClosesPanel: true,
        backdropEnabled: true,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(60),
          topRight: Radius.circular(60),
        ),
        panel: TxDetailsPanel(_panelController),
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
                  TransactionsList(_bloc, _panelController),
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
      ),
      floatingActionButton: WalletScreenFab(_bloc),
    );
  }
}