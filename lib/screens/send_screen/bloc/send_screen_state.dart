import 'package:equatable/equatable.dart';
import 'package:grin_plus_plus/screens/send_screen/transport_type.dart';

class SendScreenState extends Equatable {
  final TransportType transportType;

  SendScreenState({this.transportType});

  factory SendScreenState.initial() {
    return SendScreenState(transportType: TransportType.file);
  }

  SendScreenState copyWith({
    TransportType transportType,
  }) {
    return SendScreenState(
      transportType: transportType ?? this.transportType
    );
  }

  @override
  List<Object> get props => [transportType];
}