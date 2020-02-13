import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grin_plus_plus/colors.dart';
import 'package:grin_plus_plus/screens/add_wallet/bloc/add_wallet_bloc.dart';
import 'package:grin_plus_plus/screens/add_wallet/bloc/add_wallet_event.dart';
import 'package:grin_plus_plus/screens/add_wallet/bloc/add_wallet_state.dart';
import 'package:grin_plus_plus/screens/wallet_choice/bloc/bloc.dart';
import 'package:grin_plus_plus/strings.dart';

class CreateWalletFieldsBlock extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CreateWalletFieldsBlockState();
}

class _CreateWalletFieldsBlockState extends State<CreateWalletFieldsBlock> {
  AddWalletBloc _bloc;
  TextEditingController _walletNameController;
  TextEditingController _passwordController;
  TextEditingController _repeatPasswordController;

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<AddWalletBloc>(context);
    _walletNameController = TextEditingController();
    _passwordController = TextEditingController();
    _repeatPasswordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddWalletBloc, AddWalletState>(
      builder: (context, state) => Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: TextField(
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w300,
                color: kColorAlmostWhite,
              ),
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: state.walletNameError == null
                        ? kColorAlmostWhite
                        : kColorErrorRed,
                    width: 2,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: state.walletNameError == null
                        ? kColorAlmostWhite
                        : kColorErrorRed,
                    width: 1.5,
                  ),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 15.0,
                  horizontal: 10,
                ),
                labelText: state.walletNameError == null
                    ? kWalletNameString
                    : state.walletNameError,
                labelStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                  color: state.walletNameError == null
                      ? kColorAlmostWhite
                      : kColorErrorRed,
                ),
              ),
              controller: _walletNameController,
              textInputAction: TextInputAction.done,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: TextField(
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w300,
                color: kColorAlmostWhite,
              ),
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: state.passwordError == null
                        ? kColorAlmostWhite
                        : kColorErrorRed,
                    width: 2,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: state.passwordError == null
                        ? kColorAlmostWhite
                        : kColorErrorRed,
                    width: 1.5,
                  ),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 15.0,
                  horizontal: 10,
                ),
                labelText: state.passwordError == null
                    ? kPasswordString
                    : state.passwordError,
                labelStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                  color: state.passwordError == null
                      ? kColorAlmostWhite
                      : kColorErrorRed,
                ),
              ),
              obscureText: true,
              controller: _passwordController,
              textInputAction: TextInputAction.done,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: TextField(
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w300,
                color: kColorAlmostWhite,
              ),
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: state.passwordError == null
                        ? kColorAlmostWhite
                        : kColorErrorRed,
                    width: 2,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: state.passwordError == null
                        ? kColorAlmostWhite
                        : kColorErrorRed,
                    width: 1.5,
                  ),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 15.0,
                  horizontal: 10,
                ),
                labelText: state.passwordError == null
                    ? kPasswordRepeatString
                    : state.passwordError,
                labelStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                  color: state.passwordError == null
                      ? kColorAlmostWhite
                      : kColorErrorRed,
                ),
              ),
              obscureText: true,
              controller: _repeatPasswordController,
              textInputAction: TextInputAction.done,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 24),
            child: IconButton(
              onPressed: () => _bloc.add(CreateWalletLoginAndPassword(
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