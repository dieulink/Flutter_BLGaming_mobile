import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:blgaming_app/models/request/add_cart_request.dart';
import 'package:blgaming_app/models/response/cart_item_model.dart';
import 'package:blgaming_app/models/response/item.dart';
import 'package:blgaming_app/models/response/rating_response.dart';
import 'package:blgaming_app/screens/rating/widgets/item_rating.dart';
import 'package:blgaming_app/screens/home_screens/widgets/app_bar_custom.dart';
import 'package:blgaming_app/screens/home_screens/widgets/product_image_slider.dart';
import 'package:blgaming_app/services/cart_service.dart';
import 'package:blgaming_app/services/product_service.dart';
import 'package:blgaming_app/services/rating_service.dart';
import 'package:blgaming_app/ui_value.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductDetail extends StatefulWidget {
  final int id;

  const ProductDetail({super.key, required this.id});

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  Item? _item;
  List<RatingResponse> _ratings = [];

  @override
  void initState() {
    super.initState();
    _loadProductItem(widget.id);
    _loadRatings(widget.id);
  }

  Future<void> _loadRatings(int id) async {
    try {
      final ratings = await RatingService.fetchRatings(id);
      setState(() {
        _ratings = ratings;
      });
    } catch (e) {
      print("Lỗi khi load ratings: $e");
    }
  }

  double getAverageRating() {
    if (_ratings.isEmpty) return 0.0;
    int totalScore = _ratings.fold(0, (sum, rating) => sum + rating.score);
    return totalScore / _ratings.length;
  }

  Future<void> _loadProductItem(int id) async {
    try {
      final item = await ProductService.fetchProductItem(id);
      setState(() {
        _item = item;
      });
    } catch (e) {
      print("Lỗi khi load sản phẩm: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(),
      body: _item == null
          ? const Center(child: CircularProgressIndicator())
          : Container(
              padding: const EdgeInsets.all(10.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ProductImageSlider(
                      mainImage: _item!.imageUrl,
                      descImages: _item!.descImages,
                    ),
                    const SizedBox(height: 10),

                    // Giá & tồn kho
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${NumberFormat("#,###", "vi_VN").format(_item!.price)} vnđ",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: red,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          "Số lượng còn: ${_item!.stock}",
                          style: TextStyle(
                            fontSize: 13,
                            fontFamily: "LD",
                            color: mainColor,
                          ),
                        ),
                      ],
                    ),
                    Container(height: 2, color: backgroudColor),

                    const SizedBox(height: 10),

                    // Tên sản phẩm
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color.fromARGB(22, 255, 255, 255),
                      ),
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              _item!.name,
                              style: TextStyle(
                                fontSize: 15,
                                fontFamily: "LD",
                                fontWeight: FontWeight.bold,
                                color: mainColor,
                              ),
                            ),
                          ),
                          // Mô tả
                          Text(
                            _item!.description,
                            style: TextStyle(
                              fontSize: 13,
                              fontFamily: "LD",
                              color: white,
                            ),
                            textAlign: TextAlign.justify,
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(height: 2, color: backgroudColor),
                    const SizedBox(height: 5),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              "${getAverageRating().toStringAsFixed(1)}",
                              style: TextStyle(
                                fontSize: 17,
                                fontFamily: "LD",
                                fontWeight: FontWeight.bold,
                                color: white,
                              ),
                            ),
                            const Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 18,
                            ),
                            const SizedBox(width: 10),
                            Text(
                              "Đánh giá (${_ratings.length})",
                              style: TextStyle(
                                fontSize: 15,
                                fontFamily: "LD",
                                fontWeight: FontWeight.bold,
                                color: white,
                              ),
                            ),
                          ],
                        ),
                        InkWell(
                          onTap: () async {
                            await Navigator.pushNamed(
                              context,
                              "ratingPage",
                              arguments: {'productId': _item!.id},
                            ).then((_) => _loadRatings(widget.id));
                          },
                          child: Row(
                            children: const [
                              Text(
                                "Tất cả đánh giá",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: "LD",
                                  fontWeight: FontWeight.bold,
                                  color: mainColor,
                                ),
                              ),
                              Icon(
                                Icons.navigate_next_rounded,
                                color: mainColor,
                                size: 20,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    // Rating đầu tiên
                    _ratings.isNotEmpty
                        ? ItemRating(
                            name: _ratings[0].userName,
                            score: _ratings[0].score.toDouble(),
                            time: DateFormat(
                              'dd/MM/yyyy',
                            ).format(_ratings[0].createdAt),
                            comment: _ratings[0].comment,
                          )
                        : Container(
                            margin: const EdgeInsets.all(10),
                            child: Text(
                              "Chưa có đánh giá",
                              style: TextStyle(
                                fontSize: 14,
                                color: white,
                                fontFamily: "LD",
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
          //color: Colors.white,
          border: Border(top: BorderSide(color: borderColor)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // Nút thêm vào giỏ hàng
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: mainColor),
                borderRadius: BorderRadius.circular(7),
              ),
              height: 50,
              child: ElevatedButton(
                onPressed: _item!.stock == 0
                    ? null
                    : () async {
                        final prefs = await SharedPreferences.getInstance();
                        final userId = prefs.getString('userId');

                        if (userId == null || userId.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: const Text(
                                "Vui lòng đăng nhập để thêm vào giỏ hàng!",
                              ),
                              backgroundColor: Colors.redAccent,
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              margin: const EdgeInsets.all(20),
                              duration: const Duration(seconds: 2),
                            ),
                          );
                          return;
                        }

                        final response = await CartService.updateCartQuantity(
                          gameId: _item!.id,
                          userId: userId,
                          quantity: 1, // Mỗi lần thêm 1 sản phẩm
                        );

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Row(
                              children: [
                                Icon(
                                  response != null
                                      ? Icons.check_circle_outline
                                      : Icons.error_outline,
                                  color: Colors.white,
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    response != null
                                        ? "Đã thêm 1 sản phẩm vào giỏ hàng"
                                        : "Thêm vào giỏ hàng thất bại",
                                    style: const TextStyle(fontFamily: "LD"),
                                  ),
                                ),
                              ],
                            ),
                            backgroundColor: response != null
                                ? Colors.green
                                : Colors.redAccent,
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            margin: const EdgeInsets.all(20),
                            duration: const Duration(seconds: 1),
                            elevation: 8,
                          ),
                        );
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7),
                  ),
                ),
                child: const Text(
                  'Thêm vào giỏ',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: "LD",
                    fontWeight: FontWeight.bold,
                    color: mainColor,
                  ),
                ),
              ),
            ),

            const SizedBox(width: 10),

            // Nút mua ngay
            SizedBox(
              width: getWidth(context) * 0.4,
              height: 50,
              child: ElevatedButton(
                onPressed: _item!.stock == 0
                    ? null
                    : () {
                        final cartItem = CartItemModel(
                          gameId: _item!.id,
                          name: _item!.name,
                          price: _item!.price.toDouble(),
                          quantity: 1,
                          imageUrl: _item!.imageUrl,
                          inStock: _item!.stock,
                        );

                        Navigator.pushNamed(
                          context,
                          "orderPage",
                          arguments: {
                            'items': [cartItem],
                            'totalPrice': _item!.price,
                            'totalQuantity': 1,
                            'isCart': 0,
                          },
                        );
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: mainColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7),
                  ),
                ),
                child: const Text(
                  'Mua ngay',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: white,
                    fontFamily: "LD",
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
