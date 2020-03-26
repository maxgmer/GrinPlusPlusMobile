import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'commitment.g.dart';

@JsonSerializable()
class Commitment extends Equatable {
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

  Commitment({
    this.amount,
    this.blockHeight,
    this.keychainPath,
    this.commitment,
    this.status,
    this.transactionId,
    this.label,
    this.mmrIndex,
  });

  CommitmentStatus get statusEnum {
    switch (status) {
      case 'Spendable': return CommitmentStatus.spendable;
      case 'Immature': return CommitmentStatus.immature;
      case 'No Confirmations': return CommitmentStatus.noConfirmations;
      case 'Spent': return CommitmentStatus.spent;
      case 'Locked': return CommitmentStatus.locked;
      case 'Canceled': return CommitmentStatus.cancelled;
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

  factory Commitment.fromJson(Map<String, dynamic> json) => _$CommitmentFromJson(json);

  Map<String, dynamic> toJson() => _$CommitmentToJson(this);

  static List<Commitment> fromJsonToList(dynamic json) {
    return (json as List)
        ?.map((commitmentJson) => commitmentJson == null ? null : Commitment.fromJson(commitmentJson as Map<String, dynamic>))
        ?.toList();
  }
}

enum CommitmentStatus {
  spendable,
  immature,
  noConfirmations,
  locked,
  spent,
  cancelled,
}