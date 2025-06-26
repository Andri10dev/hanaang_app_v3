import 'package:hanaang_app/models/finance/price_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:hanaang_app/utilities/base_url.dart';

class PriceService {
  Future<List<PriceModel>> getPrice(String token) async {
    final response = await http.get(
      Uri.parse('${BaseUrl.apiUrl}/price'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );

    print(response.body);
    if (response.statusCode == 200) {
      final Map<String, dynamic> decodedResponse = jsonDecode(response.body);
      final List<dynamic> data = decodedResponse['data'];

      // Konversi setiap item dalam list menjadi PreOrderModel
      List<PriceModel> Prices =
          data.map((item) => PriceModel.fromJson(item)).toList();

      return Prices;
    } else {
      final errorData = jsonDecode(response.body);
      throw Exception(errorData['message']);
    }
  }

  Future<PriceModel> createPrice(String token, int quantity) async {
    final response = await http.post(
      Uri.parse('${BaseUrl.apiUrl}/price/create'),
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
