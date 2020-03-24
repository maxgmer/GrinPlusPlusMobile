import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_boom_menu/flutter_boom_menu.dart';
import 'package:grin_plus_plus/colors.dart';
import 'package:grin_plus_plus/screens/root_screen/bloc/bloc.dart';
import 'package:grin_plus_plus/screens/screens.dart';
import 'bloc/bloc.dart';

class WalletScreenFab extends StatelessWidget {
  final WalletScreenBloc bloc;

  WalletScreenFab(this.bloc);

  @override
  Widget build(BuildContext context) {
    return BoomMenu(
      overlayColor: Colors.black,
      overlayOpacity: 0.8,
      animatedIcon: AnimatedIcons.menu_close,
      fabAlignment: Alignment.center,
      children: [
        MenuItem(
          child: Icon(Icons.exit_to_app, color: kColorAlmostWhite),
          title: "Logout",
          titleColor: kColorAlmostWhite,
          subtitle: "Logout from current wallet",
          subTitleColor: kColorGreyLight,
          backgroundColor: kColorBackgroundGrey,
          onTap: () => bloc.add(Logout()),
        ),
        MenuItem(
          child: Icon(Icons.done_all, color: kColorAlmostWhite),
          title: "Finalize",
          titleColor: kColorAlmostWhite,
          subtitle: "Confirm the transaction you sent before",
          subTitleColor: kColorGreyLight,
          backgroundColor: kColorBackgroundGrey,
          onTap: () {},
        ),
        MenuItem(
          child: Icon(Icons.call_received, color: kColorAlmostWhite),
          title: "Receive",
          titleColor: kColorAlmostWhite,
          subtitle: "Receive grin from another person",
          subTitleColor: kColorGreyLight,
          backgroundColor: kColorBackgroundGrey,
          onTap: () {},
        ),
        MenuItem(
          child: Icon(Icons.send, color: kColorAlmostWhite),
          title: "Send",
          titleColor: kColorAlmostWhite,
          subtitle: "Send grin to another person",
          subTitleColor: kColorGreyLight,
          backgroundColor: kColorBackgroundGrey,
          onTap: () => BlocProvider.of<RootBloc>(context)
            ..add(ChangeScreen(Screen.sendScreen)),
        ),
      ],
    );
  }
}