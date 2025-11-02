import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:blgaming_app/models/response/product.dart';
import 'package:blgaming_app/screens/home_screens/widgets/app_bar_cate.dart';
import 'package:blgaming_app/screens/home_screens/widgets/app_bar_search.dart';
import 'package:blgaming_app/screens/home_screens/widgets/app_bar_search_cate.dart';
import 'package:blgaming_app/screens/home_screens/widgets/item_product.dart';
import 'package:blgaming_app/services/category_service.dart';
import 'package:blgaming_app/services/product_service.dart';

class CategoryPage extends StatefulWidget {
  final int id;
  final String name;
  const CategoryPage({super.key, required this.id, required this.name});

  @override
  State<CategoryPage> createState() => _ItemPageState();
}

class _ItemPageState extends State<CategoryPage> {
  List<Product> products = [];
  int currentPage = 0;
  bool isLoading = false;
  bool hasMore = true;
  String currentKeyword = "";
  final ScrollController _scrollController = ScrollController();

  Future<void> _loadProducts() async {
    if (isLoading || !hasMore) return;
    setState(() => isLoading = true);

    final results = await CategoryService.categoryItem(
      size: 15,
      page: currentPage,
      id: widget.id,
    );

    setState(() {
      if (results.isEmpty) {
        hasMore = false;
      } else {
        currentPage++;
        products.addAll(results);
      }
      isLoading = false;
    });
  }

  @override
  void initState() {
    _loadProducts();
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent - 200 &&
          !isLoading) {
        _loadProducts();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCate(
        hintText: "Bạn muốn tìm gì trong ''${widget.name}'' ?",
        cateId: widget.id,
        cateName: widget.name,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: products.isEmpty
            ? const Center(child: Text("Không tìm thấy sản phẩm"))
            : MasonryGridView.count(
                controller: _scrollController,
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                itemCount: products.length,
                itemBuilder: (context, index) {
                  if (index < products.length) {
                    return ItemProduct(product: products[index]);
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
      ),
    );
  }
}
