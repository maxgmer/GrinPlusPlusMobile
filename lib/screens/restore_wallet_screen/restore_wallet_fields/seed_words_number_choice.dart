import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grin_plus_plus/colors.dart';
import 'package:grin_plus_plus/screens/restore_wallet_screen/bloc/bloc.dart';

class SeedWordsNumberChoice extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SeedWordsNumberChoiceState();
}

class SeedWordsNumberChoiceState extends State<SeedWordsNumberChoice> {
  RestoreWalletBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<RestoreWalletBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RestoreWalletBloc, RestoreWalletState>(
      builder: (context, state) => Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Column(
            children: <Widget>[
              Text(
                '12',
                style: TextStyle(
                  fontSize: 17,
                  color: kColorAlmostWhite,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Radio<int>(
                groupValue: state.seedWordsNumber,
                value: 12,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                onChanged: (selectedNumberOfWords) {
                  _bloc.add(SetSeedWordsNumber(selectedNumberOfWords));
                },
                activeColor: kColorAlmostWhite,
              ),
            ],
          ),
          Column(
            children: <Widget>[
              Text(
                '15',
                style: TextStyle(
                  fontSize: 17,
                  color: kColorAlmostWhite,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Radio<int>(
                groupValue: state.seedWordsNumber,
                value: 15,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                onChanged: (selectedNumberOfWords) {
                  _bloc.add(SetSeedWordsNumber(selectedNumberOfWords));
                },
                activeColor: kColorAlmostWhite,
              ),
            ],
          ),
          Column(
            children: <Widget>[
              Text(
                '18',
                style: TextStyle(
                  fontSize: 17,
                  color: kColorAlmostWhite,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Radio<int>(
                groupValue: state.seedWordsNumber,
                value: 18,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                onChanged: (selectedNumberOfWords) {
                  _bloc.add(SetSeedWordsNumber(selectedNumberOfWords));
                },
                activeColor: kColorAlmostWhite,
              ),
            ],
          ),
          Column(
            children: <Widget>[
              Text(
                '21',
                style: TextStyle(
                  fontSize: 17,
                  color: kColorAlmostWhite,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Radio<int>(
                groupValue: state.seedWordsNumber,
                value: 21,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                onChanged: (selectedNumberOfWords) {
                  _bloc.add(SetSeedWordsNumber(selectedNumberOfWords));
                },
                activeColor: kColorAlmostWhite,
              ),
            ],
          ),
          Column(
            children: <Widget>[
              Text(
                '24',
                style: TextStyle(
                  fontSize: 17,
                  color: kColorAlmostWhite,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Radio<int>(
                groupValue: state.seedWordsNumber,
                value: 24,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                onChanged: (selectedNumberOfWords) {
                  _bloc.add(SetSeedWordsNumber(selectedNumberOfWords));
                },
                activeColor: kColorAlmostWhite,
              ),
            ],
          ),
        ],
      ),
    );
  }
}