import 'dart:convert';

import 'package:hanaang_app/models/order_transaction_model.dart';
import 'package:hanaang_app/utilities/base_url.dart';
import 'package:http/http.dart' as http;

class OrderTransactionService {
  Future<List<OrderTransactionModel>> getOrderTransaction(
      String token, String orderNumber) async {
    final response = await http.get(
        Uri.parse(
            BaseUrl.apiUrl + '/order-transaction?order_number=$orderNumber'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        });

    if (response.statusCode == 200) {
      final Map<String, dynamic> decodedResponse = jsonDecode(response.body);
      final List<dynamic> data = decodedResponse['data'];

      // Konversi setiap item dalam list menjadi OrderTransactionModel
      List<OrderTransactionModel> orderTransactions =
          data.map((item) => OrderTransactionModel.fromJson(item)).toList();

      return orderTransactions;
    } else {
      final errorData = jsonDecode(response.body);
      throw Exception(errorData['message']);
    }
  }
}
