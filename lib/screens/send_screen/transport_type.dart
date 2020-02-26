import 'package:equatable/equatable.dart';
import 'package:grin_plus_plus/strings.dart';

class TransportType extends Equatable {
  static const TransportType http = TransportType._(kHttpString);
  static const TransportType tor = TransportType._(kTorString);
  static const TransportType file = TransportType._(kFileString);

  final String type;

  const TransportType._(this.type);

  factory TransportType.parse(String type) {
    return TransportType._(type);
  }

  @override
  List<Object> get props => [type];

  @override
  String toString() => type;
}