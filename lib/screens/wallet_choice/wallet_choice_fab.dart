import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grin_plus_plus/screens/wallet_choice/bloc/bloc.dart';
import 'package:grin_plus_plus/strings.dart';

class WalletChoiceFab extends StatelessWidget {
  final WalletChoiceBloc bloc;

  WalletChoiceFab(this.bloc);

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return BlocBuilder<WalletChoiceBloc, WalletChoiceState>(
          builder: (context, state) {
            Function fabPressed;
            IconData fabIcon;
            if (state.addButtonPressed) {
              fabIcon = Icons.arrow_back;
              fabPressed = () => bloc.add(ReturnToMainScreen());
            } else {
              fabIcon = Icons.add;
              fabPressed = () => bloc.add(AddWallet());
            }

            return FloatingActionButton(
              onPressed: fabPressed,
              child: Icon(
                fabIcon,
                color: Colors.black,
              ),
              tooltip: kAddWalletString,
            );
          }
        );
      },
    );
  }
}