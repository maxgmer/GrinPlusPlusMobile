import 'package:equatable/equatable.dart';
import 'package:grin_plus_plus/screens/send_screen/transport_type.dart';

abstract class SendScreenEvent extends Equatable {
  const SendScreenEvent();

  @override
  List<Object> get props => [];
}

class AcknowledgeTxFilePath extends SendScreenEvent {}
class GrinJoin extends SendScreenEvent {
  final bool grinJoinEnabled;

  GrinJoin(this.grinJoinEnabled);

  @override
  List<Object> get props => [grinJoinEnabled];
}
class Send extends SendScreenEvent {
  final double amount;
  final String address;
  final String message;

  Send({
    this.amount,
    this.address,
    this.message,
  });

  @override
  List<Object> get props => [
    amount,
    address,
    message,
  ];
}
class ChangeTransportType extends SendScreenEvent {
  final TransportType transportType;

  ChangeTransportType(this.transportType);

  @override
  List<Object> get props => [transportType];
}
class AmountChanged extends SendScreenEvent {
  final double amount;

  AmountChanged(this.amount);

  @override
  List<Object> get props => [amount];
}
