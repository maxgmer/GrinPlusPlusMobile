import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grin_plus_plus/colors.dart';
import 'package:grin_plus_plus/strings.dart';

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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '$kTotalString: 0.000000000',
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
              '$kImmatureString: 0.000000000',
              style: smallText,
            ),
            currencyLogo,
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '$kUnconfirmedString: 0.000000000',
              style: smallText,
            ),
            currencyLogo,
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '$kLockedString: 0.000000000',
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
                '$kSpendableString: 0.000000000',
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
}