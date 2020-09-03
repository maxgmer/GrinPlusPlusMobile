import 'dart:io';

import 'package:equatable/equatable.dart';

class FinalizeScreenState extends Equatable {
  final String message;
  final File file;
  final bool grinJoin;
  final String transactionFilePath;


  FinalizeScreenState({
    this.message,
    this.file,
    this.grinJoin = false,
    this.transactionFilePath,
  });

  factory FinalizeScreenState.initial() {
    return FinalizeScreenState();
  }

  FinalizeScreenState copyWith({String message, File file,
    bool grinJoin, String transactionFilePath}) {
    return FinalizeScreenState(
      message: message ?? this.message,
      file: file ?? this.file,
      grinJoin: grinJoin ?? this.grinJoin,
      transactionFilePath: transactionFilePath ?? this.transactionFilePath,
    );
  }

  @override
  List<Object> get props => [
    message,
    file,
    grinJoin,
    transactionFilePath,
  ];
}