import 'package:hanaang_app/models/finance/bonus_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:hanaang_app/utilities/base_url.dart';

class BonusService {
  Future<List<BonusModel>> getBonus(String token) async {
    final response = await http.get(
      Uri.parse('${BaseUrl.apiUrl}/bonus'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> decodedResponse = jsonDecode(response.body);
      final List<dynamic> data = decodedResponse['data'];

      // Konversi setiap item dalam list menjadi PreOrderModel
      List<BonusModel> Bonuses =
          data.map((item) => BonusModel.fromJson(item)).toList();

      return Bonuses;
    } else {
      final errorData = jsonDecode(response.body);
      throw Exception(errorData['message']);
    }
  }

  Future<BonusModel> createBonus(String token, int quantity) async {
    final response = await http.post(
      Uri.parse('${BaseUrl.apiUrl}/bonus/create'),
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
