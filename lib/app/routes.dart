// ignore_for_file: prefer_const_constructors

import 'package:betting_app_1/screens/auth/login.dart';
import 'package:betting_app_1/screens/auth/otp_verification.dart';
import 'package:betting_app_1/screens/auth/registration.dart';
import 'package:betting_app_1/screens/cart/screen.dart';
import 'package:betting_app_1/screens/home/screen.dart';
import 'package:betting_app_1/screens/lottery/lottery_screen.dart';
import 'package:betting_app_1/screens/results/results_screen.dart';
import 'package:betting_app_1/screens/splash/splash_screen.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  initialLocation: SplashScreen.routeName,
  routes: [
    GoRoute(
      path: LoginPage.routeName,
      builder: (context, state) {
        return LoginPage();
      },
    ),
    GoRoute(
      path: OTPVerificationScreen.routeName,
      builder: (context, state) {
        Map<String, dynamic> params = state.extra as Map<String, dynamic>;
        return OTPVerificationScreen(
          verificationId: params["verification_id"],
          phone: params["phone"],
        );
      },
    ),
    GoRoute(
      path: RegistrationPage.routeName,
      builder: (context, state) => RegistrationPage(),
    ),
    GoRoute(
      path: SplashScreen.routeName,
      builder: (context, state) => SplashScreen(),
    ),
    GoRoute(
      path: HomeScreen.routeName,
      builder: (context, state) => HomeScreen(),
    ),
    GoRoute(
      path: LotteryScreen.routeName,
      builder: (context, state){
        return LotteryScreen(typeObject: state.extra! as Map<String,dynamic>);
      },
    ),
    GoRoute(
      path: ResultScreen.routeName,
      builder: (context, state) => ResultScreen(),
    ),
    GoRoute(
      path: CartPage.routeName,
      builder: (context, state) => CartPage(),
    ),
  ],
);
