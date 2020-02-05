import 'package:flutter/cupertino.dart';

class Wallet {
  final String name;
  final DateTime lastTimeVisited;

  Wallet({
    @required this.name,
    this.lastTimeVisited,
  });
}