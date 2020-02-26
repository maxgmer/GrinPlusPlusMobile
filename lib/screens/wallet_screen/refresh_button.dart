import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grin_plus_plus/colors.dart';
import 'package:grin_plus_plus/screens/wallet_screen/bloc/bloc.dart';

class RefreshButton extends StatelessWidget {
  final WalletScreenBloc bloc;

  RefreshButton(this.bloc);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WalletScreenBloc, WalletScreenState>(
      builder: (context, state) {
        Widget content;
        if (state.refreshing) {
          content = CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(kColorAlmostWhite),
            backgroundColor: Colors.transparent,
            strokeWidth: 2,
          );
        } else {
          content = Icon(
            Icons.refresh,
            size: 30,
            color: kColorAlmostWhite,
          );
        }
        return InkWell(
          onTap: () => bloc.add(RefreshWallet()),
          borderRadius: BorderRadius.circular(100),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: content,
          ),
        );
      },
    );
  }
}