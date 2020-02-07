import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grin_plus_plus/screens/add_wallet/add_wallet_screen.dart';
import 'package:grin_plus_plus/screens/screen_state.dart';
import 'package:grin_plus_plus/screens/wallet_choice/bloc/bloc.dart';
import 'package:grin_plus_plus/screens/wallet_choice/wallet_choice_fab.dart';
import 'package:grin_plus_plus/screens/wallet_choice/wallets_list_widget.dart';
import 'package:grin_plus_plus/screens/wallet_choice/welcome_screen_widget.dart';
import 'package:grin_plus_plus/widgets/bottom_navigation_bar.dart';
import 'package:grin_plus_plus/widgets/fade_animator.dart';

/// Screen where you open your existing wallet,
/// or create new/import existing one.
class WalletChoiceScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _WalletChoiceScreenState();
}

class _WalletChoiceScreenState extends GrinState<WalletChoiceScreen> {
  WalletChoiceBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<WalletChoiceBloc>(context);
  }

  @override
  Widget buildScreen(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocBuilder<WalletChoiceBloc, WalletChoiceState>(
        builder: (context, state) {
          return Stack(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  FadeAnimator(
                    startOpacity: 0,
                    endOpacity: 1,
                    duration: 15000,
                    delay: 5000,
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/images/anonymous.jpg"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Container(color: Colors.transparent),
                  ),
                  Scaffold(
                    backgroundColor: Colors.black.withOpacity(0.8),
                    body: Builder(
                      builder: (context) {
                        if (state.addButtonPressed) {
                          return AddWalletScreen();
                        }

                        if (state.wallets.length == 0) {
                          return WelcomeScreen();
                        } else {
                          return WalletsList(state.wallets);
                        }
                      },
                    ),
                    bottomNavigationBar: BottomNavBar(),
                    floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
                    floatingActionButton: WalletChoiceFab(_bloc),
                  ),
                ],
              ),
            ],
          );
        }
      ),
    );
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  @override
  bool get isSecure => false;
}