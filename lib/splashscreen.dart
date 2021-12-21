import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

class MySlash extends StatefulWidget {
  const MySlash({Key? key}) : super(key: key);

  @override
  _MySlashState createState() => _MySlashState();
}

class _MySlashState extends State<MySlash> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 2,
      navigateAfterSeconds: Home(),
      title: Text(
        'Dog and Cat',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 30,
          color: Color(
            0xFFE99600,
          ),
        ),
      ),
      image: Image.asset('assets/cat.png'),
      backgroundColor: Colors.black12,
      loaderColor: Color(0xFFEEDA28),
    );
  }
}
