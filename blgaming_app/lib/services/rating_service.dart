import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:blgaming_app/models/request/rating_request.dart';
import 'package:blgaming_app/models/response/delete_rating_result.dart';
import 'package:blgaming_app/models/response/rating_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RatingService {
  static Future<List<RatingResponse>> fetchRatings(int productId) async {
    final url = Uri.parse(
      'http://192.168.5.138:8080/api/public/reviewList?pageNo=0&pageSize=1000&gameId=$productId',
    );

    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = json.decode(response.body);
      final List<dynamic> reviews = jsonData['reviewList'] ?? [];

      return reviews.map((e) => RatingResponse.fromJson(e)).toList();
    } else {
      throw Exception(
        'Không thể tải danh sách đánh giá (${response.statusCode})',
      );
    }
  }

  static Future<List<RatingResponse>> fetchRatingsUser(int productId) async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    String? userId = prefs.getString('userId');
    int id = int.parse(userId!);
    final url = Uri.parse(
      'http://192.168.5.138:8080/api/rating/list/$productId/$id',
    );
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => RatingResponse.fromJson(json)).toList();
    } else {
      throw Exception('lỗi');
    }
  }

  static Future<DeleteRatingResult> deleteRating(int ratingId) async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    final url = Uri.parse(
      'http://192.168.5.138:8080/api/rating/delete/$ratingId',
    );
    final response = await http.delete(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonBody = jsonDecode(response.body);
      return DeleteRatingResult.fromJson(jsonBody);
    } else {
      throw Exception('Xoá đánh giá thất bại: ${response.statusCode}');
    }
  }

  static Future<int> checkIfUserPurchased(int userId, int productId) async {
    final url = Uri.parse(
      "http://192.168.5.138:8080/api/rating/check_purchased?userId=$userId&productId=$productId",
    );
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        return int.parse(response.body);
      } else {
        throw Exception("Failed to check purchase status");
      }
    } catch (e) {
      print("Lỗi khi gọi API kiểm tra mua hàng: $e");
      rethrow;
    }
  }

  static Future<DeleteRatingResult> addRating(RatingRequest request) async {
    final url = Uri.parse('http://192.168.5.138:8080/api/rating/add');
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(request.toJson()),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonBody = jsonDecode(response.body);
      return DeleteRatingResult.fromJson(jsonBody);
    } else {
      throw Exception('lỗi');
    }
  }
}
