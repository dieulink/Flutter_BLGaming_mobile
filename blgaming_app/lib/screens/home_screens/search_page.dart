import 'dart:async';
import 'package:blgaming_app/screens/home_screens/widgets/app_bar_cate.dart';
import 'package:blgaming_app/screens/home_screens/widgets/item_product.dart';
import 'package:blgaming_app/screens/home_screens/widgets/search_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:blgaming_app/models/response/product.dart';
import 'package:blgaming_app/models/response/product_category.dart';
import 'package:blgaming_app/services/category_service.dart';
import 'package:blgaming_app/ui_value.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<ProductCategory> _categories = [];
  List<Product> _products = [];

  int selectedIndex = 0;
  int currentPage = 0;
  bool isLoading = false;
  bool hasMore = true;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _initData();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent - 200 &&
          !isLoading &&
          hasMore) {
        _loadProducts();
      }
    });
  }

  Future<void> _initData() async {
    final categories = await CategoryService.fetchCategories();
    if (categories.isNotEmpty) {
      setState(() => _categories = categories);
      await _loadProducts(); // Load danh mục đầu tiên
    }
  }

  Future<void> _loadProducts({bool reset = false}) async {
    if (isLoading) return;

    setState(() => isLoading = true);

    if (reset) {
      _products.clear();
      currentPage = 0;
      hasMore = true;
    }

    final categoryId = _categories[selectedIndex].id;
    final results = await CategoryService.categoryItem(
      size: 15,
      page: currentPage,
      id: categoryId,
    );

    setState(() {
      if (results.isEmpty) {
        hasMore = false;
      } else {
        _products.addAll(results);
        currentPage++;
      }
      isLoading = false;
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_categories.isEmpty) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 29, 29, 29),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: SafeArea(
          child: Container(
            color: mainColor,
            padding: const EdgeInsets.symmetric(horizontal: 10),
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
                        Navigator.pushNamed(context, "cartPage");
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
      body: Row(
        children: [
          Container(
            width: 95,
            child: ListView.builder(
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                final category = _categories[index];
                final bool isSelected = selectedIndex == index;

                return InkWell(
                  onTap: () async {
                    setState(() {
                      selectedIndex = index;
                    });
                    await _loadProducts(reset: true);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 8,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? Colors.transparent
                          : const Color.fromARGB(255, 48, 48, 48),
                      border: Border(
                        left: BorderSide(
                          color: isSelected ? mainColor : Colors.transparent,
                          width: 3,
                        ),
                        bottom: BorderSide(
                          //color: const Color.fromARGB(88, 0, 0, 0),
                          color: const Color.fromARGB(80, 55, 183, 233),
                          width: 1,
                        ),
                      ),
                    ),
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Image.network(
                            category.imageUrl,
                            height: 50,
                            width: 80,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => Image.asset(
                              'assets/imgs/default.png',
                              height: 40,
                              width: 40,
                            ),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          category.name,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                            fontFamily: "LD",
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.normal,
                            color: isSelected ? mainColor : white,
                          ),
                          maxLines: 2,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          Expanded(
            child: Container(
              color: const Color.fromARGB(255, 22, 22, 22),
              margin: EdgeInsets.only(left: 10),
              padding: EdgeInsets.all(10),
              child: _products.isEmpty && !isLoading
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 10),
                          child: Image.asset(
                            "assets/imgs/chatbot5.gif",
                            height: 100,
                          ),
                        ),
                        Text(
                          "Không có sản phẩm nào trong danh mục này",
                          style: TextStyle(
                            fontFamily: "LD",
                            color: white,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    )
                  : AnimatedOpacity(
                      duration: const Duration(milliseconds: 250),
                      opacity: isLoading ? 0.4 : 1,
                      child: MasonryGridView.count(
                        controller: _scrollController,
                        crossAxisCount: 2,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        itemCount: _products.length,
                        itemBuilder: (context, index) {
                          final product = _products[index];
                          return ItemProduct(product: product);
                        },
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
