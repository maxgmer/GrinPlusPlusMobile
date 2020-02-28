import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class Wallet extends Equatable {
  final String name;
  final DateTime lastTimeVisited;

  Wallet({
    @required this.name,
    this.lastTimeVisited,
  });

  @override
  List<Object> get props => [name, lastTimeVisited];
}