import 'package:dio/dio.dart';
import 'package:maya/domain/model/valueobjects/maya_transactions_dto.dart';
import 'package:retrofit/retrofit.dart';

part 'http_client.g.dart';

@RestApi(baseUrl: 'https://my-json-server.typicode.com/dev-jrd7/maya')

abstract class HttpClient {
  factory HttpClient(Dio dio, {String? baseUrl}) = _HttpClient;

  @GET('/transactions')
  Future<List<MayaTransactionsDTO>> getTransactions(
      @Query('userId') int userId,
  );

  @POST('/transactions')
  Future<MayaTransactionsDTO?> postTransactions(Map<String, dynamic>? transactions);
}
