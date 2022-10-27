import 'main_scene.dart';
import 'package:flutter/material.dart';

//TODO 숫자야구: 성공 화면 만들기, 랭크 화면 만들기(노션 API활용), 관전 모드 만들기, 게임 방법 개선(드래그)
//TODO 라이어 게임: 연결해서 하는거 만들기
//TODO 사과 게임: 노션 API써서 학번으로 자기 기록 남기기?
void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '미니게임 Heaven',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: const MainScene(),
      debugShowCheckedModeBanner: false,
    );
  }
}
