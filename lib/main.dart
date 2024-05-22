import 'package:flutter/material.dart';
import 'package:yahtzee_flutter/game_model.dart';
import 'package:yahtzee_flutter/game_grid_view.dart';

import 'dice_grid_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Yahtzee Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late GameModel game;

  void replay() {
    setState(() {
      game.reset();
    });
  }

  @override
  void initState() {
    super.initState();
    game = GameModel(onReplay: replay);
    game.reset();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Yahtzee Game"),
      ),
      body: Column(
        children: [
          // 顯示玩家分數的條狀組件
          ScoreBar(
            p1Score: game.p1Score,
            currentTurn: game.currentTurn,
            p2Score: game.p2Score,
          ),
          // 顯示遊戲得分表格的網格視圖
          GameGridView(game: game),
          // 顯示骰子的網格視圖
          DiceGridView(diceList: game.diceList),
          // 包含“ROLL”和“PLAY”按鈕的橫向排列組件
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // ROLL按鈕，點擊後擲骰子
              RollButton(
                onPressed: () {
                  game.rollAll();
                  game.updateScore();
                  setState(() {});
                },
                times: game.remainingTimes,
              ),
              // PLAY按鈕，點擊後提交得分
              PlayButton(
                onPressed: () {
                  game.putScore(context);
                  setState(() {});
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}

class RollButton extends StatelessWidget {
  final VoidCallback onPressed;
  final int times;
  const RollButton({super.key, required this.onPressed, required this.times});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text("ROLL", style: TextStyle(fontSize: 18)), // 按鈕文字大小
          const SizedBox(
            width: 20,
          ),
          Text(times.toString(),
              style: const TextStyle(fontSize: 18)), // 按鈕文字大小
        ],
      ),
    );
  }
}

class PlayButton extends StatelessWidget {
  final VoidCallback onPressed;
  const PlayButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      onPressed: onPressed,
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "PLAY",
            style: TextStyle(fontSize: 18),
          ), // 按鈕文字大小
        ],
      ),
    );
  }
}

class ScoreBar extends StatelessWidget {
  final int p1Score;
  final PlayerTurn currentTurn;
  final int p2Score;

  const ScoreBar({
    super.key,
    required this.p1Score,
    required this.currentTurn,
    required this.p2Score,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // 玩家1分數顯示的容器
        Container(
          width: 150,
          height: 40,
          decoration: BoxDecoration(
            color: currentTurn == PlayerTurn.p1Turn
                ? Colors.grey[300]
                : Colors.grey[700],
            shape: BoxShape.rectangle,
            border: Border.all(
              color: currentTurn == PlayerTurn.p1Turn
                  ? Colors.yellow
                  : Colors.transparent,
              width: 5,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "P1",
                style: TextStyle(
                  fontSize: 24,
                  color: currentTurn == PlayerTurn.p1Turn
                      ? Theme.of(context).colorScheme.inverseSurface
                      : Theme.of(context).colorScheme.onPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                p1Score.toString(),
                style: TextStyle(
                  fontSize: 24,
                  color: currentTurn == PlayerTurn.p1Turn
                      ? Theme.of(context).colorScheme.inverseSurface
                      : Theme.of(context).colorScheme.onPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        // 玩家2分數顯示的容器
        Container(
          width: 150,
          height: 40,
          decoration: BoxDecoration(
            color: currentTurn == PlayerTurn.p2Turn
                ? Colors.grey[300]
                : Colors.grey[700],
            shape: BoxShape.rectangle,
            border: Border.all(
              color: currentTurn == PlayerTurn.p2Turn
                  ? Colors.yellow
                  : Colors.transparent,
              width: 5,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          alignment: Alignment.center,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                p2Score.toString(),
                style: TextStyle(
                  fontSize: 24,
                  color: currentTurn == PlayerTurn.p2Turn
                      ? Theme.of(context).colorScheme.inverseSurface
                      : Theme.of(context).colorScheme.onPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "P2",
                style: TextStyle(
                  fontSize: 24,
                  color: currentTurn == PlayerTurn.p2Turn
                      ? Theme.of(context).colorScheme.inverseSurface
                      : Theme.of(context).colorScheme.onPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
