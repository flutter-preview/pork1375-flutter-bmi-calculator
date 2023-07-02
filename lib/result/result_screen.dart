import 'package:flutter/material.dart';

// StatelessWidget 보통 변경이 없는화면
class ResultScreen extends StatelessWidget {
  final double height;
  final double weight;

  const ResultScreen({Key? key, required this.height, required this.weight})
      : super(key: key);

  String _calcBmi(double bmi) {
    String result = '저체중';
    if (bmi >= 35) {
      result = '고도 비만';
    } else if (bmi >= 30) {
      result = '2단계 비만';
    } else if (bmi >= 25) {
      result = '1단계 비만';
    } else if (bmi > 23) {
      result = '과체중';
    } else if (bmi >= 18.5) {
      result = '정상';
    }
    return result;
  }

  Widget _buildIcon(double bmi) {
    Icon icon = const Icon(
      Icons.sentiment_dissatisfied,
      color: Colors.green,
      size: 100,
    );
    if (bmi > 23) {
      icon = const Icon(
        Icons.sentiment_very_dissatisfied,
        color: Colors.green,
        size: 100,
      );
    } else if (bmi >= 18.5) {
      icon = const Icon(
        Icons.sentiment_satisfied,
        color: Colors.green,
        size: 100,
      );
    }

    return icon;
  }

  @override
  Widget build(BuildContext context) {
    // 키를 미터로 변환
    double heightInMeter = height / 100.0;
    final double bmi = weight / (heightInMeter) * (heightInMeter);
    print("bmi ==> $bmi");
    String result = '정상';

    return Scaffold(
      appBar: AppBar(
        title: const Text('결과'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _calcBmi(bmi), // 변수가 들어오면 const 쓸 수 없다.
              style: const TextStyle(fontSize: 36),
            ),
            _buildIcon(bmi),
          ],
        ),
      ),
    );
  }
}
