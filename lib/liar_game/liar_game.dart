import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';

class LiarGame extends StatefulWidget {
  int numOfPeople;
  String theme;
  String word;

  LiarGame(this.numOfPeople, this.theme, this.word);

  @override
  State<LiarGame> createState() => _LiarGameState();
}

class _LiarGameState extends State<LiarGame> {
  int curPerson = 0;
  int flipCount = 0;
  int liar = 0;

  @override
  void initState() {
    super.initState();
    liar = Random(DateTime.now().hashCode).nextInt(widget.numOfPeople - 1) + 1;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey,
        body: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.12,
              padding: EdgeInsets.only(
                  right: MediaQuery.of(context).size.width * 0.03),
              alignment: AlignmentDirectional.centerEnd,
              child: IconButton(
                icon: Icon(Icons.refresh),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                iconSize: 35,
              ),
            ),
            Text(
              "테마: ${widget.theme}",
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.white70,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              "확인한 인원 수: $curPerson",
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.white70,
                  fontWeight: FontWeight.bold),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.5,
              width: MediaQuery.of(context).size.width * 0.6,
              padding: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).size.height * 0.20),
              child: FlipCard(
                onFlip: () {
                  flipCount++;
                  if (flipCount % 2 == 1) setState(() => curPerson++);
                  if (flipCount ~/ 2 == widget.numOfPeople)
                    Future.delayed(Duration(milliseconds: 500), () {
                      setState(() => Navigator.of(context).pop());
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text("확인 완료!")));
                    });
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
                                style:
                                    TextStyle(fontSize: 18, color: Colors.red),
                              ),
                              Text(
                                "입니다.",
                                style: TextStyle(fontSize: 18),
                              ),
                            ]
                          : [
                              Text("제시어: ", style: TextStyle(fontSize: 18)),
                              Text(
                                widget.word,
                                style:
                                    TextStyle(fontSize: 18, color: Colors.red),
                              ),
                            ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
