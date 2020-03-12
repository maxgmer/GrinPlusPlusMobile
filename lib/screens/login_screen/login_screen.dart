import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grin_plus_plus/colors.dart';
import 'package:grin_plus_plus/screens/login_screen/bloc/bloc.dart';
import 'package:grin_plus_plus/screens/root_screen/bloc/bloc.dart';
import 'package:grin_plus_plus/screens/screens.dart';
import 'package:grin_plus_plus/strings.dart';
import 'package:grin_plus_plus/widgets/fade_in.dart';
import 'package:grin_plus_plus/widgets/text_field.dart';

class LoginScreen extends StatefulWidget {
  final String walletName;

  LoginScreen(this.walletName);

  @override
  State<StatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  RootBloc _rootBloc;
  LoginScreenBloc _bloc;
  TextEditingController _walletNameController;
  TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _rootBloc = BlocProvider.of<RootBloc>(context);
    _bloc = BlocProvider.of<LoginScreenBloc>(context);
    _walletNameController = TextEditingController(text: widget.walletName);
    _passwordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        constraints: BoxConstraints.expand(),
        child: Center(
          child: SingleChildScrollView(
            child: FadeIn(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(bottom: 30),
                      child: Text(
                        kLoginString,
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w200,
                          color: kColorAlmostWhite,
                        ),
                      ),
                    ),
                    BlocBuilder<LoginScreenBloc, LoginScreenState>(
                      builder: (context, state) => Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            child: BorderedTextField(
                              enabled: false,
                              boxColor: kColorAlmostWhite,
                              labelColor: kColorAlmostWhite,
                              labelText: kWalletNameString,
                              controller: _walletNameController,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            child: BorderedTextField(
                              boxColor: state.passwordError == null
                                  ? kColorAlmostWhite
                                  : kColorErrorRed,
                              labelColor: state.passwordError == null
                                  ? kColorAlmostWhite
                                  : kColorErrorRed,
                              labelText: state.passwordError == null
                                  ? kPasswordString
                                  : state.passwordError,
                              controller: _passwordController,
                              obscureText: true,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 24, top: 16),
                            child: IconButton(
                              onPressed: () => _bloc.add(Login(
                                _walletNameController.text,
                                _passwordController.text,
                              )),
                              tooltip: kLoginString,
                              icon: Icon(Icons.check, color: kColorAlmostWhite, size: 30),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.arrow_back),
        onPressed: () => _rootBloc.add(ChangeScreen(Screen.walletChoiceScreen)),
      ),
    );
  }
}