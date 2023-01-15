import 'package:betting_app_1/app/app_data.dart';
import 'package:betting_app_1/screens/auth/login.dart';
import 'package:betting_app_1/screens/home/screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  static String routeName = '/splash';
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void isLogin() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) async {
      await Future.delayed(const Duration(seconds: 2), () {
        FirebaseAuth.instance.authStateChanges().listen((User? user) {
          if (user != null) {
            SessionManager().userInfo = FirebaseAuth.instance.currentUser;
            context.go(HomeScreen.routeName);
          } else {
            context.go(LoginPage.routeName);
          }
        });
      });
    });
  }

  @override
  void initState() {
    super.initState();
    isLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(120.0),
          child: Image.asset('assets/lottery_logo.jpg'),
        ),
      ),
    );
  }
}
