import 'dart:convert';

import 'package:hanaang_app/models/order_model.dart';
import 'package:hanaang_app/utilities/base_url.dart';
import 'package:http/http.dart' as http;

class OrderService {
  Future<List<OrderModel>> getOrder(String token) async {
    final response =
        await http.get(Uri.parse('${BaseUrl.apiUrl}/order'), headers: {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    });
    if (response.statusCode == 200) {
      final Map<String, dynamic> decodedResponse = jsonDecode(response.body);
      final List<dynamic> data = decodedResponse['data'];

      // Konversi setiap item dalam list menjadi PreOrderModel
      List<OrderModel> orders =
          data.map((item) => OrderModel.fromJson(item)).toList();

      return orders;
    } else {
      final errorData = jsonDecode(response.body);
      throw Exception(errorData['message']);
    }
  }

  Future<OrderModel> showOrder(String token, String orderNumber) async {
    final response = await http.get(
        Uri.parse('${BaseUrl.apiUrl}/order/show/${orderNumber}'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        });

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return OrderModel.fromJson(data["data"]);
    } else {
      final errorData = jsonDecode(response.body);
      throw Exception(errorData['message']);
    }
  }
}
