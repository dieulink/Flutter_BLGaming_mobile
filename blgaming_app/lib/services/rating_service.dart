import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:blgaming_app/models/request/rating_request.dart';
import 'package:blgaming_app/models/response/delete_rating_result.dart';
import 'package:blgaming_app/models/response/rating_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RatingService {
  static Future<List<RatingResponse>> fetchRatings(int productId) async {
    final url = Uri.parse(
      'http://192.168.5.139:8080/api/public/reviewList?pageNo=0&pageSize=1000&gameId=$productId',
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

  static Future<bool> hasUserBuyGame({
    required String userId,
    required int gameId,
  }) async {
    final uri = Uri.parse(
      "http://192.168.5.139:8080/api/public/hasUserBuyGame"
      "?userId=$userId&gameId=$gameId",
    );

    final res = await http.get(uri);

    if (res.statusCode != 200) {
      throw Exception("Check purchase failed");
    }

    final json = jsonDecode(res.body);
    return json["hasBuyProduct"] == true;
  }

  static Future<void> addReview({
    required String userId,
    required int gameId,
    required int score,
    required String comment,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");

    if (token == null) {
      throw Exception("User not logged in");
    }

    final uri = Uri.parse(
      "http://192.168.5.139:8080/api/addReview",
    );

    final res = await http.post(
      uri,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
      body: jsonEncode({
        "userId": userId,
        "gameId": gameId,
        "score": score,
        "comment": comment,
      }),
    );

    if (res.statusCode != 200) {
      throw Exception("Add review failed");
    }
  }

  static Future<void> deleteReview(int reviewId) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");

    if (token == null) {
      throw Exception("User not logged in");
    }

    final uri = Uri.parse(
      "http://192.168.5.139:8080/api/deleteReview?reviewId=$reviewId",
    );

    final res = await http.delete(
      uri,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );

    if (res.statusCode != 200) {
      throw Exception("Delete review failed");
    }
  }
}
