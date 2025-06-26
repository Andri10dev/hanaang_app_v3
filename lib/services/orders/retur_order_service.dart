import 'dart:math';

import 'package:hanaang_app/models/retur_body_model.dart';
import 'package:hanaang_app/models/retur_order_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:hanaang_app/utilities/base_url.dart';

class ReturOrderService {
  Future<List<ReturOrderModel>> getReturOrder(String token) async {
    final response = await http.get(
      Uri.parse('${BaseUrl.apiUrl}/retur-order'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> decodedResponse = jsonDecode(response.body);
      final List<dynamic> data = decodedResponse['data'];

      // Konversi setiap item dalam list menjadi ReturOrderModel
      List<ReturOrderModel> ReturOrders =
          data.map((item) => ReturOrderModel.fromJson(item)).toList();

      return ReturOrders;
    } else {
      final errorData = jsonDecode(response.body);
      throw Exception(errorData['message']);
    }
  }

  Future<ReturOrderModel> showReturOrder(
      String token, String returNumber) async {
    final response = await http.get(
      Uri.parse('${BaseUrl.apiUrl}/retur-order/show/$returNumber'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return ReturOrderModel.fromJson(data["data"]);
    } else {
      final errorData = jsonDecode(response.body);
      throw Exception(errorData['message']);
    }
  }

  Future<Map<String, dynamic>> createReturOrder(
      String token, ReturOrderBodyRequestModel body) async {
    final uri = Uri.parse('${BaseUrl.apiUrl}/retur-order/create');
    final request = http.MultipartRequest('POST', uri);
    request.headers.addAll({
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
      'Content-Type': 'multipart/form-data',
    });
    request.fields['order_number'] = body.orderNumber;
    request.fields['quantity'] = body.quantity.toString();
    request.fields['description'] = body.description;
    for (int i = 0; i < body.images.length; i++) {
      request.files.add(await http.MultipartFile.fromPath(
        'images[$i]',
        body.images[i].path,
      ));
    }
    final streamResponse = await request.send();
    final response = await http.Response.fromStream(streamResponse);

    if (response.statusCode == 201) {
      final data = jsonDecode(response.body);
      return data;
    } else {
      final errorData = jsonDecode(response.body);
      print(errorData);
      throw Exception(errorData['message']);
    }
  }
}
