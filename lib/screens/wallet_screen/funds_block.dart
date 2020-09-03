import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grin_plus_plus/colors.dart';
import 'package:grin_plus_plus/strings.dart';

import 'bloc/bloc.dart';

class FundsBlock extends StatelessWidget {
  static final grinLogoDims = 26.0;
  final TextStyle smallText = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: kColorAlmostWhite,
  );
  final currencyLogo = SvgPicture.asset(
    'assets/images/grin-logo-eyes.svg',
    width: grinLogoDims,
    height: grinLogoDims,
    color: kColorAlmostWhite,
  );

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WalletScreenBloc, WalletScreenState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  '$kTotalString: ${state.total.toStringAsFixed(9)}',
                  style: smallText,
                ),
                SvgPicture.asset(
                  'assets/images/grin-logo-eyes.svg',
                  width: grinLogoDims + 4,
                  height: grinLogoDims + 4,
                  color: kColorAlmostWhite,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  '$kImmatureString: ${state.immature.toStringAsFixed(9)}',
                  style: smallText,
                ),
                currencyLogo,
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  '$kUnconfirmedString: ${state.unconfirmed.toStringAsFixed(9)}',
                  style: smallText,
                ),
                currencyLogo,
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  '$kLockedString: ${state.locked.toStringAsFixed(9)}',
                  style: smallText,
                ),
                currencyLogo,
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    '$kSpendableString: ${state.spendable.toStringAsFixed(9)}',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w400,
                      color: kColorAlmostWhite,
                    ),
                  ),
                  currencyLogo,
                ],
              ),
            ),
          ],
        );
      }
    );
  }
}