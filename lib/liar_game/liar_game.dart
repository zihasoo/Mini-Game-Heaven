import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';

class LiarGame extends StatefulWidget {
  int numOfPeople;
  String word;

  LiarGame(this.numOfPeople, this.word);

  @override
  State<LiarGame> createState() => _LiarGameState();
}

class _LiarGameState extends State<LiarGame> {
  int curPerson = 0;
  int flipCount = 0;
  int liar = 0;
  bool complete = false;

  @override
  void initState() {
    super.initState();
    liar = Random(DateTime.now().hashCode).nextInt(widget.numOfPeople-1)+2;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(top: 15),
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.6, right: 15),
              child: OutlinedButton.icon(
                icon: Icon(Icons.refresh),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                label: Text(
                  "다시하기",
                  style: TextStyle(fontSize: 15),
                ),
                style: OutlinedButton.styleFrom(fixedSize: Size(150, 40)),
              ),
            ),
            Container(
                height: MediaQuery.of(context).size.height * 0.75,
                width: MediaQuery.of(context).size.width * 0.6,
                padding: EdgeInsets.symmetric(vertical: 230),
                child: !complete
                    ? FlipCard(
                        onFlipDone: (_) {
                          if (flipCount / 2 == widget.numOfPeople)
                            setState(() => complete = true);
                        },
                        onFlip: () {
                          flipCount++;
                          if (flipCount % 2 == 1) setState(() => curPerson++);
                        },
                        front: Card(
                            elevation: 4,
                            child: Center(
                              child: Text(
                                "내용 보기",
                                style: TextStyle(fontSize: 18),
                              ),
                            )),
                        back: Card(
                          elevation: 4,
                          child: Center(
                              child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: curPerson == liar
                                ? [
                                    Text(
                                      "당신은 ",
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    Text(
                                      "라이어 ",
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.red),
                                    ),
                                    Text(
                                      "입니다.",
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  ]
                                : [
                                    Text("제시어: ",
                                        style: TextStyle(fontSize: 18)),
                                    Text(
                                      widget.word,
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.red),
                                    ),
                                  ],
                          )),
                        ))
                    : Card(
                        elevation: 4,
                        child: Container(
                          height: 30,
                          width: 120,
                          alignment: Alignment.center,
                          child: Text("확인 완료!", style: TextStyle(fontSize: 18)),
                        ),
                      )),
          ],
        ),
      ),
    );
  }
}
