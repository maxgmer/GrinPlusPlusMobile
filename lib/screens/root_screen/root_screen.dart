import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grin_plus_plus/screens/add_wallet/bloc/bloc.dart';
import 'package:grin_plus_plus/screens/root_screen/bloc/bloc.dart';
import 'package:grin_plus_plus/screens/root_screen/screens.dart';
import 'package:grin_plus_plus/screens/wallet_choice/bloc/bloc.dart';
import 'package:grin_plus_plus/screens/wallet_choice/wallet_choice_screen.dart';
import 'package:grin_plus_plus/screens/wallet_screen/bloc/bloc.dart';
import 'package:grin_plus_plus/screens/wallet_screen/wallet_screen.dart';
import 'package:grin_plus_plus/strings.dart';
import 'package:grin_plus_plus/widgets/fade_animator.dart';

class RootScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> with WidgetsBindingObserver {
  RootBloc _mainBloc;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
    _mainBloc = BlocProvider.of<RootBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
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
          body: MultiBlocProvider(
            providers: [
              BlocProvider<WalletChoiceBloc>(
                create: (BuildContext context) => WalletChoiceBloc(),
              ),
              BlocProvider<AddWalletBloc>(
                create: (BuildContext context) => AddWalletBloc(),
              ),
              BlocProvider<WalletScreenBloc>(
                create: (BuildContext context) => WalletScreenBloc(),
              ),
            ],
            child: BlocBuilder<RootBloc, RootState>(
              builder: (context, state) {
                switch (state.currentScreen) {
                  case Screen.walletChoiceScreen: return WalletChoiceScreen();
                  case Screen.walletScreen: return WalletScreen();
                }
                throw UnimplementedError(kScreenNotImplementedString);
              },
            ),
          ),
        ),
      ],
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      _mainBloc.add(AppPaused());
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}