import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:maya/application/parameters/maya_transaction_parameters.dart';
import 'package:maya/domain/model/abstracts/exceptions/app_failure.dart';
import 'package:maya/domain/model/entities/maya_transactions_entities.dart';
import 'maya_transaction_service_mock.dart';

void main() {
  late MayaTransactionServiceMock serviceImplementation;

  setUp(() {
    serviceImplementation = MayaTransactionServiceMock();
  });

  group(
    'Test the method for getting and posting list of transactions of user',
    () {
      test('Get list of transactions', () async {
        final Either<AppFailure, List<MayaTransactionsEntities>> result =
            await serviceImplementation.getTransactions(userId: 1);

        // Assert
        result.fold(
          (failure) => expect(failure, isA<AppFailure>()),
          (transactions) {
            // If it's on the Right side, we check the list of transactions
            expect(transactions, isA<List<MayaTransactionsEntities>>());
            expect(transactions.isEmpty, false);
          },
        );
      });

      test('Post new transaction', () async {
        final Either<AppFailure, MayaTransactionsEntities> postResult =
            await serviceImplementation.postTransaction(
          mayaTransactionParameters: MayaTransactionParameters(
            userId: 10,
            purpose: '200.00',
            amount: 'The transaction failed. Please check your account balance.',
          ),
        );

        // Assert
        postResult.fold(
          (failure) {
            // Handle failure case (Left side)
            expect(failure, isA<AppFailure>());
            // Optionally check for specific failure details if you expect something specific.
          },
          (transaction) {
            // Handle success case (Right side)
            expect(transaction, isA<MayaTransactionsEntities>());
            expect(transaction.transactionPurpose, '200.00'); // Check if the transactionPurpose matches
            expect(transaction.amount,
                'The transaction failed. Please check your account balance.'); // Check if the amount matches
          },
        );
      });
    },
  );
}
