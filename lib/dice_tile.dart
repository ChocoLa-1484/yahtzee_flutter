import 'package:flutter/material.dart';
import 'dice.dart';

Map<int, String> diceImgList = {
  0: "", // 空白，表示骰子還未擲出
  1: "assets/images/dice1.png", // 骰子值為1的圖片路徑
  2: "assets/images/dice2.png", // 骰子值為2的圖片路徑
  3: "assets/images/dice3.png", // 骰子值為3的圖片路徑
  4: "assets/images/dice4.png", // 骰子值為4的圖片路徑
  5: "assets/images/dice5.png", // 骰子值為5的圖片路徑
  6: "assets/images/dice6.png", // 骰子值為6的圖片路徑
};

class DiceTile extends StatefulWidget {
  final Dice dice; // 骰子對象

  const DiceTile({super.key, required this.dice}); // 構造函數

  @override
  _DiceTileState createState() => _DiceTileState(); // 創建狀態管理器
}

class _DiceTileState extends State<DiceTile> {
  void _handleTap() {
    setState(() {
      widget.dice.togglePressed(); // 切換骰子的按壓狀態
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _handleTap, // 點擊事件處理函數
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: widget.dice.value == 0
              ? Colors.grey
              : Colors.transparent, // 如果骰子值為0，則顯示灰色背景
          border: Border.all(
            color: widget.dice.isPressed
                ? Colors.yellow
                : Colors.transparent, // 如果骰子被按壓，則顯示黃色邊框
            width: 3,
          ),
          borderRadius: BorderRadius.circular(5), // 圓角邊框
        ),
        child: widget.dice.value == 0
            ? Container() // 如果骰子值為0，則不顯示圖片
            : Image.asset(diceImgList[widget.dice.value]!), // 根據骰子的值顯示對應的圖片
      ),
    );
  }
}
