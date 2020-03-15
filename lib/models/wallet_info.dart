import 'package:equatable/equatable.dart';
import 'package:grin_plus_plus/models/transaction.dart';
import 'package:json_annotation/json_annotation.dart';

part 'wallet_info.g.dart';

@JsonSerializable()
class WalletInfo extends Equatable {
  final int total;
  @JsonKey(name: 'amount_awaiting_confirmation')
  final int amountAwaitingConfirmation;
  @JsonKey(name: 'amount_currently_spendable')
  final int amountCurrentlySpendable;
  @JsonKey(name: 'amount_immature')
  final int amountImmature;
  @JsonKey(name: 'amount_locked')
  final int amountLocked;
  @JsonKey(name: 'last_confirmed_height')
  final int lastConfirmedHeight;
  @JsonKey(name: 'minimum_confirmations')
  final int minimumConfirmations;
  final List<Transaction> transactions;

  WalletInfo({
    this.total,
    this.amountAwaitingConfirmation,
    this.amountCurrentlySpendable,
    this.amountImmature,
    this.amountLocked,
    this.lastConfirmedHeight,
    this.minimumConfirmations,
    this.transactions,
  });

  @override
  List<Object> get props => [
    total,
    amountAwaitingConfirmation,
    amountCurrentlySpendable,
    amountImmature,
    amountLocked,
    lastConfirmedHeight,
    minimumConfirmations,
    transactions,
  ];

  factory WalletInfo.fromJson(Map<String, dynamic> json) => _$WalletInfoFromJson(json);

  Map<String, dynamic> toJson() => _$WalletInfoToJson(this);

  static List<WalletInfo> fromJsonToList(dynamic json) {
    return (json as List)
        ?.map((walletInfoJson) => walletInfoJson == null ? null : WalletInfo.fromJson(walletInfoJson as Map<String, dynamic>))
        ?.toList();
  }
}