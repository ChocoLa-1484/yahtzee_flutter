import 'package:flutter/material.dart';
import 'package:yahtzee_flutter/score.dart';

class ScoreTile extends StatelessWidget {
  final Score score; // 分數對象，包含得分值和狀態
  final VoidCallback onTilePressed; // 點擊得分區塊時的回調函數

  const ScoreTile({
    super.key,
    required this.score,
    required this.onTilePressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTilePressed(); // 點擊時調用回調函數
      },
      child: AspectRatio(
        aspectRatio: 1.0,
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: score.isFilled
                ? Colors.grey[700]
                : Colors.grey[300], // 根據填充狀態設置背景顏色
            border: Border.all(
              color: score.isPressed
                  ? Colors.yellow
                  : Colors.black, // 根據按壓狀態設置邊框顏色
              width: 3,
            ),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Text(
            score.value.toString(), // 顯示分數值
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: score.isFilled
                  ? Colors.purple[100]
                  : Colors.purple[400], // 根據填充狀態設置文字顏色
            ),
          ),
        ),
      ),
    );
  }
}
