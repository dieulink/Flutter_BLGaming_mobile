import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
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
  int? productId;
  bool _isSubmitting = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    if (args != null && args['productId'] != null) {
      productId = args['productId'];
    }
  }

  Future<void> _submitReview() async {
    if (productId == null) return;

    if (score == 0) {
      _showSnack("Vui lòng chọn số sao đánh giá");
      return;
    }

    if (commentController.text.trim().isEmpty) {
      _showSnack("Vui lòng nhập nội dung đánh giá");
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('userId');

    if (userId == null || userId.isEmpty) {
      _showSnack("Vui lòng đăng nhập");
      return;
    }

    try {
      setState(() => _isSubmitting = true);

      await RatingService.addReview(
        userId: userId,
        gameId: productId!,
        score: score.toInt(),
        comment: commentController.text.trim(),
      );

      if (!mounted) return;

      _showSnack("Gửi đánh giá thành công");

      await Future.delayed(const Duration(milliseconds: 500));
      Navigator.pop(context, true);
    } catch (e) {
      _showSnack("Gửi đánh giá thất bại");
    } finally {
      if (mounted) {
        setState(() => _isSubmitting = false);
      }
    }
  }

  void _showSnack(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message,
            style: const TextStyle(fontFamily: "LD", color: white)),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(20),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  @override
  void dispose() {
    commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarRating(name: "Viết đánh giá"),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(height: 2, color: borderColor),
              const SizedBox(height: 10),
              Text(
                "Hãy chọn số điểm đánh giá của bạn về sản phẩm và dịch vụ",
                style: TextStyle(
                  color: textColor1,
                  fontFamily: "LD",
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 40),
              RatingBar.builder(
                initialRating: score,
                minRating: 1,
                allowHalfRating: false,
                itemCount: 5,
                unratedColor: white,
                itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  setState(() {
                    score = rating;
                  });
                },
              ),
              const SizedBox(height: 40),
              Align(
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
              const SizedBox(height: 10),
              SizedBox(
                height: 180,
                child: TextField(
                  controller: commentController,
                  maxLines: null,
                  expands: true,
                  style: const TextStyle(
                    fontSize: 14,
                    color: white,
                    fontFamily: 'LD',
                  ),
                  decoration: InputDecoration(
                    hintText: 'Nhập nội dung đánh giá ...',
                    hintStyle: const TextStyle(color: white),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: borderColor, width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: mainColor, width: 2),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
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
          border: Border(top: BorderSide(color: borderColor)),
        ),
        child: SizedBox(
          height: 50,
          child: ElevatedButton(
            onPressed: _isSubmitting ? null : _submitReview,
            style: ElevatedButton.styleFrom(
              backgroundColor: mainColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7),
              ),
            ),
            child: _isSubmitting
                ? const CircularProgressIndicator(color: white)
                : const Text(
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
