import 'package:betting_app_1/app/routes.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      // routerDelegate: router.routerDelegate,
      // routeInformationParser: router.routeInformationParser,
      debugShowCheckedModeBanner: false,
      title: 'Betting App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
