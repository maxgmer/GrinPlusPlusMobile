import 'dart:io';

import 'package:equatable/equatable.dart';

class ReceiveScreenState extends Equatable {
  final File file;
  final String transactionFilePath;
  final String message;

  ReceiveScreenState({
    this.file,
    this.transactionFilePath,
    this.message,
  });

  factory ReceiveScreenState.initial() {
    return ReceiveScreenState();
  }

  ReceiveScreenState copyWith({File file,
    String transactionFilePath, String message}) {
    return ReceiveScreenState(
      file: file ?? this.file,
      transactionFilePath: transactionFilePath ?? this.transactionFilePath,
      message: message ?? this.message,
    );
  }

  @override
  List<Object> get props => [
    transactionFilePath,
    file,
    message,
  ];
}