
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grin_plus_plus/colors.dart';
import 'package:grin_plus_plus/screens/restore_wallet_screen/bloc/bloc.dart';
import 'package:grin_plus_plus/strings.dart';
import 'package:grin_plus_plus/widgets/text_field.dart';

class NameAndPasswordFields extends StatelessWidget {
  final TextEditingController walletNameController;
  final TextEditingController passwordController;

  NameAndPasswordFields(this.walletNameController, this.passwordController);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RestoreWalletBloc, RestoreWalletState>(
      builder: (context, state) {
        return Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: BorderedTextField(
                boxColor: state.walletNameError == null
                    ? kColorAlmostWhite
                    : kColorErrorRed,
                labelColor: state.walletNameError == null
                    ? kColorAlmostWhite
                    : kColorErrorRed,
                labelText: state.walletNameError == null
                    ? kWalletNameString
                    : state.walletNameError,
                controller: walletNameController,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
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
                controller: passwordController,
                obscureText: true,
              ),
            ),
          ],
        );
      },
    );
  }
}
