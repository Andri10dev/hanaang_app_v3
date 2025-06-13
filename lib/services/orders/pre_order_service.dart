import 'package:hanaang_app/models/pre_order_detail_model.dart';
import 'package:hanaang_app/models/pre_order_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:hanaang_app/utilities/base_url.dart';

class PreOrderService {
  Future<List<PreOrderModel>> getPreOrder(
      String token, Map<String, dynamic> params) async {
    final response = await http.get(
      Uri.parse('${BaseUrl.apiUrl}/pre-order').replace(
          queryParameters:
              params.map((key, value) => MapEntry(key, value.toString()))),
      headers: {
        'Authorization': 'Bearer ${token}',
        'Content-Type': 'application/json',
      },
    );
    print(response.body);
    if (response.statusCode == 200) {
      final Map<String, dynamic> decodedResponse = jsonDecode(response.body);
      final List<dynamic> data = decodedResponse['data'];

      // Konversi setiap item dalam list menjadi PreOrderModel
      List<PreOrderModel> preOrders =
          data.map((item) => PreOrderModel.fromJson(item)).toList();

      return preOrders;
    } else {
      final errorData = jsonDecode(response.body);
      throw Exception(errorData['message']);
    }
  }

  Future<PreOrderDetailModel> showPreOrder(
      String token, String poNumber) async {
    final response = await http.get(
      Uri.parse('${BaseUrl.apiUrl}/pre-order/show/${poNumber}'),
      headers: {
        'Authorization': 'Bearer ${token}',
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print(data["data"]);
      return PreOrderDetailModel.fromJson(data["data"]);
    } else {
      final errorData = jsonDecode(response.body);
      throw Exception(errorData['message']);
    }
  }

  Future<PreOrderModel> createPreOrder(String token, int quantity) async {
    final response = await http.post(
      Uri.parse('${BaseUrl.apiUrl}/pre-order/create'),
      headers: {
        'Authorization': 'Bearer ${token}',
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
