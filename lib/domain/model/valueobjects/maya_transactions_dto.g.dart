// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'maya_transactions_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MayaTransactionsDTO _$MayaTransactionsDTOFromJson(Map<String, dynamic> json) =>
    MayaTransactionsDTO(
      userId: (json['userId'] as num?)?.toInt(),
      id: (json['id'] as num?)?.toInt(),
      transactionPurpose: json['transactionPurpose'] as String?,
      amount: json['amount'] as String?,
    );

Map<String, dynamic> _$MayaTransactionsDTOToJson(
        MayaTransactionsDTO instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'id': instance.id,
      'transactionPurpose': instance.transactionPurpose,
      'amount': instance.amount,
    };
