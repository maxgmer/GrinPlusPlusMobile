import 'package:equatable/equatable.dart';
import 'package:grin_plus_plus/screens/send_screen/transport_type.dart';

class SendScreenState extends Equatable {
  final TransportType transportType;
  final String amountError;
  final String addressError;
  final double estimatedFee;
  final String transactionFilePath;
  final bool grinJoin;
  final bool sendingInProgress;

  SendScreenState({
    this.transportType,
    this.amountError,
    this.addressError,
    this.estimatedFee,
    this.transactionFilePath,
    this.grinJoin,
    this.sendingInProgress,
  });

  factory SendScreenState.initial() {
    return SendScreenState(
      transportType: TransportType.file,
      grinJoin: false,
      sendingInProgress: false,
    );
  }

  SendScreenState copyWith({
    TransportType transportType,
    String amountError,
    String addressError,
    double estimatedFee,
    String transactionFilePath,
    bool grinJoin,
    bool sendingInProgress,
  }) {
    return SendScreenState(
      transportType: transportType ?? this.transportType,
      amountError: amountError ?? this.amountError,
      addressError: addressError ?? this.addressError,
      estimatedFee: estimatedFee ?? this.estimatedFee,
      transactionFilePath: transactionFilePath ?? this.transactionFilePath,
      grinJoin: grinJoin ?? this.grinJoin,
      sendingInProgress: sendingInProgress ?? this.sendingInProgress,
    );
  }

  @override
  List<Object> get props => [
    transportType,
    amountError,
    addressError,
    estimatedFee,
    transactionFilePath,
    grinJoin,
    sendingInProgress,
  ];
}