import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grin_plus_plus/colors.dart';
import 'package:grin_plus_plus/screens/create_wallet_screen/bloc/bloc.dart';
import 'package:grin_plus_plus/screens/wallet_choice/bloc/bloc.dart';
import 'package:grin_plus_plus/strings.dart';
import 'package:grin_plus_plus/widgets/text_field.dart';

class CreateWalletFieldsBlock extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CreateWalletFieldsBlockState();
}

class _CreateWalletFieldsBlockState extends State<CreateWalletFieldsBlock> {
  CreateWalletBloc _bloc;
  TextEditingController _walletNameController;
  TextEditingController _passwordController;
  TextEditingController _repeatPasswordController;

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<CreateWalletBloc>(context);
    _walletNameController = TextEditingController();
    _passwordController = TextEditingController();
    _repeatPasswordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateWalletBloc, CreateWalletState>(
      builder: (context, state) => Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: BorderOnlyTextField(
              boxColor: state.walletNameError == null
                  ? kColorAlmostWhite
                  : kColorErrorRed,
              labelColor: state.walletNameError == null
                  ? kColorAlmostWhite
                  : kColorErrorRed,
              labelText: state.walletNameError == null
                  ? kWalletNameString
                  : state.walletNameError,
              controller: _walletNameController,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: BorderOnlyTextField(
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
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: BorderOnlyTextField(
              boxColor: state.passwordError == null
                  ? kColorAlmostWhite
                  : kColorErrorRed,
              labelColor: state.passwordError == null
                  ? kColorAlmostWhite
                  : kColorErrorRed,
              labelText: state.passwordError == null
                  ? kPasswordRepeatString
                  : state.passwordError,
              controller: _repeatPasswordController,
              obscureText: true,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 24),
            child: IconButton(
              onPressed: () => _bloc.add(CreateWallet(
                _walletNameController.text,
                _passwordController.text,
                _repeatPasswordController.text,
                BlocProvider.of<WalletChoiceBloc>(context).state.wallets,
              )),
              tooltip: kSubmitWalletCreationString,
              icon: Icon(Icons.check, color: kColorAlmostWhite, size: 30),
            ),
          ),
        ],
      ),
    );
  }
}