// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, prefer_const_literals_to_create_immutables

import 'dart:developer';

import 'package:betting_app_1/constants/colors.dart';
import 'package:betting_app_1/screens/home/page_views/home_page/home.dart';
import 'package:betting_app_1/screens/home/page_views/notifications/notification.dart';
import 'package:betting_app_1/screens/home/page_views/profile/profile.dart';
import 'package:betting_app_1/screens/home/page_views/wallet/wallet.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:intl/intl.dart';
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
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () async {
      //     var now = DateTime.now();
      //     var formatterDate = DateFormat('yyyy-MM-dd');
      //     var formatterTime = DateFormat('HH:mm:ss');
      //     String formattedDate = formatterDate.format(now);
      //     String formattedTime = formatterTime.format(now);

      //     var ticketStream = FirebaseFirestore.instance
      //         .collection('tickets')
      //         .doc(formattedDate)
      //         .collection('type_ids')
      //         .doc('4')
      //         .collection('each_ticket_set');

      //     var f = NumberFormat("00000", "en_US");

      //     int c = "A".codeUnitAt(0);
      //     for (var i = 0; i < 26; i++) {
      //       for (var i = 0; i < 20; i++) {
      //         var formattedNumber = f.format(i);
      //         var ref = ticketStream.doc();
      //         await ref.set({
      //           "ticket_id": ref.id,
      //           "is_locked": false,
      //           "transaction_id": "",
      //           "user_id": "",
      //           "data": {
      //             "ticket_number":
      //                 "50 ${String.fromCharCode(c)} $formattedNumber",
      //             "batch": String.fromCharCode(c),
      //             "created_at_date": formattedDate,
      //             "created_at_time": formattedTime,
      //           }
      //         });
      //       }
      //       c++;
      //     }
      //   },
      //   child: Icon(Icons.add),
      // ),
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: PageView(
            controller: pageController,
            allowImplicitScrolling: true,
            onPageChanged: (int index) {
              log(DateTime.now().toString());
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
