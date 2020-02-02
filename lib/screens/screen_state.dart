import 'package:flutter/material.dart';
import 'package:grin_plus_plus/screens/auth/auth_gateway.dart';

abstract class GrinState<T extends StatefulWidget> extends State<T>
    with WidgetsBindingObserver {
  static bool _authorized = true;
  bool get isAuthorized => _authorized;
  
  @override
  Widget build(BuildContext context) {
    if (!_authorized && isSecure) {
      return AuthGateway(buildScreen(context));
    } else {
      return buildScreen(context);
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      _authorized = false;
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  Widget buildScreen(BuildContext context);

  bool get isSecure;
}