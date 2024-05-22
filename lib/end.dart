import 'package:flutter/material.dart';

class EndScreen extends StatefulWidget {
  final int p1Score, p2Score;
  final VoidCallback onReplay;

  const EndScreen({
    super.key,
    required this.p1Score,
    required this.p2Score,
    required this.onReplay,
  });

  @override
  State<EndScreen> createState() => _EndScreenState();
}

class _EndScreenState extends State<EndScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Game Over'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Icon(
                      Icons.star,
                      size: 60,
                      color: widget.p1Score >= widget.p2Score
                          ? Colors.yellow
                          : Colors.transparent,
                    ),
                    Icon(
                      Icons.person,
                      size: widget.p1Score >= widget.p2Score ? 120 : 80,
                      color: Colors.red,
                    ),
                    Text(
                      'P1: ${widget.p1Score}',
                      style: const TextStyle(
                        fontSize: 24,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 20),
                Column(
                  children: [
                    Icon(
                      Icons.star,
                      size: 60,
                      color: widget.p2Score >= widget.p1Score
                          ? Colors.yellow
                          : Colors.transparent,
                    ),
                    Icon(
                      Icons.person,
                      size: widget.p2Score >= widget.p1Score ? 120 : 80,
                      color: Colors.blue,
                    ),
                    Text(
                      'P2: ${widget.p2Score}',
                      style: const TextStyle(
                        fontSize: 24,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                widget.onReplay();
                Navigator.pop(context);
                setState(() {});
              },
              style: ElevatedButton.styleFrom(
                maximumSize: const Size(300, 60), // 調整按鈕的最小尺寸
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.replay,
                    size: 40,
                  ),
                  Text(
                    'Play Again',
                    style: TextStyle(fontSize: 40),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
