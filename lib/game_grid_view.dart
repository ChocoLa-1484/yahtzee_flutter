import 'package:flutter/material.dart';
import 'package:yahtzee_flutter/score_tile.dart';
import 'package:yahtzee_flutter/game_model.dart';
import 'package:yahtzee_flutter/category_tile.dart';

import 'bonus_tile.dart';

class GameGridView extends StatefulWidget {
  final GameModel game;

  const GameGridView({Key? key, required this.game}) : super(key: key);

  @override
  _GameGridViewState createState() => _GameGridViewState();
}

class _GameGridViewState extends State<GameGridView> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 20.0,
        mainAxisSpacing: 8.0,
        childAspectRatio: 3,
      ),
      itemCount: scoresName.length,
      padding: const EdgeInsets.all(20.0),
      itemBuilder: (context, index) {
        if (index == scoresName.length - 2) {
          // 如果是顯示Bonus和Category的行
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CategoryTile(category: scoresName[index]), // 顯示Category
              BonusTile(
                bonus: widget.game.bonuses[0], // 顯示玩家1的Bonus
              ),
              BonusTile(
                bonus: widget.game.bonuses[1], // 顯示玩家2的Bonus
              ),
            ],
          );
        } else {
          // 如果是顯示一般得分項目的行
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CategoryTile(category: scoresName[index]), // 顯示Category
              ScoreTile(
                score: widget.game.scores[index], // 顯示玩家1的得分項目
                onTilePressed: () {
                  widget.game.handleScorePress(index); // 處理玩家1得分項目點擊事件
                  setState(() {}); // 更新UI
                },
              ),
              ScoreTile(
                score: widget.game.scores[index + 14], // 顯示玩家2的得分項目
                onTilePressed: () {
                  widget.game.handleScorePress(index + 14); // 處理玩家2得分項目點擊事件
                  setState(() {}); // 更新UI
                },
              ),
            ],
          );
        }
      },
    );
  }
}
