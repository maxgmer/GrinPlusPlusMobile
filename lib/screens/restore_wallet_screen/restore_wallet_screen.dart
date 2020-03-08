import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grin_plus_plus/colors.dart';
import 'package:grin_plus_plus/screens/restore_wallet_screen/bloc/bloc.dart';
import 'package:grin_plus_plus/screens/restore_wallet_screen/restore_wallet_fields_block.dart';
import 'package:grin_plus_plus/screens/root_screen/bloc/bloc.dart';
import 'package:grin_plus_plus/screens/screens.dart';
import 'package:grin_plus_plus/strings.dart';
import 'package:grin_plus_plus/widgets/fade_in.dart';

class RestoreWalletScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RestoreWalletScreenState();
}

class _RestoreWalletScreenState extends State<RestoreWalletScreen> {
  RootBloc _rootBloc;
  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _rootBloc = BlocProvider.of<RootBloc>(context);
    _scrollController = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RestoreWalletBloc, RestoreWalletState>(
      listener: (context, state) {
        if (state.walletNameError != null || state.passwordError != null) {
          _scrollController.animateTo(0,
              duration: Duration(milliseconds: 500), curve: Curves.ease);
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          constraints: BoxConstraints.expand(),
          child: Center(
            child: SingleChildScrollView(
              controller: _scrollController,
              child: FadeIn(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        child: Text(
                          kRestoreAWalletString,
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.w200,
                            color: kColorAlmostWhite,
                          ),
                        ),
                      ),
                      RestoreWalletFieldsBlock(),
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
          onPressed: () => _rootBloc.add(ChangeScreen(Screen.createWalletScreen)),
        ),
      ),
    );
  }
}