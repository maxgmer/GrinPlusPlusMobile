import 'package:flutter/material.dart';
import 'package:grin_plus_plus/screens/auth/auth_screen.dart';
import 'package:grin_plus_plus/screens/loading_screen.dart';

/// If a programmer opened a secure screen and user is not
/// authorized, instead of entering the secure screen user will be
/// sent here.
class AuthGateway extends StatefulWidget {
  final Widget secureScreen;

  AuthGateway(this.secureScreen);

  @override
  State<StatefulWidget> createState() => _AuthGatewayState();
}

enum AuthResult {success, loading, beforeInput}
class _AuthGatewayState extends State<AuthGateway> {
  AuthResult _result = AuthResult.loading;

  @override
  Widget build(BuildContext context) {
    _imagineLikeUserJustEnteredSmthToAuth();
    switch(_result) {
      case AuthResult.success: return widget.secureScreen;
      case AuthResult.loading: return LoadingScreen();
      case AuthResult.beforeInput: return AuthScreen();
    }
    return AuthScreen();
  }

  void _imagineLikeUserJustEnteredSmthToAuth() {
    Future.delayed(Duration(seconds: 3)).then((_) {
      setState() {
        _result = AuthResult.success;
      }
    });
  }
}
