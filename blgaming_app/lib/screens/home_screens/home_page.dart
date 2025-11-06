import 'dart:async';

import 'package:blgaming_app/screens/home_screens/category_page.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:blgaming_app/models/response/product.dart';
import 'package:blgaming_app/models/response/product_category.dart';
import 'package:blgaming_app/screens/home_screens/cart_page.dart';
import 'package:blgaming_app/screens/home_screens/category_item_page.dart';
import 'package:blgaming_app/screens/home_screens/widgets/item_product.dart';
import 'package:blgaming_app/screens/home_screens/widgets/search_input.dart';
import 'package:blgaming_app/services/category_service.dart';
import 'package:blgaming_app/services/product_service.dart';
import 'package:blgaming_app/ui_value.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();

  List<Product> _products = [];
  List<ProductCategory> _categories = [];
  List<Product> _bestSaleProducts = [];
  bool _isLoading = false;
  bool _hasMore = true;
  int _page = 0;
  final int _size = 20;
  String _address = '';
  @override
  void initState() {
    super.initState();
    _loadProducts();
    _loadCategories();
    _loadBestSale();
    _scrollController.addListener(_onScroll);
  }

  Future<void> _loadCategories() async {
    try {
      final categories = await CategoryService.fetchCategories();
      setState(() {
        _categories = categories;
      });
    } catch (e) {
      print("Lỗi khi load category: $e");
    }
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 200 &&
        !_isLoading &&
        _hasMore) {
      _loadProducts();
    }
  }

  Future<void> _loadBestSale() async {
    final products = await ProductService.bestsale();
    setState(() {
      _bestSaleProducts = products;
    });
  }

  Future<void> _loadProducts() async {
    setState(() => _isLoading = true);
    try {
      final products = await ProductService.fetchProducts(
        page: _page,
        size: _size,
      );

      setState(() {
        _products.addAll(products);
        _isLoading = false;
        _page++;

        if (products.length < _size) {
          _hasMore = false;
        }
      });
    } catch (e) {
      print("Lỗi khi tải sản phẩm: $e");
      setState(() {
        _isLoading = false;
        _hasMore = false;
      });
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: SafeArea(
          child: Container(
            color: mainColor,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: SearchInput(
                        hintText: "Bạn muốn tìm gì ?",
                        iconPath: "assets/icons/system_icon/24px/Search.png",
                      ),
                    ),
                    //SizedBox(width: 10),
                    // InkWell(
                    //   onTap: () {
                    //     Navigator.of(context).push(
                    //       PageRouteBuilder(
                    //         pageBuilder:
                    //             (context, animation, secondaryAnimation) =>
                    //                 CartPage(),
                    //         transitionsBuilder:
                    //             (
                    //               context,
                    //               animation,
                    //               secondaryAnimation,
                    //               child,
                    //             ) {
                    //               return FadeTransition(
                    //                 opacity: animation,
                    //                 child: child,
                    //               );
                    //             },
                    //       ),
                    //     );
                    //   },
                    //   child: Image.asset(
                    //     "assets/icons/system_icon/24px/Cart.png",
                    //     height: 50,
                    //     color: backgroudColor,
                    //   ),
                    // ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),

      body: SafeArea(
        child: Container(
          // padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
          child: SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 10),
                          child: CarouselSlider.builder(
                            itemCount: _bestSaleProducts.length,
                            itemBuilder: (context, index, realIndex) {
                              final product = _bestSaleProducts[index];
                              if (product.imageUrl != null &&
                                  !product.imageUrl.trim().isEmpty) {
                                return Container(
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                  ),
                                  width: getWidth(context) - 20,
                                  height: 170,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.grey[200],
                                    image: DecorationImage(
                                      image: NetworkImage(product.imageUrl),
                                      fit: BoxFit.fitWidth,
                                    ),
                                  ),
                                );
                              } else {
                                // fallback placeholder when no image is available
                                return Container(
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                  ),
                                  width: getWidth(context) - 20,
                                  height: 170,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.grey[200],
                                    image: const DecorationImage(
                                      image: AssetImage(
                                        'assets/imgs/default.png',
                                      ),
                                      fit: BoxFit.fitWidth,
                                    ),
                                  ),
                                );
                              }
                            },
                            options: CarouselOptions(
                              height: 170,
                              autoPlay: true, // 👈 tự động chạy
                              autoPlayInterval: const Duration(
                                seconds: 3,
                              ), // đổi mỗi 3s
                              autoPlayAnimationDuration: const Duration(
                                milliseconds: 800,
                              ),
                              enlargeCenterPage: true,
                              viewportFraction: 1, // hiển thị full chiều ngang
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 2,
                          ),
                          width: getWidth(context),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(0),
                          ),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: _categories.map((Category) {
                                return Container(
                                  padding: const EdgeInsets.all(8.0),
                                  height: 105,
                                  width: 85,
                                  child: Column(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Navigator.of(context).push(
                                            PageRouteBuilder(
                                              pageBuilder:
                                                  (
                                                    context,
                                                    animation,
                                                    secondaryAnimation,
                                                  ) => CategoryPage(
                                                    id: Category.id,
                                                    name: Category.name,
                                                  ),
                                            ),
                                          );
                                        },
                                        child: Container(
                                          height: 50,
                                          width: 70,
                                          decoration: BoxDecoration(
                                            color: backgroudColor,
                                            border: Border.all(
                                              color: backgroudColor,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                          ),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadiusGeometry.circular(
                                                  10,
                                                ),
                                            child: ClipRRect(
                                              child: Image.network(
                                                Category.imageUrl,
                                                fit: BoxFit.fill,
                                                errorBuilder:
                                                    (
                                                      context,
                                                      error,
                                                      stackTrace,
                                                    ) {
                                                      return Image.asset(
                                                        'assets/imgs/default.png',
                                                        fit: BoxFit.fill,
                                                      );
                                                    },
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        Category.name,
                                        style: TextStyle(
                                          color: white,
                                          fontFamily: "LD",
                                          //fontWeight: FontWeight.bold,
                                          fontSize: 11,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.clip,
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          height: 240,
                          width: getWidth(context),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [mainColor, mainColor3],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomRight,
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Image.asset(
                                    "assets/imgs/hot.gif",
                                    height: 40,
                                  ),
                                  Text(
                                    'Hot Sale !!!',
                                    style: TextStyle(
                                      color: white,
                                      fontSize: 13,
                                      fontFamily: "LD",
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(width: 20),

                                  const DailyCountdown(),
                                  Spacer(),
                                  Icon(
                                    Icons.navigate_next_rounded,
                                    color: white,
                                  ),
                                ],
                              ),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [
                                    for (int i = 0; i < 20; i++)
                                      Container(
                                        width: 120,
                                        height: 180,
                                        margin: EdgeInsets.only(right: 5),
                                        padding: EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            5,
                                          ),
                                          color: itemColor,
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              child: Image.asset(
                                                "assets/imgs/background5.png",
                                                fit: BoxFit.fill,
                                                height: 90,
                                                width: 120,
                                              ),
                                            ),
                                            SizedBox(height: 5),
                                            Text(
                                              "Liên quân Mobile- Thắng bại tại kĩ năng",
                                              style: TextStyle(
                                                color: white,
                                                fontSize: 10,
                                                fontFamily: "LD",
                                              ),
                                            ),
                                            SizedBox(height: 5),
                                            Text(
                                              "103.000đ",
                                              style: TextStyle(
                                                color: red,
                                                fontSize: 11,
                                                fontFamily: "LD",
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(height: 5),
                                            Row(
                                              children: [
                                                Text(
                                                  "300.000đ",
                                                  style: TextStyle(
                                                    color: textColor1,
                                                    fontSize: 10,
                                                    fontFamily: "LD",
                                                    decoration: TextDecoration
                                                        .lineThrough,
                                                    decorationThickness: 1.5,
                                                    decorationColor: textColor1,
                                                  ),
                                                ),
                                                Spacer(),
                                                Text(
                                                  "-60%",
                                                  style: TextStyle(
                                                    color: red,
                                                    fontSize: 10,
                                                    fontFamily: "LD",
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                SizedBox(height: 10),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                  child: MasonryGridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: _products.length + (_isLoading ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index < _products.length) {
                        return ItemProduct(product: _products[index]);
                      } else {
                        return const Center(
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DailyCountdown extends StatefulWidget {
  const DailyCountdown({super.key});

  @override
  State<DailyCountdown> createState() => _DailyCountdownState();
}

class _DailyCountdownState extends State<DailyCountdown> {
  late Timer _timer;
  Duration _remaining = Duration.zero;

  @override
  void initState() {
    super.initState();
    _startCountdown();
  }

  void _startCountdown() {
    _updateRemaining();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      _updateRemaining();
    });
  }

  void _updateRemaining() {
    final now = DateTime.now();
    final endOfDay = DateTime(now.year, now.month, now.day, 23, 59, 59);
    setState(() {
      _remaining = endOfDay.difference(now);
      if (_remaining.isNegative) {
        _remaining = const Duration(hours: 24);
      }
    });
  }

  String _format(Duration d) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    return "${twoDigits(d.inHours)} : ${twoDigits(d.inMinutes % 60)} : ${twoDigits(d.inSeconds % 60)}";
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: red,
      ),
      child: Text(
        _format(_remaining),
        style: const TextStyle(
          color: white,
          fontSize: 14,
          fontWeight: FontWeight.bold,
          fontFamily: "LD",
        ),
      ),
    );
  }
}
