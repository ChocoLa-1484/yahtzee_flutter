import 'package:yahtzee_flutter/game_model.dart';

import 'dice.dart';

class Bonus {
  int value = 0; // 獎勵分數的值，初始為0
  bool isReached = false; // 是否達成獎勵條件，初始為false
  PlayerTurn playerTurn; // 獎勵對應的玩家回合

  Bonus({required this.playerTurn}); // 獎勵的構造函數，初始化玩家回合
}
