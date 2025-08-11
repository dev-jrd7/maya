class MayaTransactionsEntities {
  final int? userId;
  final int? id;
  final String? transactionPurpose;
  final String? amount;

  MayaTransactionsEntities({
    required this.userId,
    this.id,
    required this.transactionPurpose,
    required this.amount,
  });
}
