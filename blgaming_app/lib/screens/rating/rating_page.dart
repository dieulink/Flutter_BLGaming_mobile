import 'package:blgaming_app/ui_value.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:blgaming_app/models/response/rating_response.dart';
import 'package:blgaming_app/screens/rating/widgets/app_bar_rating.dart';
import 'package:blgaming_app/screens/rating/widgets/item_rating.dart';
import 'package:blgaming_app/services/rating_service.dart';
// import 'package:blgaming_app/ui_value.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RatingPage extends StatefulWidget {
  const RatingPage({super.key});

  @override
  State<RatingPage> createState() => _RatingPageState();
}

class _RatingPageState extends State<RatingPage> {
  List<RatingResponse> _ratings = [];
  int? _productId;
  bool _isLoading = true;
  bool _hasPurchased = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    if (args != null && args['productId'] != null) {
      _productId = args['productId'];
      fetchRatings(_productId!);
      checkUserPurchased();
    }
  }

  Future<void> checkUserPurchased() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      int userId = int.parse(prefs.getString('userId') ?? '0');

      final result = await RatingService.checkIfUserPurchased(
        userId,
        _productId!,
      );
      setState(() {
        _hasPurchased = result == 1;
        _isLoading = false;
      });
    } catch (e) {
      print("Lỗi kiểm tra mua hàng: $e");
      setState(() {
        _hasPurchased = false;
        _isLoading = false;
      });
    }
  }

  Future<void> fetchRatings(int productId) async {
    try {
      final result = await RatingService.fetchRatings(productId);
      setState(() {
        _ratings = result;
        _isLoading = false;
      });
    } catch (e) {
      print("Lỗi: $e");
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBarRating(name: "Tất cả đánh giá"),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _ratings.isEmpty
          ? Center(
              child: Text(
                "Chưa có đánh giá nào.",
                style: TextStyle(
                  color: textColor1,
                  fontFamily: "LD",
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            )
          : ListView.builder(
              padding: EdgeInsets.all(10),
              itemCount: _ratings.length,
              itemBuilder: (context, index) {
                final rating = _ratings[index];
                return ItemRating(
                  name: rating.userName,
                  score: rating.score.toDouble(),
                  time: DateFormat('dd/MM/yyyy').format(rating.createdAt),
                  comment: rating.comment,
                );
              },
            ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: borderColor)),
        ),
        child: Container(
          height: 50,
          width: getWidth(context) * 0.8,
          child: ElevatedButton(
            onPressed: _hasPurchased
                ? () {
                    Navigator.pushNamed(
                      context,
                      "yourRatingPage",
                      arguments: {'productId': _productId!},
                    );
                  }
                : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: mainColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7),
              ),
            ),
            child: Text(
              'Đánh giá của bạn',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                fontFamily: "LD",
                color: white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
