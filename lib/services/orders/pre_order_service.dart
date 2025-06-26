import 'package:hanaang_app/features/orders/pre_order/index.dart';
import 'package:hanaang_app/models/pre_order_detail_model.dart';
import 'package:hanaang_app/models/pre_order_model.dart';
import 'package:hanaang_app/models/pre_order_update_body_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:hanaang_app/utilities/base_url.dart';

class PreOrderService {
  Future<List<PreOrderModel>> getPreOrder(
      String token, Map<String, dynamic>? params) async {
    final defaultParams = {'buyer': '0'};
    final mergeParams = {...defaultParams, ...?params};
    final uri = Uri.parse('${BaseUrl.apiUrl}/pre-order').replace(
      queryParameters:
          mergeParams.map((key, value) => MapEntry(key, value.toString())),
    );

    final response = await http.get(
      uri,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

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

  Future<PreOrderModel> showPreOrder(String token, String poNumber) async {
    final response = await http.get(
      Uri.parse('${BaseUrl.apiUrl}/pre-order/show/$poNumber'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return PreOrderModel.fromJson(data["data"]);
    } else {
      final errorData = jsonDecode(response.body);
      throw Exception(errorData['message']);
    }
  }

  Future<Map<String, dynamic>> createPreOrder(
      String token, int quantity) async {
    try {
      final response = await http.post(
        Uri.parse('${BaseUrl.apiUrl}/pre-order/create'),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'quantity': quantity,
        }),
      );

      if (response.statusCode == 201) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);

        // Pastikan ada data dalam response
        if (responseData.containsKey('data')) {
          return responseData['data'];
        } else {
          // Jika response langsung berisi data pre-order
          return responseData;
        }
      } else if (response.statusCode == 422) {
        final data = jsonDecode(response.body);
        final errorMessage =
            data['message_v2'] ?? "Terjadi kesalahan pada server";
        throw Exception(errorMessage);
      } else {
        final errorData = jsonDecode(response.body);
        final errorMessage =
            errorData['message'] ?? 'Terjadi kesalahan pada server';
        throw Exception(errorMessage);
      }
    } catch (e) {
      if (e is FormatException) {
        throw Exception('Format response tidak valid');
      }
      rethrow;
    }
  }

  Future<Map<String, dynamic>> cancelPreOrder(
      String token, String poNumber) async {
    try {
      final response = await http.post(
        Uri.parse('${BaseUrl.apiUrl}/pre-order/cancel'),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'po_number': poNumber,
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);

        // Pastikan ada data dalam response
        if (responseData.containsKey('data')) {
          return responseData['data'];
        } else {
          // Jika response langsung berisi data pre-order
          return responseData;
        }
      } else if (response.statusCode == 422) {
        final data = jsonDecode(response.body);
        final errorMessage =
            data['message_v2'] ?? "Terjadi kesalahan pada server";
        throw Exception(errorMessage);
      } else {
        final errorData = jsonDecode(response.body);
        final errorMessage =
            errorData['message'] ?? 'Terjadi kesalahan pada server';
        throw Exception(errorMessage);
      }
    } catch (e) {
      if (e is FormatException) {
        throw Exception('Format response tidak valid');
      }
      rethrow;
    }
  }

  Future<Map<String, dynamic>> updatePreOrder(
      String token, PreOrderUpdateBody body) async {
    try {
      final response = await http.post(
        Uri.parse('${BaseUrl.apiUrl}/pre-order/update'),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'po_number': body.poNumber,
          'quantity': body.quantity,
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);

        // Pastikan ada data dalam response
        if (responseData.containsKey('data')) {
          return responseData['data'];
        } else {
          // Jika response langsung berisi data pre-order
          return responseData;
        }
      } else if (response.statusCode == 422) {
        final data = jsonDecode(response.body);
        final errorMessage =
            data['message_v2'] ?? "Terjadi kesalahan pada server";
        throw Exception(errorMessage);
      } else {
        final errorData = jsonDecode(response.body);
        final errorMessage =
            errorData['message'] ?? 'Terjadi kesalahan pada server';
        throw Exception(errorMessage);
      }
    } catch (e) {
      if (e is FormatException) {
        throw Exception('Format response tidak valid');
      }
      rethrow;
    }
  }
}
