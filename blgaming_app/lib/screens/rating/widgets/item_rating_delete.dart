import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:blgaming_app/ui_value.dart';

class ItemRatingDelete extends StatelessWidget {
  final String name;
  final double score;
  final String time;
  final String comment;
  final int ratingId;
  final VoidCallback onDelete;

  const ItemRatingDelete({
    super.key,
    required this.name,
    required this.score,
    required this.time,
    required this.comment,
    required this.ratingId,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 5),
          Container(height: 1, color: backgroudColor),
          SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.asset("assets/imgs/logo_blue.png", height: 20),
                  ),
                  SizedBox(width: 10),
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 13,
                      fontFamily: "LD",
                      fontWeight: FontWeight.bold,
                      color: textColor3,
                    ),
                  ),
                ],
              ),
              Text(
                time,
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: "LD",
                  color: textColor3,
                ),
              ),
            ],
          ),
          SizedBox(height: 5),
          RatingBarIndicator(
            rating: score,
            itemBuilder: (context, index) =>
                Icon(Icons.star, color: Colors.amber),
            itemCount: 5,
            itemSize: 17.0,
            direction: Axis.horizontal,
          ),
          SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  comment,
                  style: TextStyle(
                    fontSize: 12,
                    fontFamily: "LD",
                    color: textColor2,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
              InkWell(
                onTap: onDelete,
                child: Container(
                  padding: EdgeInsets.all(20),
                  child: Icon(
                    Icons.delete_outline_outlined,
                    color: red,
                    size: 30,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 15),
        ],
      ),
    );
  }
}
