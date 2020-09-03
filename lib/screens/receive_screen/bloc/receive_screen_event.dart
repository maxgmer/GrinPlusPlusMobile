import 'package:equatable/equatable.dart';

abstract class ReceiveScreenEvent extends Equatable {
  const ReceiveScreenEvent();

  @override
  List<Object> get props => [];
}

class MessageUpdated extends ReceiveScreenEvent {
  final String message;

  MessageUpdated(this.message);

  @override
  List<Object> get props => [message];
}
class Receive extends ReceiveScreenEvent {}
class SelectTxFile extends ReceiveScreenEvent {}
class ClearFileSelection extends ReceiveScreenEvent {}
class AcknowledgeTxFilePath extends ReceiveScreenEvent {}
