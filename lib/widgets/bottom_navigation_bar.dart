import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grin_plus_plus/colors.dart';
import 'package:grin_plus_plus/strings.dart';

class BottomNavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: kColorBackgroundGreyLight,
      elevation: 12,
      shape: BeveledRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.elliptical(100, 20)),
      ),
      child: Container(
        height: 60,
        child: Row(
          children: <Widget>[
            Container(width: MediaQuery.of(context).size.width * 0.2),
            IconButton(
              tooltip: kReportString,
              icon: Icon(
                Icons.bug_report,
                color: kColorAlmostWhite,
              ),
              onPressed: () {},
            ),
            Spacer(),
            IconButton(
              tooltip: kSettingsString,
              icon: Icon(
                Icons.settings,
                color: kColorAlmostWhite,
              ),
              onPressed: (){},
            ),
            Container(width: MediaQuery.of(context).size.width * 0.2),
          ],
        ),
      ),
    );
  }
}