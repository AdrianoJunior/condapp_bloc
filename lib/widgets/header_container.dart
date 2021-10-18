import 'package:flutter/material.dart';

class HeaderContainer extends StatelessWidget {
  String text = "Login";

  HeaderContainer(this.text, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.4,
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.blue, Colors.lightBlueAccent],
              end: Alignment.bottomCenter,
              begin: Alignment.topCenter),
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(100))),
      child: Stack(
        children: <Widget>[
          Center(
            child: Image.asset(
              'assets/images/logo.png',
              // color: Colors.white,
              width: MediaQuery.of(context).size.width  * 1.25,
            ),
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: Text(
              text,
              style: const TextStyle(color: Colors.white, fontSize: 22),
            ),
          ),
        ],
      ),
    );
  }
}