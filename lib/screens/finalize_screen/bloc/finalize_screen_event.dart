import 'package:equatable/equatable.dart';

abstract class FinalizeScreenEvent extends Equatable {
  const FinalizeScreenEvent();

  @override
  List<Object> get props => [];
}

class MessageUpdated extends FinalizeScreenEvent {
  final String message;

  MessageUpdated(this.message);

  @override
  List<Object> get props => [message];
}
class GrinJoin extends FinalizeScreenEvent {
  final bool grinJoin;

  GrinJoin(this.grinJoin);

  @override
  List<Object> get props => [grinJoin];
}
class ClearResponseFileSelection extends FinalizeScreenEvent {}
class SelectTxResponseFile extends FinalizeScreenEvent {}
class Finalize extends FinalizeScreenEvent {}
class AcknowledgeTxFilePath extends FinalizeScreenEvent {}
