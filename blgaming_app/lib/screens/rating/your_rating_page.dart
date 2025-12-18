import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:blgaming_app/models/response/rating_response.dart';
import 'package:blgaming_app/screens/rating/widgets/app_bar_rating.dart';
import 'package:blgaming_app/screens/rating/widgets/item_rating.dart';
import 'package:blgaming_app/screens/rating/widgets/item_rating_delete.dart';
import 'package:blgaming_app/services/rating_service.dart';
import 'package:blgaming_app/ui_value.dart';

class YourRatingPage extends StatefulWidget {
  const YourRatingPage({super.key});

  @override
  State<YourRatingPage> createState() => _YourRatingPageState();
}

class _YourRatingPageState extends State<YourRatingPage> {
  List<RatingResponse> _ratings = [];
  int? _productId;
  bool _isLoading = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    if (args != null && args['productId'] != null) {
      _productId = args['productId'];
      fetchRatings(_productId!);
    }
  }

  Future<void> fetchRatings(int productId) async {
    try {
      final result = await RatingService.fetchRatingsUser(productId);
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
      appBar: AppBarRating(name: "Đánh giá của bạn"),
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
                    return ItemRatingDelete(
                      name: rating.userName,
                      score: rating.score.toDouble(),
                      time: DateFormat('dd/MM/yyyy').format(rating.createdAt),
                      comment: rating.comment,
                      ratingId: rating.id,
                      onDelete: () async {
                        try {
                          await RatingService.deleteRating(rating.id);
                          await fetchRatings(_productId!);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Row(
                                children: [
                                  Icon(Icons.download_done_rounded,
                                      color: white),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Text(
                                      "Đã xóa đánh giá",
                                      style: TextStyle(fontFamily: "LD"),
                                    ),
                                  ),
                                ],
                              ),
                              backgroundColor: textColor1,
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              margin: const EdgeInsets.all(20),
                              duration: const Duration(seconds: 1),
                              elevation: 8,
                            ),
                          );
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Row(
                                children: [
                                  Icon(Icons.error_outline, color: white),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Text(
                                      "Xóa thất bại",
                                      style: TextStyle(fontFamily: "LD"),
                                    ),
                                  ),
                                ],
                              ),
                              backgroundColor: textColor1,
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              margin: const EdgeInsets.all(20),
                              duration: const Duration(seconds: 1),
                              elevation: 8,
                            ),
                          );
                        }
                      },
                    );
                  },
                ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          // color: Colors.white,
          border: Border(top: BorderSide(color: borderColor)),
        ),
        child: Container(
          height: 50,
          width: getWidth(context) * 0.8,
          child: ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(
                context,
                "writeRatingPage",
                arguments: {'productId': _productId!},
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: mainColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7),
              ),
            ),
            child: Text(
              'Viết đánh giá',
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
