import 'package:maya/domain/model/abstracts/network/http_client.dart';
import 'package:maya/domain/model/valueobjects/maya_transactions_dto.dart';

class MayaHttpClientMock implements HttpClient {
  final List<MayaTransactionsDTO> transactionsList = [
    MayaTransactionsDTO(
      userId: 1,
      id: 201,
      transactionPurpose: 'Money Sent - Successful',
      amount: 'You successfully sent \$500 to user 2.',
    ),
    MayaTransactionsDTO(
      userId: 2,
      id: 202,
      transactionPurpose: 'Money Sent - Failed',
      amount: 'The transaction failed. Please check your account balance.',
    ),
    MayaTransactionsDTO(
      userId: 3,
      id: 203,
      transactionPurpose: 'Money Sent - Pending',
      amount: 'Your \$100 transfer is pending. Please wait for confirmation.',
    ),
    MayaTransactionsDTO(
      userId: 4,
      id: 204,
      transactionPurpose: 'Money Sent - Refund Issued',
      amount: 'Your \$200 transfer was refunded due to a technical error.',
    ),
    MayaTransactionsDTO(
      userId: 5,
      id: 205,
      transactionPurpose: 'Money Sent - Partially Successful',
      amount:
          'You sent \$1000, but only \$500 was successfully transferred due to an issue with the recipient\'s account.',
    ),
  ];

  @override
  Future<List<MayaTransactionsDTO>> getTransactions(userId) async {
    return transactionsList
        .where(
          (transactions) => transactions.userId == userId,
        )
        .toList();
  }

  @override
  Future<MayaTransactionsDTO?> postTransactions(
    Map<String, dynamic>? transactions,
  ) async {
    if (transactions!.isNotEmpty) {
      transactionsList.add(
        MayaTransactionsDTO.fromJson(transactions),
      );
      return MayaTransactionsDTO.fromJson(transactions);
    }
    return MayaTransactionsDTO.fromJson({});
  }
}
