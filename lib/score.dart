import 'package:yahtzee_flutter/game_model.dart';
import 'dice.dart';

class Score {
  String name; // 得分名稱
  int value = 0; // 得分數值，預設為0
  bool isPressed = false; // 是否被按下，預設為否
  bool isFilled = false; // 是否已填寫，預設為否
  PlayerTurn playerTurn; // 玩家回合

  Score({required this.name, required this.playerTurn}); // 構造函數

  int calculateScore(List<Dice> diceList) {
    // 計算得分
    List<int> diceValues =
        diceList.map((dice) => dice.value).toList(); // 取得所有骰子的值
    Map<int, int> frequency = {}; // 儲存骰子值的頻率
    for (var value in diceValues) {
      frequency[value] = (frequency[value] ?? 0) + 1; // 計算每個骰子值出現的次數
    }
    if (frequency[0] == 5) return 0; // 如果所有骰子值都為0，返回0分

    switch (name) {
      case "Aces":
        return diceValues.where((value) => value == 1).length * 1; // 計算Aces的得分
      case "Twos":
        return diceValues.where((value) => value == 2).length * 2; // 計算Twos的得分
      case "Threes":
        return diceValues.where((value) => value == 3).length *
            3; // 計算Threes的得分
      case "Fours":
        return diceValues.where((value) => value == 4).length * 4; // 計算Fours的得分
      case "Fives":
        return diceValues.where((value) => value == 5).length * 5; // 計算Fives的得分
      case "Sixes":
        return diceValues.where((value) => value == 6).length * 6; // 計算Sixes的得分
      case "Three of a Kind":
        return frequency.entries.any((entry) => entry.value >= 3)
            ? diceValues.reduce((a, b) => a + b)
            : 0; // 計算Three of a Kind的得分
      case "Four of a Kind":
        return frequency.entries.any((entry) => entry.value >= 4)
            ? diceValues.reduce((a, b) => a + b)
            : 0; // 計算Four of a Kind的得分
      case "Full House":
        bool threeOfAKind = frequency.containsValue(3);
        bool pair = frequency.containsValue(2);
        return threeOfAKind && pair ? 25 : 0; // 計算Full House的得分
      case "Small Straight":
        // 檢查是否包含任意小順
        List<List<int>> smallStraights = [
          [1, 2, 3, 4],
          [2, 3, 4, 5],
          [3, 4, 5, 6]
        ];
        for (var straight in smallStraights) {
          if (straight.every((value) => diceValues.contains(value))) {
            return 30; // 小順得分
          }
        }
        return 0; // 如果沒有匹配的小順，返回0分
      case "Large Straight":
        // 檢查是否包含任意大順
        List<List<int>> largeStraights = [
          [1, 2, 3, 4, 5],
          [2, 3, 4, 5, 6]
        ];
        for (var straight in largeStraights) {
          if (straight.every((value) => diceValues.contains(value))) {
            return 40; // 大順得分
          }
        }
        return 0; // 如果沒有匹配的大順，返回0分
      case "Yahtzee":
        return frequency.entries.any((entry) => entry.value == 5)
            ? 50
            : 0; // 計算Yahtzee的得分
      case "Chance":
        return diceValues.reduce((a, b) => a + b); // 計算Chance的得分
      default:
        return 0; // 預設情況返回0分
    }
  }
}
