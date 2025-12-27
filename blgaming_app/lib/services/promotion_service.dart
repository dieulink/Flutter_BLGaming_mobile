import 'dart:convert';
import 'package:blgaming_app/models/response/promotion.dart';
import 'package:blgaming_app/models/response/promotion_list_response.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class PromotionService {
  static const String baseUrl = "http://192.168.5.139:8080/api/public";

  static Uri _buildUrl() {
    return Uri.parse("$baseUrl/promotion");
  }

  static Uri _buildUrlByUser(String userId) {
    return Uri.parse("$baseUrl/promotionByUserId?userId=$userId");
  }

  static Uri _buildUpcomingUrl() {
    return Uri.parse("$baseUrl/promotion/upcoming");
  }

  static List<Promotion> _parsePromotions(http.Response res) {
    final Map<String, dynamic> jsonData = jsonDecode(res.body);
    final response = PromotionListResponse.fromJson(jsonData);
    return response.listPromotion;
  }

  static Future<List<Promotion>> fetchPromotions() async {
    final url = _buildUrl();
    final res = await http.get(url);

    if (res.statusCode != 200) {
      throw Exception("API error: ${res.statusCode}");
    }

    return _parsePromotions(res);
  }

  static Future<String> _getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString("userId");

    if (userId == null || userId.isEmpty) {
      throw Exception("UserId not found in SharedPreferences");
    }

    return userId;
  }

  static Future<List<Promotion>> fetchPromotionByUserId() async {
    final userId = await _getUserId();

    final url = _buildUrlByUser(userId);
    final res = await http.get(url);

    if (res.statusCode != 200) {
      throw Exception("API error: ${res.statusCode}");
    }

    return _parsePromotions(res);
  }

  static Future<List<Promotion>> fetchUpcomingPromotions() async {
    final url = _buildUpcomingUrl();
    final res = await http.get(url);

    if (res.statusCode != 200) {
      throw Exception("API error: ${res.statusCode}");
    }

    return _parsePromotions(res);
  }
}
