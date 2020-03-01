import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grin_plus_plus/colors.dart';
import 'package:grin_plus_plus/screens/create_wallet_screen/bloc/bloc.dart';
import 'package:grin_plus_plus/screens/create_wallet_screen/create_wallet_fields_block.dart';
import 'package:grin_plus_plus/screens/root_screen/bloc/bloc.dart';
import 'package:grin_plus_plus/screens/screens.dart';
import 'package:grin_plus_plus/strings.dart';
import 'package:grin_plus_plus/widgets/fade_in.dart';

class CreateWalletScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CreateWalletScreenState();
}

class _CreateWalletScreenState extends State<CreateWalletScreen> {
  RootBloc _rootBloc;

  @override
  void initState() {
    super.initState();
    _rootBloc = BlocProvider.of<RootBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CreateWalletBloc, CreateWalletState>(
      listener: (context, state) {
        if (state.newWalletSeed != null && state.newWalletSeed.isNotEmpty) {
          _rootBloc.add(ChangeScreen<String>(
            Screen.showSeedScreen,
            additionalData: state.newWalletSeed,
          ));
        }
      },
      child: Scaffold(
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
                          '$kCreateWalletString:',
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.w200,
                            color: kColorAlmostWhite,
                          ),
                        ),
                      ),
                      CreateWalletFieldsBlock(),
                      InkWell(
                        onTap: () {},
                        customBorder: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Text(
                            kRestoreWalletString,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w200,
                              color: kColorAlmostWhite,
                              decoration: TextDecoration.underline,
                            ),
                          ),
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
      ),
    );
  }
}