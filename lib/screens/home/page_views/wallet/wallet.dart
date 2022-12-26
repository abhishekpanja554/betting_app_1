// ignore_for_file: prefer_const_constructors, sort_child_properties_last, prefer_const_literals_to_create_immutables

import 'package:betting_app_1/constants/colors.dart';
import 'package:betting_app_1/widgets/header.dart';
import 'package:flutter/material.dart';

class MyWalletPage extends StatefulWidget {
  const MyWalletPage({super.key});

  @override
  State<MyWalletPage> createState() => _MyWalletPageState();
}

class _MyWalletPageState extends State<MyWalletPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            buttonPrimary.withOpacity(0.2),
            Colors.white,
          ],
        ),
      ),
      child: Column(
        children: [
          CommonHeader(
            title: "My Wallet",
          ),
          Container(
            height: 200,
            width: MediaQuery.of(context).size.width - 34,
            decoration: BoxDecoration(
              color: deepPurple,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              children: [
                Column(
                  children: [
                    Text("Balance"),
                  ],
                ),
                CircleAvatar(
                  child: Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                  backgroundColor: buttonPrimary,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
