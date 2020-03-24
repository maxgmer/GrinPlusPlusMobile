import 'package:equatable/equatable.dart';
import 'package:grin_plus_plus/models/output.dart';
import 'package:json_annotation/json_annotation.dart';

part 'transaction.g.dart';

@JsonSerializable()
class Transaction extends Equatable implements Comparable<Transaction> {
  @JsonKey(name: 'amount_credited')
  final int amountCredited;
  @JsonKey(name: 'amount_debited')
  final int amountDebited;
  @JsonKey(name: 'confirmed_height')
  final int confirmedHeight;
  @JsonKey(name: 'creation_date_time')
  final int creationTime;
  @JsonKey(name: 'slate_id')
  final String slateId;
  @JsonKey(name: 'slate_message')
  final String slateMessage;
  final int fee;
  final int id;
  final String type;
  final List<Output> outputs;

  Transaction({
    this.amountCredited,
    this.amountDebited,
    this.confirmedHeight,
    this.creationTime,
    this.slateId,
    this.slateMessage,
    this.fee,
    this.id,
    this.type,
    this.outputs,
  });

  double get amountCreditedDouble => amountCredited / 1000000000;
  double get amountDebitedDouble => amountDebited / 1000000000;
  DateTime get creationDateTime => DateTime.fromMillisecondsSinceEpoch(creationTime * 1000);

  TransactionType get typeEnum {
    switch (type) {
      case 'Coinbase': return TransactionType.coinbase;
      case 'Sent': return TransactionType.sent;
      case 'Received': return TransactionType.received;
      case 'Canceled': return TransactionType.cancelled;
      case 'Sending (Not Finalized)': return TransactionType.sendingStarted;
      case 'Receiving (Unconfirmed)': return TransactionType.receivingInProgress;
      case 'Sending (Finalized)': return TransactionType.sendingFinalized;
    }
    return null;
  }

  @override
  List<Object> get props => [
    amountCredited,
    amountDebited,
    confirmedHeight,
    creationTime,
    slateId,
    slateMessage,
    fee,
    id,
    type,
    outputs,
  ];

  factory Transaction.fromJson(Map<String, dynamic> json) => _$TransactionFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionToJson(this);

  static List<Transaction> fromJsonToList(dynamic json) {
    return (json as List)
        ?.map((transactionJson) => transactionJson == null ? null : Transaction.fromJson(transactionJson as Map<String, dynamic>))
        ?.toList();
  }

  @override
  int compareTo(Transaction other) => creationTime.compareTo(other.creationTime);
}

enum TransactionType {
  coinbase,
  sent,
  received,
  cancelled,
  sendingStarted,
  sendingFinalized,
  receivingInProgress,
}