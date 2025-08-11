import 'package:json_annotation/json_annotation.dart';

import '../entities/maya_transactions_entities.dart';
import '../interfaces/entity_mapper.dart';

part 'maya_transactions_dto.g.dart';

/// DTO (Data Transfer Object) for handling authenticated Maya transactions.
///
/// This class maps the JSON structure of an authenticated transaction to
/// a Dart object and vice versa. It implements the IEntityMapper interface
/// to convert itself into a domain model entity (`MayaTransactionsEntities`).
///
/// It has the following properties:
/// - [userId]: The ID of the user associated with the transaction.
/// - [id]: The unique identifier for the transaction.
/// - [title]: The title or brief description of the transaction.
/// - [body]: Detailed description or body of the transaction.
///
/// It provides:
/// - [fromJson]: Factory constructor to create an instance from a JSON map.
/// - [toJson]: Method to convert the object back to a JSON map.
/// - [toEntity]: Converts this DTO into a [MayaTransactionsEntities] object,
///   which can be used in the domain layer.
@JsonSerializable()
class MayaTransactionsDTO
    implements IEntityMapper<MayaTransactionsEntities> {
  final int? userId;
  final int? id;
  final String? transactionPurpose;
  final String? amount;

  MayaTransactionsDTO({
    required this.userId,
    this.id,
    required this.transactionPurpose,
    required this.amount,
  });

  factory MayaTransactionsDTO.fromJson(Map<String, dynamic> json) =>
      _$MayaTransactionsDTOFromJson(json);

  Map<String, dynamic> toJson() => _$MayaTransactionsDTOToJson(this);

  @override
  MayaTransactionsEntities toEntity() {
    return MayaTransactionsEntities(
      userId: userId,
      id: id,
      transactionPurpose: transactionPurpose,
      amount: amount,
    );
  }
}
