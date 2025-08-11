import 'package:dartz/dartz.dart';
import 'package:maya/application/parameters/maya_transaction_parameters.dart';
import 'package:maya/domain/model/abstracts/exceptions/app_failure.dart';
import 'package:maya/domain/model/abstracts/maya_services/maya_transaction_service.dart';
import 'package:maya/domain/model/entities/maya_transactions_entities.dart';
import 'package:maya/domain/services/failures/database_failure.dart';

class MayaTransactionServiceMock extends MayaTransactionService {
  final List<MayaTransactionsEntities> transactionsList = [
    MayaTransactionsEntities(
      userId: 1,
      id: 101,
      transactionPurpose: 'Payment',
      amount: '150.00',
    ),
    MayaTransactionsEntities(
      userId: 2,
      id: 102,
      transactionPurpose: 'Refund',
      amount: '75.50',
    ),
    MayaTransactionsEntities(
      userId: 3,
      id: 103,
      transactionPurpose: 'Subscription',
      amount: '12.99',
    ),
    MayaTransactionsEntities(
      userId: 4,
      id: 104,
      transactionPurpose: 'Transfer',
      amount: '2000.00',
    ),
    MayaTransactionsEntities(
      userId: 5,
      id: 105,
      transactionPurpose: 'Withdrawal',
      amount: '500.00',
    ),
  ];

  @override
  Future<Either<AppFailure, List<MayaTransactionsEntities>>> getTransactions({
    required int userId,
  }) async {
    final transactions = transactionsList
        .where((transaction) => transaction.userId == userId)
        .toList();
    if (transactions.isNotEmpty) return Right(transactions);
    return Left(DatabaseFailure(code: 404, message: 'No data found'));
  }

  @override
  Future<Either<AppFailure, MayaTransactionsEntities>> postTransaction({
    required MayaTransactionParameters mayaTransactionParameters,
  }) async {
    List<MayaTransactionsEntities> transactions = List.from(transactionsList);
    final transaction = MayaTransactionsEntities(
      userId: mayaTransactionParameters.userId,
      transactionPurpose: mayaTransactionParameters.purpose,
      amount: mayaTransactionParameters.amount,
    );
    transactions.add(transaction);
    return Right(transaction);
  }
}
