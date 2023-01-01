// ignore_for_file: prefer_const_constructors

import 'package:betting_app_1/screens/auth/login.dart';
import 'package:betting_app_1/screens/auth/otp_verification.dart';
import 'package:betting_app_1/screens/auth/registration.dart';
import 'package:betting_app_1/screens/home/screen.dart';
import 'package:betting_app_1/screens/lottery/lottery_screen.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  initialLocation: LoginPage.routeName,
  routes: [
    GoRoute(
      path: LoginPage.routeName,
      builder: (context, state) => LoginPage(),
    ),
    GoRoute(
      path: OTPVerificationScreen.routeName,
      builder: (context, state) => OTPVerificationScreen(),
    ),
    GoRoute(
      path: RegistrationPage.routeName,
      builder: (context, state) => RegistrationPage(),
    ),
    GoRoute(
      path: HomeScreen.routeName,
      builder: (context, state) => HomeScreen(),
    ),
    GoRoute(
      path: LotteryScreen.routeName,
      builder: (context, state) => LotteryScreen(),
    ),
  ],
);
