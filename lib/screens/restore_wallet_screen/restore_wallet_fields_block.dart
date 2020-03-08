import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grin_plus_plus/colors.dart';
import 'package:grin_plus_plus/screens/restore_wallet_screen/bloc/bloc.dart';
import 'package:grin_plus_plus/screens/restore_wallet_screen/restore_wallet_fields/name_and_password.dart';
import 'package:grin_plus_plus/screens/restore_wallet_screen/restore_wallet_fields/seed_words.dart';
import 'package:grin_plus_plus/screens/restore_wallet_screen/restore_wallet_fields/seed_words_number_choice.dart';
import 'package:grin_plus_plus/screens/wallet_choice/bloc/bloc.dart';
import 'package:grin_plus_plus/strings.dart';

class RestoreWalletFieldsBlock extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RestoreWalletFieldsBlockState();
}

class _RestoreWalletFieldsBlockState extends State<RestoreWalletFieldsBlock> {
  RestoreWalletBloc _bloc;
  TextEditingController _walletNameController;
  TextEditingController _passwordController;
  List<TextEditingController> _seedWordControllers = [];

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<RestoreWalletBloc>(context);
    _walletNameController = TextEditingController();
    _passwordController = TextEditingController();
    for (int i = 0; i < 24; i++) {
      _seedWordControllers.add(TextEditingController());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        NameAndPasswordFields(
          _walletNameController,
          _passwordController,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 26),
          child: Text(
            kWalletSeedString,
            style: TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.w200,
              color: kColorAlmostWhite,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 18),
          child: Text(
            '$kNumberOfWordsString:',
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.w200,
              color: kColorAlmostWhite,
            ),
          ),
        ),
        SeedWordsNumberChoice(),
        SeedFields(_seedWordControllers),
        Padding(
          padding: const EdgeInsets.only(top: 20, bottom: 80),
          child: IconButton(
            onPressed: () => _bloc.add(RestoreWallet(
              walletName: _walletNameController.text,
              password: _passwordController.text,
              seedWords: _seedWordControllers.map((controller) => controller.text).toList(),
              existingWallets: BlocProvider.of<WalletChoiceBloc>(context).state.wallets,
            )),
            tooltip: kSubmitWalletRestoreString,
            icon: Icon(Icons.check, color: kColorAlmostWhite, size: 30),
          ),
        ),
      ],
    );
  }
}
