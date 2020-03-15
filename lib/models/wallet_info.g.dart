// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WalletInfo _$WalletInfoFromJson(Map<String, dynamic> json) {
  return WalletInfo(
    total: json['total'] as int,
    amountAwaitingConfirmation: json['amount_awaiting_confirmation'] as int,
    amountCurrentlySpendable: json['amount_currently_spendable'] as int,
    amountImmature: json['amount_immature'] as int,
    amountLocked: json['amount_locked'] as int,
    lastConfirmedHeight: json['last_confirmed_height'] as int,
    minimumConfirmations: json['minimum_confirmations'] as int,
    transactions: (json['transactions'] as List)
        ?.map((e) =>
            e == null ? null : Transaction.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$WalletInfoToJson(WalletInfo instance) =>
    <String, dynamic>{
      'total': instance.total,
      'amount_awaiting_confirmation': instance.amountAwaitingConfirmation,
      'amount_currently_spendable': instance.amountCurrentlySpendable,
      'amount_immature': instance.amountImmature,
      'amount_locked': instance.amountLocked,
      'last_confirmed_height': instance.lastConfirmedHeight,
      'minimum_confirmations': instance.minimumConfirmations,
      'transactions': instance.transactions,
    };
