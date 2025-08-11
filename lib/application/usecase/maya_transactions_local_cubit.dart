import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maya/application/parameters/maya_transaction_parameters.dart';
import 'package:maya/domain/model/valueobjects/maya_transactions_dto.dart';

class MayaTransactionsLocalCubit extends Cubit<List<MayaTransactionsDTO>> {
  MayaTransactionsLocalCubit() : super([]);

  void setNewList(MayaTransactionParameters transaction) {
    final transactionsList = state;
    transactionsList.add(MayaTransactionsDTO(
      userId: transaction.userId,
      transactionPurpose: transaction.purpose,
      amount: transaction.amount,
    ));
    emit(transactionsList);
  }

  void resetTransactionsList() => emit([]);

  List<MayaTransactionsDTO> get transactions => state;
}
