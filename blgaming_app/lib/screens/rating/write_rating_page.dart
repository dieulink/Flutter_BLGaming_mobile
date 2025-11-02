import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:blgaming_app/models/request/rating_request.dart';
import 'package:blgaming_app/screens/rating/widgets/app_bar_rating.dart';
import 'package:blgaming_app/services/rating_service.dart';
import 'package:blgaming_app/ui_value.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WriteRatingPage extends StatefulWidget {
  const WriteRatingPage({super.key});

  @override
  State<WriteRatingPage> createState() => _WriteRatingPageState();
}

class _WriteRatingPageState extends State<WriteRatingPage> {
  double score = 0;
  final commentController = TextEditingController();
  late int productId;
  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final int? productId = args?['productId'];
    return Scaffold(
      backgroundColor: white,
      appBar: AppBarRating(name: "Viết đánh giá"),
      body: Container(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(height: 2, color: borderColor),
              SizedBox(height: 10),
              Text(
                "Hãy chọn số điểm đánh giá của bạn về sản phẩm và dịch vụ",
                style: TextStyle(
                  color: textColor1,
                  fontFamily: "LD",
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              SizedBox(height: 40),
              Container(
                child: RatingBar.builder(
                  initialRating: 0,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: false,
                  itemCount: 5,
                  itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) =>
                      Icon(Icons.star, color: Colors.amber),
                  onRatingUpdate: (rating) {
                    score = rating;
                  },
                ),
              ),
              SizedBox(height: 40),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Bình luận của bạn : ",
                  style: TextStyle(
                    color: textColor1,
                    fontFamily: "LD",
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                height: 180,
                child: TextField(
                  maxLines: null,
                  expands: true,
                  controller: commentController,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: textColor3,
                    fontFamily: 'LD',
                  ),
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    hintText: 'Nhập nội dung đánh giá ...',
                    hintStyle: TextStyle(color: textColor2),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: borderColor, width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: mainColor, width: 2),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
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
            onPressed: () async {
              final prefs = await SharedPreferences.getInstance();
              final userId = prefs.getString('userId');
              int id = int.parse(userId!);
              final request = RatingRequest(
                userId: id,
                productId: productId!,
                score: score.toInt(),
                comment: commentController.text.trim(),
              );
              try {
                final result = await RatingService.addRating(request);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Row(
                      children: [
                        Icon(Icons.error_outline, color: white),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            "Gửi đánh giá thành công",
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
                // Navigator.pop(
                //   context,
                //   "yourRatingPage",
                //   arguments: {'productId': productId},
                // );
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Row(
                      children: [
                        Icon(Icons.error_outline, color: white),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            "Gửi đánh giá thất bại",
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
            style: ElevatedButton.styleFrom(
              backgroundColor: mainColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7),
              ),
            ),
            child: Text(
              'Gửi đánh giá',
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
