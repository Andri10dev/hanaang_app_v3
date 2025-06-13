import 'dart:convert';

import 'package:hanaang_app/models/banner_model.dart';
import 'package:hanaang_app/utilities/base_url.dart';
import 'package:http/http.dart' as http;

class BannerService {
  Future<List<BannerModel>> getBanner(String token) async {
    final response = await http.get(
      Uri.parse('${BaseUrl.apiUrl}/banner'),
      headers: {'Authorization': 'Bearer $token'},
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List<dynamic> bannerList = data["data"];
      return bannerList.map((json) => BannerModel.fromJson(json)).toList();
    } else {
      final errorData = jsonDecode(response.body);
      throw Exception(errorData['message']);
    }
  }

  Future<BannerModel> getBannerById(String id) async {
    final response = await http.get(
      Uri.parse('${BaseUrl.apiUrl}/banner/$id'),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return BannerModel.fromJson(data);
    } else {
      final errorData = jsonDecode(response.body);
      throw Exception(errorData['message']);
    }
  }

  Future<BannerModel> createBanner(BannerModel data) async {
    final response = await http.post(
      Uri.parse('${BaseUrl.apiUrl}/banner'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data.toJson()),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return BannerModel.fromJson(data);
    } else {
      final errorData = jsonDecode(response.body);
      throw Exception(errorData['message']);
    }
  }
}
