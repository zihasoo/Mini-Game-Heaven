import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'number_base_ball.dart';

class LoginScene extends StatefulWidget {
  @override
  State<LoginScene> createState() => _LoginSceneState();

  static String studentID = "";

  static Future<http.Response> startGame() async {
    final url = Uri.https(NumberBaseBall.BaseURL, "dev/start");
    var response = await http.post(url, headers: {
      "X-Auth-Token": studentID,
      "Content-Type": "application/json"
    });
    print(response.body);
    return response;
  }
}

class _LoginSceneState extends State<LoginScene> {
  bool isCorrectID = false;
  bool isReady = false;

  void confirmID(String text) {
    if (text.length == 8 && int.tryParse(text) != null) {
      LoginScene.studentID = text;
      setState(() {
        isCorrectID = true;
      });
    } else {
      LoginScene.studentID = "";
      setState(() {
        isCorrectID = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("로그인"),),
      body: Container(
        margin: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 30),
              child: isReady
                  ? FutureBuilder(
                      future: LoginScene.startGame(),
                      builder: (ctx, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          var response = snapshot.data;
                          if (response?.statusCode == 200) {
                            NumberBaseBall.Auth_Key =
                                json.decode(response!.body)["auth_key"];
                            Future.delayed(const Duration(seconds: 2),
                                () => Navigator.pop(context));
                            return const Text(
                              "로그인 되었습니다",
                              style: TextStyle(
                                  fontSize: 35, fontWeight: FontWeight.bold),
                            );
                          } else {
                            Future.delayed(const Duration(seconds: 3),
                                () => setState(() => isReady = false));
                            Future.delayed(
                                const Duration(milliseconds: 300),
                                () => ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                        content: Text(
                                            "에러 코드: ${response?.statusCode}"))));
                            return Text(
                              "로그인 실패. 인터넷 연결을 확인하세요",
                              style: const TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold),
                            );
                          }
                        } else {
                          return const CircularProgressIndicator(
                            strokeWidth: 8,
                          );
                        }
                      },
                    )
                  : const Text(
                      "학번으로 로그인하세요",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 25),
              child: TextField(
                decoration: const InputDecoration(
                    labelText: "학번 입력", labelStyle: TextStyle(fontSize: 15)),
                style: const TextStyle(
                  fontSize: 30,
                ),
                keyboardType: TextInputType.number,
                onChanged: confirmID,
                onSubmitted:
                    isCorrectID ? (_) => setState(() => isReady = true) : null,
              ),
            ),
            ElevatedButton(
              onPressed:
                  isCorrectID ? () => setState(() => isReady = true) : null,
              style: ElevatedButton.styleFrom(fixedSize: const Size(200, 50)),
              child: const Text(
                '로그인',
                style: TextStyle(fontSize: 30),
              ),
            )
          ],
        ),
      ),
    );
  }
}
