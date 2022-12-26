// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, prefer_const_literals_to_create_immutables

import 'package:betting_app_1/constants/colors.dart';
import 'package:betting_app_1/screens/home/page_views/home_page/home.dart';
import 'package:betting_app_1/screens/home/page_views/notifications/notification.dart';
import 'package:betting_app_1/screens/home/page_views/profile/profile.dart';
import 'package:betting_app_1/screens/home/page_views/wallet/wallet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = '/home';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  PageController pageController = PageController(
    initialPage: 0,
  );
  List<Widget> pages = [
    MyHomePage(),
    MyProfilePage(),
    MyWalletPage(),
    MyNotificationPage(),
  ];

  @override
  void initState() {
    // pageController = PageController(initialPage: 0,);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: PageView(
            controller: pageController,
            allowImplicitScrolling: true,
            onPageChanged: (int index) {
              setState(() {
                _currentIndex = index;
              });
            },
            children: [
              MyHomePage(),
              MyProfilePage(),
              MyWalletPage(),
              MyNotificationPage(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 70,
        padding: EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          boxShadow: [
            BoxShadow(
              blurRadius: 15,
              color: Colors.black38,
              offset: Offset(0, 0),
            ),
          ],
        ),
        child: SalomonBottomBar(
          currentIndex: _currentIndex,
          onTap: (int index) {
            pageController.animateToPage(
              index,
              curve: Curves.easeIn,
              duration: Duration(
                milliseconds: 200,
              ),
            );
          },
          items: [
            SalomonBottomBarItem(
              icon: Icon(FeatherIcons.home),
              title: Text("Home"),
              selectedColor: buttonPrimary,
              unselectedColor: textGrey,
            ),
            SalomonBottomBarItem(
              icon: Icon(FeatherIcons.user),
              title: Text("Profile"),
              selectedColor: buttonPrimary,
              unselectedColor: textGrey,
            ),
            SalomonBottomBarItem(
              icon: Icon(Icons.currency_rupee_rounded),
              title: Text("Wallet"),
              selectedColor: buttonPrimary,
              unselectedColor: textGrey,
            ),
            SalomonBottomBarItem(
              icon: Icon(FeatherIcons.bell),
              title: Text("Notification"),
              selectedColor: buttonPrimary,
              unselectedColor: textGrey,
            ),
          ],
        ),
      ),
    );
  }
}
