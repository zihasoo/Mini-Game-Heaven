import 'package:flutter/material.dart';

class LoadScene extends StatelessWidget {
  const LoadScene({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: SafeArea(
          child: Scaffold(
            body: Container(
              child: Image.asset("NL_logo-black-ori.png"),
            ),
          ),
        ),
        onWillPop: () async => false);
  }
}
