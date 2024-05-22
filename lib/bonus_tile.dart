import 'package:flutter/material.dart';

import 'bonus.dart';

class BonusTile extends StatefulWidget {
  final Bonus bonus;
  const BonusTile({super.key, required this.bonus});

  @override
  State<BonusTile> createState() => _BonusTileState();
}

class _BonusTileState extends State<BonusTile> {
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.0,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: widget.bonus.isReached
              ? Colors.grey[700]
              : Colors.grey[300], // 如果達成獎勵條件，顏色設置為深灰色，否則為淺灰色
          border: Border.all(
            color: widget.bonus.isReached
                ? Colors.yellow
                : Colors.black, // 如果達成獎勵條件，邊框顏色設置為黃色，否則為黑色
            width: 3,
          ),
          borderRadius: BorderRadius.circular(5), // 圓角半徑為5
        ),
        child: Text(
          "${widget.bonus.value}/63", // 顯示目前獎勵分數及達成獎勵的目標分數
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: widget.bonus.isReached
                ? Colors.purple[100]
                : Colors.purple[400], // 如果達成獎勵條件，文字顏色設置為淡紫色，否則為深紫色
          ),
        ),
      ),
    );
  }
}
