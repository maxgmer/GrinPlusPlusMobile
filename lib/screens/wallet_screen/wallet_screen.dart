import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grin_plus_plus/screens/wallet_screen/bloc/wallet_screen_bloc.dart';
import 'package:grin_plus_plus/screens/wallet_screen/buttons_block.dart';
import 'package:grin_plus_plus/screens/wallet_screen/funds_block.dart';
import 'package:grin_plus_plus/screens/wallet_screen/wallet_screen_fab.dart';
import 'package:grin_plus_plus/widgets/bottom_navigation_bar.dart';

class WalletScreen extends StatefulWidget {
  WalletScreen();

  @override
  State<StatefulWidget> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  WalletScreenBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<WalletScreenBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            FundsBlock(),
            ButtonsBlock(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: WalletScreenFab(_bloc),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.close();
  }
}