import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'input_output.g.dart';

@JsonSerializable()
class InputOutput extends Equatable {
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

  InputOutput({
    this.amount,
    this.blockHeight,
    this.keychainPath,
    this.commitment,
    this.status,
    this.transactionId,
    this.label,
    this.mmrIndex,
  });

  InputOutputStatus get statusEnum {
    switch (status) {
      case 'Spendable': return InputOutputStatus.spendable;
      case 'Immature': return InputOutputStatus.immature;
      case 'No Confirmations': return InputOutputStatus.noConfirmations;
      case 'Spent': return InputOutputStatus.spent;
      case 'Locked': return InputOutputStatus.locked;
      case 'Canceled': return InputOutputStatus.cancelled;
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

  factory InputOutput.fromJson(Map<String, dynamic> json) => _$InputOutputFromJson(json);

  Map<String, dynamic> toJson() => _$InputOutputToJson(this);

  static List<InputOutput> fromJsonToList(dynamic json) {
    return (json as List)
        ?.map((inputOutputJson) => inputOutputJson == null ? null : InputOutput.fromJson(inputOutputJson as Map<String, dynamic>))
        ?.toList();
  }
}

enum InputOutputStatus {
  spendable,
  immature,
  noConfirmations,
  locked,
  spent,
  cancelled,
}