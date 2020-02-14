import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grin_plus_plus/colors.dart';
import 'package:grin_plus_plus/strings.dart';

class TransactionsList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TransactionsListState();
}

class _TransactionsListState extends State<TransactionsList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.6),
        border: Border(top: BorderSide(color: kColorBackgroundGreyLight))
      ),
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 14),
            child: TransactionTile(TransactionType.received),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 14),
            child: TransactionTile(TransactionType.received),
          ),
          TransactionTile(TransactionType.sent),
        ],
      ),
    );
  }
}

enum TransactionType {received, sent}
class TransactionTile extends StatelessWidget {
  final TransactionType type;

  TransactionTile(this.type);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              type == TransactionType.sent
                  ? kSentString
                  : kReceivedString,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: kColorAlmostWhite,
              ),
            ),
            Text(
              'today at 15:40',
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
          '1235.325523',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: type == TransactionType.sent
                ? kColorPinkRed
                : kColorGreen,
          ),
        ),
        SvgPicture.asset(
          'assets/images/grin-logo-eyes.svg',
          width: 27,
          height: 27,
          color: type == TransactionType.sent
              ? kColorPinkRed
              : kColorGreen,
        ),
      ],
    );
  }
}