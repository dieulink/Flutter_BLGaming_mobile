import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:blgaming_app/services/cart_service.dart';
import 'package:blgaming_app/ui_value.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ItemCart extends StatefulWidget {
  final String imgPath;
  final String name;
  final int price;
  final int quantity;
  final int productId;
  final VoidCallback onDeleteSuccess;
  final VoidCallback onIncreaseSuccess;
  final VoidCallback onDecreaseSuccess;

  const ItemCart({
    super.key,
    required this.imgPath,
    required this.name,
    required this.price,
    required this.quantity,
    required this.productId,
    required this.onDeleteSuccess,
    required this.onIncreaseSuccess,
    required this.onDecreaseSuccess,
  });

  @override
  State<ItemCart> createState() => _ItemCartState();
}

class _ItemCartState extends State<ItemCart> {
  Future<void> _deleteItem(String userId) async {
    final statusCode = await CartService.deleteFromCart(
      widget.productId,
      userId,
    );

    if (statusCode == 200) {
      widget.onDeleteSuccess();
      _showSnackBar(context, "Đã xóa sản phẩm khỏi giỏ hàng", success: true);
    } else {
      _showSnackBar(context, "Xóa sản phẩm khỏi giỏ hàng thất bại");
    }
  }

  Future<void> _updateQuantity(int change) async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('userId');

    if (userId == null || userId.isEmpty) {
      _showSnackBar(context, "Vui lòng đăng nhập để thao tác giỏ hàng!");
      return;
    }

    // Nếu đang giảm và số lượng hiện tại = 1 → gọi API xóa
    if (change < 0 && widget.quantity == 1) {
      await _deleteItem(userId);
      return;
    }

    final statusCode = await CartService.updateCartQuantity(
      gameId: widget.productId,
      userId: userId,
      quantity: change,
    );

    if (statusCode == 200) {
      change > 0 ? widget.onIncreaseSuccess() : widget.onDecreaseSuccess();
    } else {
      _showSnackBar(
        context,
        change > 0
            ? "Tăng số lượng sản phẩm thất bại"
            : "Giảm số lượng sản phẩm thất bại",
      );
    }
  }

  void _showSnackBar(BuildContext context, String msg, {bool success = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              success ? Icons.check_circle_outline : Icons.error_outline,
              color: Colors.white,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(msg, style: const TextStyle(fontFamily: "LD")),
            ),
          ],
        ),
        backgroundColor: success ? mainColor3 : Colors.redAccent,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: const EdgeInsets.all(20),
        duration: const Duration(seconds: 1),
        elevation: 8,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(color: mainColor2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.network(
            widget.imgPath,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) =>
                Image.asset("assets/imgs/default.png"),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: getWidth(context) * 0.4,
                      child: Text(
                        widget.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontFamily: "LD",
                          fontWeight: FontWeight.bold,
                          color: white,
                          fontSize: 13,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        final prefs = await SharedPreferences.getInstance();
                        final userId = prefs.getString('userId');
                        if (userId == null) return;
                        await _deleteItem(userId);
                      },
                      child: const Icon(
                        Icons.delete_outline,
                        color: textColor2,
                        size: 32,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${NumberFormat("#,###", "vi_VN").format(widget.price)}",
                      style: const TextStyle(
                        fontFamily: "LD",
                        fontWeight: FontWeight.bold,
                        color: mainColor3,
                        fontSize: 15,
                      ),
                    ),
                    Container(
                      height: 30,
                      decoration: BoxDecoration(
                        color: mainColor3,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: borderColor),
                      ),
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () => _updateQuantity(-1),
                            icon: const Icon(Icons.remove, size: 15),
                            color: white,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: Text(
                              "${widget.quantity}",
                              style: const TextStyle(
                                fontSize: 13,
                                color: white,
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () => _updateQuantity(1),
                            icon: const Icon(Icons.add, size: 15),
                            color: white,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
