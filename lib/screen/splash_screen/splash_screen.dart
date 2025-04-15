import 'package:flutter/material.dart';
import 'dart:async';

import 'package:my_app/screen/login_screen/login_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 10), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Nhóm 09 - Thành viên:\n1. Huỳnh Trung Kiên\n2. Ngô Minh Thuận\n3. Nguyễn Thế Thành',
          style: TextStyle(fontSize: 20),
          textAlign: TextAlign.center
        ),
      ),
    );
  }
}
