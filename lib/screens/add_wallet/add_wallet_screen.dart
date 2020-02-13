import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grin_plus_plus/colors.dart';
import 'package:grin_plus_plus/screens/add_wallet/create_wallet_fields_block.dart';
import 'package:grin_plus_plus/screens/wallet_choice/bloc/bloc.dart';
import 'package:grin_plus_plus/strings.dart';
import 'package:grin_plus_plus/widgets/fade_animator.dart';
import 'bloc/bloc.dart';

class AddWalletScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AddWalletScreenState();
}

class _AddWalletScreenState extends State<AddWalletScreen> {
  AddWalletBloc _bloc;
  WalletChoiceBloc _walletChoiceBloc;

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<AddWalletBloc>(context);
    _walletChoiceBloc = BlocProvider.of<WalletChoiceBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddWalletBloc, AddWalletState>(
      listener: (context, state) {
        if (state.walletCreatedSuccessfully) {
          _walletChoiceBloc.add(NewWallet(state.newWallet));
          _bloc.add(ResetState());
        }
      },
      child: Container(
        constraints: BoxConstraints.expand(),
        child: Center(
          child: SingleChildScrollView(
            child: FadeAnimator(
              startOpacity: 0,
              endOpacity: 1,
              duration: 1500,
              delay: 0,
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
    );
  }
}