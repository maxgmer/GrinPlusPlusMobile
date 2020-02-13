import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grin_plus_plus/strings.dart';
import 'bloc/bloc.dart';

class WalletScreenFab extends StatelessWidget {
  final WalletScreenBloc bloc;

  WalletScreenFab(this.bloc);

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return BlocBuilder<WalletScreenBloc, WalletScreenState>(
            builder: (context, state) {
              Function onPressed;
              IconData icon;
              if (state.showingWalletInfo) {
                onPressed = () => bloc.add(HideWalletInfo());
                icon = Icons.arrow_back;
              } else {
                onPressed = () => bloc.add(ShowWalletInfo());
                icon = Icons.info_outline;
              }
              return FloatingActionButton(
                onPressed: onPressed,
                child: Icon(icon, color: Colors.black),
                tooltip: kAddWalletString,
              );
            }
        );
      },
    );
  }
}