import 'package:flutter/material.dart';
import 'package:yahtzee_flutter/bonus.dart';
import 'package:yahtzee_flutter/dice.dart';
import 'package:yahtzee_flutter/score.dart';

import 'end.dart';

enum PlayerTurn { p1Turn, p2Turn } // 定義玩家回合的枚舉類型

final List<String> scoresName = [
  "Aces",
  "Three of a Kind",
  "Twos",
  "Four of a Kind",
  "Threes",
  "Full House",
  "Fours",
  "Small Straight",
  "Fives",
  "Large Straight",
  "Sixes",
  "Yahtzee",
  "Bonus",
  "Chance",
]; // 定義得分名稱列表

class GameModel {
  List<Dice> diceList = List.generate(5, (_) => Dice()); // 生成5個骰子

  List<Score> scores = List<Score>.generate(
    28,
    (index) => Score(
      playerTurn:
          (index < scoresName.length) ? PlayerTurn.p1Turn : PlayerTurn.p2Turn,
      name: scoresName[index % scoresName.length],
    ),
  ); // 生成28個得分對象，其中每個對象對應玩家的回合和得分名稱

  List<Bonus> bonuses = [
    Bonus(playerTurn: PlayerTurn.p1Turn),
    Bonus(playerTurn: PlayerTurn.p2Turn),
  ]; // 定義兩個Bonus對象，分別對應兩個玩家

  PlayerTurn currentTurn = PlayerTurn.p1Turn; // 設置當前回合為玩家1
  int currentSelectedIndex = -1; // 設置當前選擇的索引為-1
  int remainingTimes = 3; // 設置剩餘次數為3次
  int p1Score = 0, p2Score = 0; // 設置兩個玩家的初始得分為0
  int roundNumber = 0; // 設置當前回合數為0

  final VoidCallback onReplay;
  GameModel({required this.onReplay});

  void reset() {
    diceList = List.generate(5, (_) => Dice()); // 生成5個骰子

    scores = List<Score>.generate(
      28,
      (index) => Score(
        playerTurn:
            (index < scoresName.length) ? PlayerTurn.p1Turn : PlayerTurn.p2Turn,
        name: scoresName[index % scoresName.length],
      ),
    ); // 生成28個得分對象，其中每個對象對應玩家的回合和得分名稱

    bonuses = [
      Bonus(playerTurn: PlayerTurn.p1Turn),
      Bonus(playerTurn: PlayerTurn.p2Turn),
    ]; // 定義兩個Bonus對象，分別對應兩個玩家
    currentTurn = PlayerTurn.p1Turn; // 設置當前回合為玩家1
    currentSelectedIndex = -1; // 設置當前選擇的索引為-1
    remainingTimes = 3; // 設置剩餘次數為3次
    p1Score = 0;
    p2Score = 0; // 設置兩個玩家的初始得分為0
    roundNumber = 0; // 設置當前回合數為0
  }

  void rollAll() {
    if (remainingTimes <= 0) return; // 如果剩餘次數小於等於0，則返回
    remainingTimes--; // 剩餘次數減1
    for (var dice in diceList) {
      if (!dice.isPressed) {
        dice.roll(); // 如果骰子未被按下，則擲骰
      }
    }
  }

  void handleScorePress(int index) {
    if (scores[index].isFilled) return; // 如果該得分已被填寫，則返回
    if (scores[index].playerTurn != currentTurn) return; // 如果該得分不屬於當前玩家，則返回
    if (currentSelectedIndex != -1) {
      scores[currentSelectedIndex].isPressed = false; // 取消之前選擇的得分按下狀態
    }
    currentSelectedIndex = index; // 更新當前選擇的索引
    scores[index].isPressed = true; // 設置當前選擇的得分按下狀態
  }

  void putScore(BuildContext context) {
    if (currentSelectedIndex == -1) return; // 如果當前未選擇任何得分，則返回
    if (currentTurn != scores[currentSelectedIndex].playerTurn)
      return; // 如果當前回合與選擇的得分不匹配，則返回
    if (remainingTimes == 3) return; // 如果剩餘次數為3次，則返回

    scores[currentSelectedIndex].isPressed = false; // 取消當前選擇的得分按下狀態
    scores[currentSelectedIndex].isFilled = true; // 設置當前選擇的得分已填寫

    for (var score in scores) {
      if (!score.isFilled && score.playerTurn == currentTurn) {
        score.value = 0; // 將當前回合所有未填寫的得分值設為0
      }
    }

    for (var dice in diceList) {
      dice.value = 0; // 重置所有骰子的值
      dice.isPressed = false; // 重置所有骰子的按下狀態
    }

    updateBonus(); // 更新Bonus

    if (currentTurn == PlayerTurn.p1Turn) {
      p1Score += scores[currentSelectedIndex].value; // 將得分加到玩家1的總得分
      currentTurn = PlayerTurn.p2Turn; // 切換到玩家2的回合
    } else {
      p2Score += scores[currentSelectedIndex].value; // 將得分加到玩家2的總得分
      currentTurn = PlayerTurn.p1Turn; // 切換到玩家1的回合
    }

    currentSelectedIndex = -1; // 重置當前選擇的索引
    remainingTimes = 3; // 重置剩餘次數為3次
    roundNumber++; // 放了之後總回合數字+1

    if (roundNumber == 26) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EndScreen(
            p1Score: p1Score,
            p2Score: p2Score,
            onReplay: onReplay,
          ),
        ),
      );
    }
  }

  void updateScore() {
    for (var score in scores) {
      if (!score.isFilled && score.playerTurn == currentTurn) {
        score.value = score.calculateScore(diceList); // 更新當前回合所有未填寫的得分
      }
    }
  }

  void updateBonus() {
    if (currentTurn == PlayerTurn.p1Turn) {
      int sum = scores[0].value +
          scores[2].value +
          scores[4].value +
          scores[6].value +
          scores[8].value +
          scores[10].value;
      bonuses[0].value = sum; // 更新玩家1的Bonus值
      if (bonuses[0].value >= 63) {
        bonuses[0].isReached = true; // 如果得分總和大於等於63，設置Bonus達成
        p1Score += 35;
      }
    } else {
      int sum = scores[14].value +
          scores[16].value +
          scores[18].value +
          scores[20].value +
          scores[22].value +
          scores[24].value;
      bonuses[1].value = sum; // 更新玩家2的Bonus值
      if (bonuses[1].value >= 63) {
        bonuses[1].isReached = true; // 如果得分總和大於等於63，設置Bonus達成
        p2Score += 35;
      }
    }
  }
}
