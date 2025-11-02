// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
// import 'package:blgaming_app/models/response/product.dart';
// import 'package:blgaming_app/screens/home_screens/widgets/app_bar_search.dart';
// import 'package:blgaming_app/screens/home_screens/widgets/app_bar_search_cate.dart';
// import 'package:blgaming_app/screens/home_screens/widgets/item_product.dart';
// import 'package:blgaming_app/services/category_service.dart';
// import 'package:blgaming_app/services/product_service.dart';
// import 'package:blgaming_app/ui_value.dart';

// class CategoryItemPage extends StatefulWidget {
//   final int id;
//   final String name;
//   const CategoryItemPage({super.key, required this.id, required this.name});

//   @override
//   State<CategoryItemPage> createState() => _SearchItemPageState();
// }

// class _SearchItemPageState extends State<CategoryItemPage> {
//   List<Product> products = [];
//   Timer? _debounce;
//   int currentPage = 0;
//   bool isLoading = false;
//   bool hasMore = true;
//   String currentKeyword = "";
//   final ScrollController _scrollController = ScrollController();

//   void _onSearchChanged(String keyword) {
//     if (_debounce?.isActive ?? false) _debounce!.cancel();
//     _debounce = Timer(const Duration(milliseconds: 100), () async {
//       currentKeyword = keyword;
//       currentPage = 0;
//       hasMore = true;
//       products.clear();
//       await _loadProducts();
//     });
//   }

//   Future<void> _loadProducts() async {
//     if (isLoading || !hasMore || currentKeyword.isEmpty) return;
//     setState(() => isLoading = true);

//     final results = await CategoryService.searchInCate(
//       keyword: currentKeyword,
//       page: currentPage,
//       id: widget.id,
//     );

//     setState(() {
//       if (results.isEmpty) {
//         hasMore = false;
//       } else {
//         currentPage++;
//         products.addAll(results);
//       }
//       isLoading = false;
//     });
//   }

//   @override
//   void initState() {
//     super.initState();

//     _scrollController.addListener(() {
//       if (_scrollController.position.pixels >=
//               _scrollController.position.maxScrollExtent - 200 &&
//           !isLoading) {
//         _loadProducts();
//       }
//     });
//   }

//   @override
//   void dispose() {
//     _debounce?.cancel();
//     _scrollController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBarSearchCate(
//         onChanged: _onSearchChanged,
//         text: "Bạn muốn tìm gì trong ''${widget.name}'' ? ",
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(10),
//         child: products.isEmpty
//             ? const Center(
//                 child: Text(
//                   "Không có sản phẩm",
//                   style: TextStyle(
//                     color: textColor1,
//                     fontFamily: "LD",
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               )
//             : MasonryGridView.count(
//                 controller: _scrollController,
//                 crossAxisCount: 2,
//                 mainAxisSpacing: 10,
//                 crossAxisSpacing: 10,
//                 itemCount: products.length + (hasMore ? 1 : 0),
//                 itemBuilder: (context, index) {
//                   if (index < products.length) {
//                     return ItemProduct(product: products[index]);
//                   } else {
//                     return const Center(child: CircularProgressIndicator());
//                   }
//                 },
//               ),
//       ),
//     );
//   }
// }
