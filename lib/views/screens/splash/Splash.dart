import 'dart:async';
import 'package:flutter/material.dart';
import 'package:zubi/views/screens/auth/login_screen.dart';
import 'package:zubi/views/screens/videos/customized_homepage.dart';
import 'package:zubi/views/screens/videos/custompage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/ZubiLogo.png',
              width: 150,
              height: 150,
            ),
            const SizedBox(height: 20),
            const Text(
              "Welcome to Zubi Lite!!", // Customize your text
              style: TextStyle(
                color: Colors.white,
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
