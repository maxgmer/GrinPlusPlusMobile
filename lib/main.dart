import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grin_plus_plus/colors.dart';
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
        accentColor: kColorAccentGrey,
        scaffoldBackgroundColor: kColorBackgroundGrey,
      ),
      home: BlocProvider(
        create: (BuildContext context) => WalletChoiceBloc(),
        child: WalletChoiceScreen(),
      ),
    );
  }
}