import 'dart:convert';

import 'package:hanaang_app/models/open_pre_order_model.dart';
import 'package:hanaang_app/utilities/base_url.dart';
import 'package:http/http.dart' as http;

class OpenPreOrderService {
  Future<OpenPreOrderModel> getOpenPreOrder(String token) async {
    final response =
        await http.get(Uri.parse('${BaseUrl.apiUrl}/open-pre-order'), headers: {
      'Authorization': 'Bearer ${token}',
      'Content-Type': 'application/json',
    });

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return OpenPreOrderModel.fromJson(data["data"]);
    } else {
      final errorData = jsonDecode(response.body);
      throw Exception(errorData['message']);
    }
  }

  Future<OpenPreOrderModel> updateOpenPreOrder(
      String token, Map<String, dynamic> body) async {
    final response =
        await http.post(Uri.parse('${BaseUrl.apiUrl}/open-pre-order'),
            headers: {
              'Authorization': 'Bearer ${token}',
              'Content-Type': 'application/json',
            },
            body: jsonEncode(body));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return OpenPreOrderModel.fromJson(data["data"]);
    } else {
      final errorData = jsonDecode(response.body);
      throw Exception(errorData['message']);
    }
  }
}
