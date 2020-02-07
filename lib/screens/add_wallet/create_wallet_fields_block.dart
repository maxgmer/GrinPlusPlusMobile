import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grin_plus_plus/colors.dart';
import 'package:grin_plus_plus/strings.dart';

class CreateWalletFieldsBlock extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CreateWalletFieldsBlockState();
}

class _CreateWalletFieldsBlockState extends State<CreateWalletFieldsBlock> {
  TextEditingController _walletNameController;
  FocusNode _walletNameFocusNode;
  TextEditingController _passwordController;
  FocusNode _passwordFocusNode;

  @override
  void initState() {
    super.initState();
    _walletNameController = TextEditingController();
    _walletNameFocusNode = FocusNode();
    _passwordController = TextEditingController();
    _passwordFocusNode = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
              focusedBorder: const OutlineInputBorder(
                borderSide: const BorderSide(color: kColorAlmostWhite, width: 2),
              ),
              enabledBorder: const OutlineInputBorder(
                borderSide: const BorderSide(color: kColorAlmostWhite, width: 1.5),
              ),
              contentPadding: const EdgeInsets.symmetric(
                vertical: 15.0,
                horizontal: 10,
              ),
              labelText: kWalletNameString,
              labelStyle: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w300,
                color: kColorAlmostWhite,
              ),
            ),
            controller: _walletNameController,
            focusNode: _walletNameFocusNode,
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
              focusedBorder: const OutlineInputBorder(
                borderSide: const BorderSide(color: kColorAlmostWhite, width: 2),
              ),
              enabledBorder: const OutlineInputBorder(
                borderSide: const BorderSide(color: kColorAlmostWhite, width: 1.5),
              ),
              contentPadding: const EdgeInsets.symmetric(
                vertical: 15.0,
                horizontal: 10,
              ),
              labelText: kPasswordString,
              labelStyle: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w300,
                color: kColorAlmostWhite,
              ),
            ),
            obscureText: true,
            controller: _passwordController,
            focusNode: _passwordFocusNode,
            textInputAction: TextInputAction.done,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 24),
          child: IconButton(
            onPressed: () {},
            tooltip: kSubmitWalletCreationString,
            icon: Icon(Icons.check, color: kColorAlmostWhite, size: 30),
          ),
        ),
      ],
    );
  }
}