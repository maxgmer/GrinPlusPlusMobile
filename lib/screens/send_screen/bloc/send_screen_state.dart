import 'package:equatable/equatable.dart';
import 'package:grin_plus_plus/screens/send_screen/transport_type.dart';

class SendScreenState extends Equatable {
  final TransportType transportType;
  final String amountError;
  final double estimatedFee;
  final String transactionFilePath;
  final bool grinJoin;

  SendScreenState({
    this.transportType,
    this.amountError,
    this.estimatedFee,
    this.transactionFilePath,
    this.grinJoin,
  });

  factory SendScreenState.initial() {
    return SendScreenState(
      transportType: TransportType.file,
      grinJoin: false,
    );
  }

  SendScreenState copyWith({
    TransportType transportType,
    String amountError,
    double estimatedFee,
    String transactionFilePath,
    bool grinJoin,
  }) {
    return SendScreenState(
      transportType: transportType ?? this.transportType,
      amountError: amountError ?? this.amountError,
      estimatedFee: estimatedFee ?? this.estimatedFee,
      transactionFilePath: transactionFilePath ?? this.transactionFilePath,
      grinJoin: grinJoin ?? this.grinJoin,
    );
  }

  @override
  List<Object> get props => [
    transportType,
    amountError,
    estimatedFee,
    transactionFilePath,
    grinJoin,
  ];
}