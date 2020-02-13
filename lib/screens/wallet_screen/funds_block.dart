import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grin_plus_plus/colors.dart';
import 'package:grin_plus_plus/strings.dart';

class FundsBlock extends StatelessWidget {
  static final grinLogoDims = 26.0;
  final TextStyle smallText = TextStyle(
    fontSize: 16,
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Text(
              '$kSpendableString: 0.000000000',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w400,
                color: kColorAlmostWhite,
              ),
            ),
            currencyLogo,
          ],
        ),
        Row(
          children: <Widget>[
            Text(
              '$kTotalString: 0.000000000',
              style: smallText,
            ),
            currencyLogo,
          ],
        ),
        Row(
          children: <Widget>[
            Text(
              '$kImmatureString: 0.000000000',
              style: smallText,
            ),
            currencyLogo,
          ],
        ),
        Row(
          children: <Widget>[
            Text(
              '$kUnconfirmedString: 0.000000000',
              style: smallText,
            ),
            currencyLogo,
          ],
        ),
        Row(
          children: <Widget>[
            Text(
              '$kLockedString: 0.000000000',
              style: smallText,
            ),
            currencyLogo,
          ],
        ),
      ],
    );
  }
}