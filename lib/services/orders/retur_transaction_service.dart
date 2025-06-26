import 'package:hanaang_app/models/retur_transaction_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:hanaang_app/utilities/base_url.dart';

class ReturTransactionService {
  Future<List<ReturTransactionModel>> getReturTransaction(
      String token, String returNumber) async {
    final response = await http.get(
      Uri.parse(
          '${BaseUrl.apiUrl}/retur-transaction?retur_number=$returNumber'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );

    print("=========Ini Adalah Respon Body==========");
    print(response.body);
    if (response.statusCode == 200) {
      final Map<String, dynamic> decodedResponse = jsonDecode(response.body);
      final List<dynamic> data = decodedResponse['data'];

      // Konversi setiap item dalam list menjadi PreOrderModel
      List<ReturTransactionModel> returTransactions =
          data.map((item) => ReturTransactionModel.fromJson(item)).toList();

      return returTransactions;
    } else {
      final errorData = jsonDecode(response.body);
      throw Exception(errorData['message']);
    }
  }

  Future<ReturTransactionModel> createReturTransaction(
      String token, int quantity) async {
    final response = await http.post(
      Uri.parse('${BaseUrl.apiUrl}/retur-transaction/create'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'quantity': quantity,
      }),
    );
    if (response.statusCode == 201) {
      final data = jsonDecode(response.body);
      return data;
    } else {
      final errorData = jsonDecode(response.body);
      throw Exception(errorData['message']);
    }
  }
}
