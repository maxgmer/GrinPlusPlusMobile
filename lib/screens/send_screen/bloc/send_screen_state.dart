import 'package:equatable/equatable.dart';
import 'package:grin_plus_plus/screens/send_screen/transport_type.dart';

class SendScreenState extends Equatable {
  final TransportType transportType;
  final String amountError;
  final double estimatedFee;
  final String transactionFilePath;

  SendScreenState({
    this.transportType,
    this.amountError,
    this.estimatedFee,
    this.transactionFilePath,
  });

  factory SendScreenState.initial() {
    return SendScreenState(
      transportType: TransportType.file,
    );
  }

  SendScreenState copyWith({
    TransportType transportType,
    String amountError,
    double estimatedFee,
    String transactionFilePath,
  }) {
    return SendScreenState(
      transportType: transportType ?? this.transportType,
      amountError: amountError ?? this.amountError,
      estimatedFee: estimatedFee ?? this.estimatedFee,
      transactionFilePath: transactionFilePath ?? this.transactionFilePath,
    );
  }

  @override
  List<Object> get props => [
    transportType,
    amountError,
    estimatedFee,
    transactionFilePath,
  ];
}