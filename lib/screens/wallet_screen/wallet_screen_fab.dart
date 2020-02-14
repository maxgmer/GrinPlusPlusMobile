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
    return BlocBuilder<WalletScreenBloc, WalletScreenState>(
      builder: (context, state) {
        Widget fabContent;
        if (state.refreshing) {
          fabContent = Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
              backgroundColor: Colors.transparent,
              strokeWidth: 2,
            ),
          );
        } else {
          fabContent = Icon(Icons.refresh, color: Colors.black);
        }
        return FloatingActionButton(
          onPressed: () => bloc.add(RefreshWallet()),
          tooltip: kRefreshString,
          child: fabContent,
        );
      }
    );
  }
}