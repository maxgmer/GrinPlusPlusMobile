import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grin_plus_plus/colors.dart';
import 'package:grin_plus_plus/models/wallet.dart';
import 'package:grin_plus_plus/strings.dart';
import 'package:grin_plus_plus/utils.dart';
import 'package:grin_plus_plus/widgets/fade_animator.dart';

class WalletsList extends StatelessWidget {
  final List<Wallet> wallets;

  WalletsList(this.wallets);

  @override
  Widget build(BuildContext context) {
    return FadeAnimator(
      startOpacity: 0,
      endOpacity: 1,
      duration: 1500,
      delay: 0,
      child: Center(
        child: ListView.builder(
          itemCount: wallets.length,
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(horizontal: 30),
          itemBuilder: (context, index) {
            Wallet wallet = wallets[index];
            return Padding(
              key: ValueKey(wallet.name),
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: RaisedButton(
                padding: const EdgeInsets.all(0),
                onPressed: () {},
                color: kColorBackgroundGreyLight,
                child: Center(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: SvgPicture.asset(
                          'assets/images/grin-logo-eyes.svg',
                          width: 70,
                          height: 70,
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              wallets[index].name,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: kColorAccentGrey,
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            wallet.lastTimeVisited != null ? Text(
                              '$kLastTimeVisitedString: ${getSmartDateString(wallet.lastTimeVisited)}',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: kColorAccentGrey,
                                fontFamily: 'OpenSans',
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ) : Container(),
                          ],
                        ),
                      ),
                      IconButton(
                        tooltip: kDeleteString,
                        onPressed: () {},
                        icon: Icon(Icons.delete),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}