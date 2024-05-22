import 'package:flutter/material.dart';

// 分類圖片的映射表，對應每個分類名稱到對應的圖片路徑
Map<String, String> categoryImgList = {
  "Aces": "assets/images/dice1.png",
  "Twos": "assets/images/dice2.png",
  "Threes": "assets/images/dice3.png",
  "Fours": "assets/images/dice4.png",
  "Fives": "assets/images/dice5.png",
  "Sixes": "assets/images/dice6.png",
  "Three of a Kind": "assets/images/dice_three.png",
  "Four of a Kind": "assets/images/dice_four.png",
  "Full House": "assets/images/full.png",
  "Small Straight": "assets/images/small.png",
  "Large Straight": "assets/images/large.png",
  "Yahtzee": "assets/images/yahtzee.png",
  "Bonus": "assets/images/bonus.png",
  "Chance": "assets/images/chance.png",
};

class CategoryTile extends StatelessWidget {
  final String category; // 分類名稱

  const CategoryTile({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.0, // 寬高比為1:1，使得圖片維持正方形
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black, // 邊框顏色為黑色
            width: 3, // 邊框寬度為3像素
          ),
          borderRadius: BorderRadius.circular(5), // 圓角半徑為5
        ),
        child: Image.asset(categoryImgList[category]!), // 根據分類名稱從映射表中取得對應的圖片
      ),
    );
  }
}
