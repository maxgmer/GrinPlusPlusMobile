import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_boom_menu/flutter_boom_menu.dart';
import 'package:grin_plus_plus/colors.dart';
import 'package:grin_plus_plus/screens/root_screen/bloc/bloc.dart';
import 'package:grin_plus_plus/screens/screens.dart';
import 'package:grin_plus_plus/strings.dart';
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
          title: kLogoutString,
          titleColor: kColorAlmostWhite,
          subtitle: kLogoutDescriptionString,
          subTitleColor: kColorGreyLight,
          backgroundColor: kColorBackgroundGrey,
          onTap: () => bloc.add(Logout()),
        ),
        MenuItem(
          child: Icon(Icons.done_all, color: kColorAlmostWhite),
          title: kFinalizeString,
          titleColor: kColorAlmostWhite,
          subtitle: kFinalizeDescriptionString,
          subTitleColor: kColorGreyLight,
          backgroundColor: kColorBackgroundGrey,
          onTap: () {},
        ),
        MenuItem(
          child: Icon(Icons.call_received, color: kColorAlmostWhite),
          title: kReceiveString,
          titleColor: kColorAlmostWhite,
          subtitle: kReceiveDescriptionString,
          subTitleColor: kColorGreyLight,
          backgroundColor: kColorBackgroundGrey,
          onTap: () {},
        ),
        MenuItem(
          child: Icon(Icons.send, color: kColorAlmostWhite),
          title: kSendString,
          titleColor: kColorAlmostWhite,
          subtitle: kSendDescriptionString,
          subTitleColor: kColorGreyLight,
          backgroundColor: kColorBackgroundGrey,
          onTap: () => BlocProvider.of<RootBloc>(context)
            ..add(ChangeScreen(Screen.sendScreen)),
        ),
      ],
    );
  }
}