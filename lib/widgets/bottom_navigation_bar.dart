import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grin_plus_plus/colors.dart';
import 'package:grin_plus_plus/strings.dart';

class BottomNavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black.withOpacity(0.4),
      elevation: 0,
      child: Container(
        height: 50,
        child: Row(
          children: <Widget>[
            Container(width: MediaQuery.of(context).size.width * 0.2),
            IconButton(
              tooltip: kReportString,
              icon: Icon(
                Icons.info,
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