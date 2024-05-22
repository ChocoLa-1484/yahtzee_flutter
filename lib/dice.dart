import 'dart:math';

class Dice {
  int value = 0; // 骰子的值，初始化為0
  bool isPressed = false; // 標記骰子是否被按下

  // 擲骰子，隨機生成1到6之間的值
  void roll() {
    var rng = Random();
    value = rng.nextInt(6) + 1; // 生成1到6之間的隨機整數作為骰子的值
  }

  // 切換骰子的按下狀態
  void togglePressed() {
    if (value == 0) return; // 如果骰子的值為0，直接返回，不進行操作
    isPressed = !isPressed; // 切換骰子的按下狀態（true到false或false到true）
  }
}
