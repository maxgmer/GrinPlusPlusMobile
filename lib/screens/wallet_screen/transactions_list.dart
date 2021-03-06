import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grin_plus_plus/colors.dart';
import 'package:grin_plus_plus/models/transaction.dart';
import 'package:grin_plus_plus/screens/wallet_screen/bloc/bloc.dart';
import 'package:grin_plus_plus/utils/date_utils.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class TransactionsList extends StatefulWidget {
  final WalletScreenBloc bloc;
  final PanelController panelController;

  TransactionsList(this.bloc, this.panelController);

  @override
  State<StatefulWidget> createState() => _TransactionsListState();
}

class _TransactionsListState extends State<TransactionsList> {

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WalletScreenBloc, WalletScreenState>(
      builder: (context, state) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.6),
            border: Border(top: BorderSide(color: kColorBackgroundGreyLight)),
          ),
          child: ScrollConfiguration(
            behavior: ScrollBehavior(),
            child: ListView.builder(
              itemCount: state.transactions.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    widget.panelController.open();
                    widget.bloc.add(ShowTxDetails(state.transactions[(state.transactions.length - 1) - index]));
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
                    child: TransactionTile(state.transactions[(state.transactions.length - 1) - index]),
                  ),
                );
              },
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
          ),
        );
      },
    );
  }
}

class TransactionTile extends StatelessWidget {
  final Transaction transaction;

  TransactionTile(this.transaction);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              transaction.type,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: kColorAlmostWhite,
              ),
            ),
            Text(
              getSmartDateString(transaction.creationDateTimeLocal, withTime: true),
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: kColorGreyLight,
              ),
            ),
          ],
        ),
        Spacer(),
        Text(
          (transaction.amountCreditedDouble - transaction.amountDebitedDouble).toStringAsFixed(9),
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: transaction.amountCredited < transaction.amountDebited
                ? kColorPinkRed
                : kColorGreen,
          ),
        ),
        SvgPicture.asset(
          'assets/images/grin-logo-eyes.svg',
          width: 27,
          height: 27,
          color: transaction.amountCredited < transaction.amountDebited
              ? kColorPinkRed
              : kColorGreen,
        ),
      ],
    );
  }
}