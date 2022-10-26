import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'login_scene.dart';

class NumberBaseBall extends StatefulWidget {
  static final BaseURL = "6ntv4mqlz4.execute-api.ap-northeast-2.amazonaws.com";
  static String Auth_Key = "";

  @override
  State<NumberBaseBall> createState() => _NumberBaseBallState();
}

class _NumberBaseBallState extends State<NumberBaseBall> {
  final numberController = TextEditingController();
  final history = [];
  String resultText = "";
  int turnCount = 0;

  final List<Color> DynamicColors = [
    Colors.red,
    Colors.orange,
    Colors.black,
    Colors.green,
    Colors.lightBlueAccent,
    Colors.blue,
    Colors.purpleAccent,
    Colors.purple,
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("숫자 야구"),
          actions: [
            IconButton(onPressed: () {}, icon: Icon(Icons.refresh))
          ],
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    "질문 횟수: $turnCount",
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Text(
                  resultText,
                  style: const TextStyle(
                      fontSize: 30, fontWeight: FontWeight.bold),
                ),
                Row(
                  children: _makeTexts(),
                ),
                TextField(
                  decoration: const InputDecoration(
                    labelText: "8자리 중복 없는 숫자 입력",
                    floatingLabelStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.normal),
                  ),
                  style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  keyboardType: TextInputType.number,
                  controller: numberController,
                  onChanged: (_) => setState(() {}),
                  onSubmitted: (_) => isCorrectNumber()?.call(),
                ),
                ElevatedButton(
                  onPressed: isCorrectNumber(),
                  style: ElevatedButton.styleFrom(fixedSize: const Size(180, 50)),
                  child: const Text("질문하기", style: TextStyle(fontSize: 18),),
                ),
                const SizedBox(
                  height: 80,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void queryBaseBall() async {
    final url = Uri.https(NumberBaseBall.BaseURL, "dev/query");
    var response = await http.put(url,
        headers: {
          "Authorization": NumberBaseBall.Auth_Key,
          "Content-Type": "application/json"
        },
        body: json.encode({"guess_num": numberController.text}));
    print(response.body);
    if (response.statusCode == 200) {
      var result = json.decode(response.body);
      setState(() {
        turnCount = result["turn"];
        resultText =
        "strike: ${result["result"]["strike"]} / ball: ${result["result"]["ball"]}";
      });
    } else {
      setState(() {
        resultText = "요청 실패. 인터넷 연결을 확인하세요. 에러 코드: ${response.statusCode}";
      });
    }
  }

  VoidCallback? isCorrectNumber() {
    if (numberController.text.length == 8) {
      var confirm = List<bool>.generate(10, (index) => false, growable: false);
      for (int i = 0; i < 8; ++i) {
        int? n = int.tryParse(numberController.text[i]);
        if (n == null || confirm[n]) return null;
        confirm[n] = true;
      }
      return queryBaseBall;
    }
    return null;
  }

  List<Widget> _makeTexts() {
    return List<Widget>.generate(15, (index) {
      if (index % 2 == 0) {
        index ~/= 2;
        int? num = numberController.text.length <= index
            ? 0
            : int.tryParse(numberController.text[index]);
        return Text(
          num == null ? "0" : num.toString(),
          style: TextStyle(
              color: DynamicColors[index],
              fontWeight: FontWeight.bold,
              fontSize: 45),
        );
      } else {
        return Container(
          decoration: BoxDecoration(border: Border.all()),
          height: 50,
          width: 2,
          margin: const EdgeInsets.symmetric(horizontal: 10),
        );
      }
    });
  }
}
