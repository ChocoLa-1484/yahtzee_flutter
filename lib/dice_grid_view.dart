import 'package:flutter/material.dart';
import 'dice.dart';
import 'dice_tile.dart';

class DiceGridView extends StatelessWidget {
  final List<Dice> diceList; // 存儲骰子對象的列表

  const DiceGridView({super.key, required this.diceList}); // 構造函數

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(), // 禁止滾動的物理效果
      shrinkWrap: true, // 根據子元素的大小來調整自身大小
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 5, // 每行的骰子數量
        crossAxisSpacing: 8.0, // 交叉軸方向的間距
        mainAxisSpacing: 8.0, // 主軸方向的間距
      ),
      itemCount: diceList.length, // 列表項目的數量
      padding: const EdgeInsets.all(20), // 四周的內邊距
      itemBuilder: (context, index) {
        return DiceTile(dice: diceList[index]); // 返回骰子元素
      },
    );
  }
}
