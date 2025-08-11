import 'package:codenic_logger/codenic_logger.dart';
import 'package:dartz/dartz.dart';
import '../../model/functions/try_and_catch_the_exception.dart';
import '../../model/interfaces/http_request.dart';
import '../failures/database_failure.dart';
import '../../../application/parameters/maya_transaction_parameters.dart';
import '../../model/abstracts/exceptions/app_failure.dart';
import '../../model/abstracts/network/http_client.dart';
import '../../model/entities/maya_transactions_entities.dart';
import '../../model/abstracts/maya_services/maya_transaction_service.dart';
import '../../model/valueobjects/maya_transactions_dto.dart';

class MayaTransactionServiceImpl extends MayaTransactionService
    implements IHttpRequest {
  MayaTransactionServiceImpl({
    required HttpClient httpClient,
    required CodenicLogger codenicLogger,
  })  : _httpClient = httpClient,
        _codenicLogger = codenicLogger;

  final HttpClient _httpClient;
  final CodenicLogger _codenicLogger;

  @override
  Future<Either<AppFailure, List<MayaTransactionsEntities>>> getTransactions(
      {required int userId}) {
    return sendRequest<List<MayaTransactionsEntities>>(
      messageLog: MessageLog(id: 'get-transaction-by-user'),
      action: () async {
        final transactions = await _httpClient.getTransactions(userId);
        if (transactions.isNotEmpty) {
          return Right(transactions.map((e) => e.toEntity()).toList());
        }
        return Left(
            DatabaseFailure(code: 404, message: 'No transaction found'));
      },
    );
  }

  @override
  Future<Either<AppFailure, MayaTransactionsEntities>> postTransaction({
    required MayaTransactionParameters mayaTransactionParameters,
  }) {
    return sendRequest<MayaTransactionsEntities>(
      messageLog: MessageLog(id: 'post-transaction-by-user'),
      action: () async {
        final transaction = MayaTransactionsDTO(
          userId: mayaTransactionParameters.userId,
          transactionPurpose: mayaTransactionParameters.purpose,
          amount: mayaTransactionParameters.amount,
        ).toJson();

        final postResult = await _httpClient.postTransactions(transaction);

        _codenicLogger
          ..info(MessageLog(id: 'posted-transaction', data: transaction))
          ..info(MessageLog(id: 'post-result', data: postResult?.toJson()));

        if (postResult != null) return Right(postResult.toEntity());

        return Left(DatabaseFailure(
            code: 404, message: 'Cannot post the data to server'));
      },
    );
  }

  @override
  Future<Either<AppFailure, T>> sendRequest<T>({
    required MessageLog messageLog,
    required Future<Either<AppFailure, T>> Function() action,
  }) {
    return tryAndCatchTheExpcetions<T>(
      action: action,
      logger: _codenicLogger,
      failureMessage:
          messageLog.message ?? 'There was an issue processing the data',
    );
  }
}
