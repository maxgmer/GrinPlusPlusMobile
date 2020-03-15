import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'output.g.dart';

@JsonSerializable()
class Output extends Equatable {
  final int amount;
  @JsonKey(name: 'block_height')
  final int blockHeight;
  @JsonKey(name: 'keychain_path')
  final String keychainPath;
  final String commitment;
  final String status;
  @JsonKey(name: 'transaction_id')
  final int transactionId;
  final String label;
  @JsonKey(name: 'mmr_index')
  final int mmrIndex;

  Output({
    this.amount,
    this.blockHeight,
    this.keychainPath,
    this.commitment,
    this.status,
    this.transactionId,
    this.label,
    this.mmrIndex,
  });

  OutputStatus get statusEnum {
    switch (status) {
      case 'Spendable': return OutputStatus.spendable;
      case 'Immature': return OutputStatus.immature;
      case 'No Confirmations': return OutputStatus.noConfirmations;
      case 'Spent': return OutputStatus.spent;
      case 'Locked': return OutputStatus.locked;
      case 'Canceled': return OutputStatus.cancelled;
    }
    return null;
  }

  @override
  List<Object> get props => [
    amount,
    blockHeight,
    keychainPath,
    commitment,
    status,
    transactionId,
    label,
    mmrIndex,
  ];

  factory Output.fromJson(Map<String, dynamic> json) => _$OutputFromJson(json);

  Map<String, dynamic> toJson() => _$OutputToJson(this);

  static List<Output> fromJsonToList(dynamic json) {
    return (json as List)
        ?.map((outputJson) => outputJson == null ? null : Output.fromJson(outputJson as Map<String, dynamic>))
        ?.toList();
  }
}

enum OutputStatus {
  spendable,
  immature,
  noConfirmations,
  locked,
  spent,
  cancelled,
}