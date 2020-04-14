import 'package:flutter/cupertino.dart';

typedef Widget TrueBuilder();
class ShowIfTrue extends StatelessWidget {
  final bool boolean;
  final TrueBuilder builder;

  ShowIfTrue({
    @required this.boolean,
    @required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        if (!boolean) {
          return Container();
        }
        return builder();
      },
    );
  }
}