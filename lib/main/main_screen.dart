import 'package:bmi_calculator/result/result_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  final _formKey = GlobalKey<FormState>();
  final _heightController = TextEditingController();
  final _weightController = TextEditingController();

  @override
  void initState() {  // 생명주기 메서드 : 시작
    super.initState();

    load();
  }

  @override
  void dispose() {  // 생명주기 메서드 : 종료
    _heightController.dispose();
    _weightController.dispose();
  }

  // 앱을 종료되어도 값이 저장되어 있게
  Future save() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('height', double.parse(_heightController.text));
    await prefs.setDouble('weight', double.parse(_weightController.text));
  }

  // 앱이 닫고 열때 값을 가져오기
  Future load() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final double? height = prefs.getDouble('height');
    final double? weight = prefs.getDouble('weight');

    if (height != null && weight != null) {
      _heightController.text = '$height';
      _weightController.text = '$weight';
      print("키 : $height, 몸무게 : $weight");
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('비만도 계산기'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                TextFormField(
                  controller: _heightController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: '키'
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '키를 입력하세요';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _weightController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: '몸무게'
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "몸무게를 입력하세요.";
                    }
                    return "";
                  },
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        return;
                      }

                      final height =  double.parse(_heightController.text);
                      final weight = double.parse(_weightController.text);

                      print("height ==> $height");
                      print("weight ==> $weight");

                      save();

                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>
                            ResultScreen(height: height, weight: weight,)
                        ),
                      );
                    }, child: const Text('결과')
                )
              ],
            ),
          ),
        )
    );
  }
}
