import 'package:flutter/material.dart';
import 'liar_game/liar_prepare_scene.dart';
import 'number_base_ball_game/login_scene.dart';
import 'number_base_ball_game/number_base_ball.dart';

class MainScene extends StatefulWidget {
  const MainScene({Key? key}) : super(key: key);

  @override
  State<MainScene> createState() => _MainSceneState();
}

class _MainSceneState extends State<MainScene> {
  bool lierChosen = false;

  @override
  Widget build(BuildContext context) {
    double buttonWidth = MediaQuery.of(context).size.width * 0.5;
    return Scaffold(
      appBar: AppBar(
        title: Text("미니 게임 Heaven!"),
      ),
      body: GestureDetector(
        onTap: () => setState(() {
          lierChosen = false;
        }),
        behavior: HitTestBehavior.opaque,
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.2,
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NumberBaseBall.Auth_Key.isEmpty ? LoginScene() : NumberBaseBall()));
                    },
                    style: ElevatedButton.styleFrom(
                        fixedSize: Size(buttonWidth, 60)),
                    child: const Text(
                      "숫자 야구 게임",
                      style: TextStyle(fontSize: 25),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NumberBaseBall()));
                    },
                    style: ElevatedButton.styleFrom(
                        fixedSize: Size(buttonWidth, 60)),
                    child: const Text(
                      "사과 게임",
                      style: TextStyle(fontSize: 25),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10,bottom: 20),
                child: ElevatedButton(
                    onPressed: () => setState(() {
                          lierChosen = !lierChosen;
                        }),
                    style: ElevatedButton.styleFrom(
                        fixedSize: Size(buttonWidth, 60)),
                    child: const Text(
                      "라이어 게임",
                      style: TextStyle(fontSize: 25),
                    )),
              ),
              if (lierChosen)
                Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                  OutlinedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LiarPrepare()));
                      },
                      style: OutlinedButton.styleFrom(
                          fixedSize: Size(buttonWidth * 0.9, 50)),
                      child: Text(
                        "기기 하나로 하기",
                        style: TextStyle(fontSize: 20),
                      )),
                  OutlinedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LiarPrepare()));
                      },
                      style: OutlinedButton.styleFrom(
                          fixedSize: Size(buttonWidth * 0.9, 50)),
                      child: Text("연결해서 하기", style: TextStyle(fontSize: 20)))
                ])
            ],
          ),
        ),
      ),
    );
  }
}
