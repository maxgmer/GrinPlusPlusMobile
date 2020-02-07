import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grin_plus_plus/colors.dart';
import 'package:grin_plus_plus/screens/add_wallet/bloc/add_wallet_bloc.dart';
import 'package:grin_plus_plus/screens/wallet_choice/bloc/bloc.dart';
import 'package:grin_plus_plus/screens/wallet_choice/wallet_choice_screen.dart';

void main() {
  runApp(GrinPlusPlus());
}

class GrinPlusPlus extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Grin++',
      theme: ThemeData(
        fontFamily: 'Nunito',
        primaryColor: Colors.black,
        accentColor: kColorAccentGrey,
        scaffoldBackgroundColor: kColorBackgroundGrey,
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider<WalletChoiceBloc>(
            create: (BuildContext context) => WalletChoiceBloc(),
          ),
          BlocProvider<AddWalletBloc>(
            create: (BuildContext context) => AddWalletBloc(),
          ),
        ],
        child: WalletChoiceScreen(),
      ),
    );
  }
}