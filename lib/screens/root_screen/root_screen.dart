import 'dart:ui';
import 'package:achievement_view/achievement_view.dart';
import 'package:achievement_view/achievement_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grin_plus_plus/api/wallet_api/wallet_api.dart';
import 'package:grin_plus_plus/repositories/pending_notifications_repository.dart' as Notifications;
import 'package:grin_plus_plus/repositories/session_repository.dart';
import 'package:grin_plus_plus/screens/add_wallet/bloc/bloc.dart';
import 'package:grin_plus_plus/screens/root_screen/bloc/bloc.dart';
import 'package:grin_plus_plus/screens/screens.dart';
import 'package:grin_plus_plus/screens/send_screen/bloc/bloc.dart';
import 'package:grin_plus_plus/screens/send_screen/send_screen.dart';
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
    Notifications.NotificationsRepository.subscribe((Notifications.Notification notification) {
      return _showNotification(context, notification);
    });
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
                create: (BuildContext context) => AddWalletBloc(
                  repository: WalletApi(),
                ),
              ),
              BlocProvider<WalletScreenBloc>(
                create: (BuildContext context) => WalletScreenBloc(),
              ),
              BlocProvider<SendScreenBloc>(
                create: (BuildContext context) => SendScreenBloc(),
              ),
            ],
            child: BlocBuilder<RootBloc, RootState>(
              builder: (context, state) {
                switch (state.currentScreen) {
                  case Screen.walletChoiceScreen: return WalletChoiceScreen();
                  case Screen.walletScreen: return WalletScreen(state.screenData[Screen.walletScreen]);
                  case Screen.sendScreen: return SendScreen(state.screenData[Screen.sendScreen]);
                }
                throw UnimplementedError(kScreenNotImplementedString);
              },
            ),
          ),
        ),
      ],
    );
  }

  bool _canShowNotification = true;
  bool _showNotification(BuildContext context, Notifications.Notification notification) {
    if (!_canShowNotification) {
      return false;
    }
    _canShowNotification = false;
    AchievementView(
      context,
      title: notification.title,
      subTitle: notification.message,
      isCircle: false,
      icon: notification.icon,
      color: notification.color,
      typeAnimationContent: AnimationTypeAchievement.fade,
      textStyleTitle: notification.titleStyle,
      textStyleSubTitle: notification.messageStyle,
      listener: (status) {
        if (status == AchievementState.closed) {
          _canShowNotification = true;
        }
      },
    )..show();
    return true;
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
    SessionRepository.dispose();
    super.dispose();
  }
}