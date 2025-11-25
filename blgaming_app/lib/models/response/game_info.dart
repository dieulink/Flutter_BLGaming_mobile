// class GameInfo {
//   final String description;
//   final String price;
//   final String genre;
//   final String stock;
//   final String image;

//   GameInfo({
//     required this.description,
//     required this.price,
//     required this.genre,
//     required this.stock,
//     required this.image,
//   });
// }

// /// Parse chuỗi text từ API thành object dễ hiển thị
// GameInfo parseGameInfo(String raw) {
//   // Helper tách chuỗi nhanh
//   String extract(String label, String source) {
//     final start = source.indexOf(label);
//     if (start == -1) return "";
//     final end = source.indexOf("\n", start);
//     final text = source.substring(
//       start + label.length,
//       end == -1 ? source.length : end,
//     );
//     return text.trim();
//   }

//   return GameInfo(
//     description: raw.split("Giá:")[0].trim(),
//     price: extract("Giá:", raw),
//     genre: extract("Thể loại:", raw),
//     stock: extract("Tồn kho:", raw),
//     image: extract("Ảnh bìa:", raw),
//   );
// }
