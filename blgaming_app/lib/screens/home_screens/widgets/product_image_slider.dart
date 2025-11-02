import 'package:flutter/material.dart';

class ProductImageSlider extends StatefulWidget {
  final String mainImage;
  final String descImages;

  const ProductImageSlider({
    super.key,
    required this.mainImage,
    required this.descImages,
  });

  @override
  State<ProductImageSlider> createState() => _ProductImageSliderState();
}

class _ProductImageSliderState extends State<ProductImageSlider> {
  late List<String> imageList;
  int selectedIndex = 0;

  String enhanceImageQuality(String url) {
    return url.replaceAll(RegExp(r'cache\/\d+x\d+\/'), '');
  }

  @override
  void initState() {
    super.initState();

    imageList = widget.descImages
        .split(',')
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toList();

    if (widget.mainImage.trim().isNotEmpty &&
        !imageList.contains(widget.mainImage.trim())) {
      imageList.insert(0, widget.mainImage.trim());
    }
  }

  void _changeImage(int offset) {
    if (imageList.isEmpty) return;
    setState(() {
      selectedIndex = (selectedIndex + offset) % imageList.length;
      if (selectedIndex < 0) selectedIndex += imageList.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (imageList.isEmpty) {
      return SizedBox(
        height: 250,
        child: Center(
          child: Icon(
            Icons.image_not_supported_outlined,
            size: 100,
            color: Colors.grey[400],
          ),
        ),
      );
    }

    String selectedImage = enhanceImageQuality(imageList[selectedIndex]);

    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: Image.network(
                selectedImage,
                fit: BoxFit.cover,
                filterQuality: FilterQuality.high,
                errorBuilder: (context, error, stackTrace) => const Icon(
                  Icons.broken_image,
                  size: 60,
                  color: Colors.grey,
                ),
              ),
            ),
            Positioned(
              left: 10,
              child: _arrowButton(Icons.arrow_back_ios, () => _changeImage(-1)),
            ),
            Positioned(
              right: 10,
              child: _arrowButton(
                Icons.arrow_forward_ios,
                () => _changeImage(1),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 60,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: imageList.length,
            itemBuilder: (context, index) {
              final img = enhanceImageQuality(imageList[index]);
              return GestureDetector(
                onTap: () {
                  setState(() => selectedIndex = index);
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: selectedIndex == index
                          ? Colors.blue
                          : Colors.grey.shade300,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Image.network(
                    img,
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.broken_image, size: 30),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _arrowButton(IconData icon, VoidCallback onPressed) {
    return ClipOval(
      child: Material(
        color: Colors.black.withOpacity(0.5),
        child: InkWell(
          onTap: onPressed,
          child: SizedBox(
            width: 36,
            height: 40,
            child: Icon(icon, color: Colors.white, size: 20),
          ),
        ),
      ),
    );
  }
}
