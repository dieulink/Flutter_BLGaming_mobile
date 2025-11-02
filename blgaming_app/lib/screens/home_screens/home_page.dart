import 'package:blgaming_app/screens/home_screens/category_page.dart';
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
                    SizedBox(width: 10),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    CartPage(),
                            transitionsBuilder:
                                (
                                  context,
                                  animation,
                                  secondaryAnimation,
                                  child,
                                ) {
                                  return FadeTransition(
                                    opacity: animation,
                                    child: child,
                                  );
                                },
                          ),
                        );
                      },
                      child: Image.asset(
                        "assets/icons/system_icon/24px/Cart.png",
                        height: 50,
                        color: backgroudColor,
                      ),
                    ),
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
                    Container(
                      //color: const Color.fromARGB(255, 28, 56, 142),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            mainColor,
                            //const Color.fromARGB(120, 28, 56, 142),
                            mainColor3,
                          ],
                        ),
                      ),
                      height: 220,
                    ),
                    Column(
                      children: [
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
                                  height: 115,
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
                                          height: 60,
                                          width: 60,
                                          decoration: BoxDecoration(
                                            color: backgroudColor,
                                            border: Border.all(
                                              color: backgroudColor,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              100,
                                            ),
                                          ),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadiusGeometry.circular(
                                                  100,
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
                                          fontWeight: FontWeight.bold,
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
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 2,
                          ),
                          child: Text(
                            "Tựa Game hot ! ! !",
                            style: TextStyle(
                              color: white,
                              fontFamily: "LD",
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 2,
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: _bestSaleProducts
                                        // 🔹 Lọc bỏ các sản phẩm không có ảnh hợp lệ
                                        .where(
                                          (product) =>
                                              product.imageUrl != null &&
                                              product.imageUrl
                                                  .trim()
                                                  .isNotEmpty,
                                        )
                                        .map((product) {
                                          return Container(
                                            margin: const EdgeInsets.symmetric(
                                              horizontal: 10,
                                              vertical: 10,
                                            ),
                                            width: getWidth(context) - 40,
                                            height: 120,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              color: Colors.grey[200],
                                              image: DecorationImage(
                                                image: NetworkImage(
                                                  product.imageUrl,
                                                ),
                                                fit: BoxFit.fitWidth,
                                                onError:
                                                    (exception, stackTrace) {},
                                              ),
                                            ),
                                          );
                                        })
                                        .toList(),
                                  ),
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
