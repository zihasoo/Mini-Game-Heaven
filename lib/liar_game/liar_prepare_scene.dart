import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:mini_game_heaven/liar_game/liar_game.dart';

class LiarPrepare extends StatefulWidget {
  const LiarPrepare({Key? key}) : super(key: key);

  @override
  State<LiarPrepare> createState() => _LiarPrepareState();
}

class _LiarPrepareState extends State<LiarPrepare> {
  Map<String, List<String>> themeToWords = {};
  String selectedTheme = "과일";
  double numOfPeople = 7;
  var controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    readText();
  }

  void readText() async {
    String curTheme = "과일";
    String stream = await rootBundle.loadString("words.txt");
    for (String word in stream.split('\n')) {
      if (word.contains(':')) {
        curTheme = word.substring(0, word.length - 2);
        themeToWords[curTheme] = [];
      } else {
        themeToWords[curTheme]!.add(word);
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("라이어 게임"),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
            Text(
            "인원수 및 테마 설정",
            style: TextStyle(fontSize: 20),
          ),
          Slider(
            value: numOfPeople,
            onChanged: (newValue) => setState(() {
              numOfPeople = newValue;
            }),
            min: 3,
            max: 10,
            divisions: 7,
            label: "${numOfPeople.toInt()} 명",
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.13,
                vertical: MediaQuery.of(context).size.width * 0.08),
            child: TextField(
              decoration: InputDecoration(
                  labelText: "테마",
                  labelStyle: TextStyle(fontSize: 15),
                  isDense: true,
                  border: OutlineInputBorder(borderSide: BorderSide())),
              style: TextStyle(fontSize: 18),
              controller: controller,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 50,
                margin: EdgeInsets.only(right: 20),
                width: MediaQuery.of(context).size.width * 0.35,
                child: DropdownButton(
                  isExpanded: true,
                  value: selectedTheme,
                  underline: Container(
                    height: 2,
                    color: Theme.of(context).primaryColor,
                  ),
                  items: themeToWords.keys
                      .map((thm) => DropdownMenuItem(
                          value: thm,
                          child: Container(
                              child: Text(
                            thm,
                            style: TextStyle(fontSize: 17),
                          ))))
                      .toList(),
                  onChanged: (val) {
                    if (val == null) return;
                    setState(() {
                      selectedTheme = val;
                    });
                  },
                ),
              ),
              OutlinedButton(
                onPressed: () {
                  setState(() {
                    controller.text = themeToWords[selectedTheme]![
                        Random().nextInt(themeToWords[selectedTheme]!.length)];
                  });
                },
                child: Text(
                  "랜덤으로 뽑기",
                  style: TextStyle(fontSize: 15),
                ),
                style: OutlinedButton.styleFrom(fixedSize: Size(140, 40)),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 40),
            child: OutlinedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => LiarGame(numOfPeople.toInt(), controller.text)));
              },
              child: Text(
                "게임 시작!",
                style: TextStyle(fontSize: 20),
              ),
              style: OutlinedButton.styleFrom(fixedSize: Size(170, 50)),
            ),
          ),
        ],
      )),
    );
  }
}
