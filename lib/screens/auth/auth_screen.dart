import 'package:flutter/material.dart';
import 'package:grin_plus_plus/screens/screen_state.dart';

class AuthScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AuthScreenState();
}

class _AuthScreenState extends GrinState<AuthScreen> {
  @override
  Widget buildScreen(BuildContext context) {
    return Scaffold();
  }

  @override
  bool get isSecure => false;
}