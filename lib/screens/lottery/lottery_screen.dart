// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_unnecessary_containers

import 'package:betting_app_1/constants/colors.dart';
import 'package:betting_app_1/widgets/header.dart';
import 'package:betting_app_1/widgets/vertical_tabs.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:tab_container/tab_container.dart';

class LotteryScreen extends StatefulWidget {
  static String routeName = '/lottery_page';
  const LotteryScreen({super.key});

  @override
  State<LotteryScreen> createState() => _LotteryScreenState();
}

class _LotteryScreenState extends State<LotteryScreen> {
  int selectedTicket = 0;

  Widget myChoiceChip(int index) {
    var f = NumberFormat("00000", "en_US");
    var formattedNumber = f.format(index);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
      child: ChoiceChip(
        label: Text("50 A $formattedNumber"),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
          side: BorderSide(
            color: Colors.white,
          ),
        ),
        elevation: 5,
        pressElevation: 2,
        selected: index == selectedTicket,
        selectedColor: buttonPrimary,
        labelStyle: TextStyle(
          color: index == selectedTicket ? Colors.white : buttonPrimary,
          fontSize: 13,
          fontWeight: FontWeight.w600,
        ),
        padding: EdgeInsets.all(12),
        labelPadding: EdgeInsets.all(0),
        backgroundColor: Colors.white,
        onSelected: (bool value) {
          if (value) {
            setState(() {
              selectedTicket = index;
            });
          }
        },
      ),
    );
  }

  List<Widget> generateTickets() {
    List<Widget> widgets = [];
    for (var i = 0; i < 20; i++) {
      widgets.add(myChoiceChip(i));
    }
    return widgets;
  }

  List<Widget> generateTabs() {
    List<Widget> widgets = [];
    for (var i = 0; i < getTabs().length; i++) {
      widgets.add(
        Container(
          child: Column(
            children: [
              Text(
                "Select Ticket",
                style: GoogleFonts.montserrat(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Color.fromARGB(255, 255, 145, 0),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Wrap(
                    children: generateTickets(),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
    return widgets;
  }

  List<Tab> getTabs() {
    List<Tab> tabList = [];
    int c = "A".codeUnitAt(0);
    int end = "Z".codeUnitAt(0);
    while (c <= end) {
      tabList.add(
        Tab(
          child: Text(
            String.fromCharCode(c),
            style: GoogleFonts.montserrat(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
      );
      c++;
    }
    return tabList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
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
                title: "Lottery Tickets",
                backButtonAction: () => context.pop(),
              ),
              Expanded(
                child: VerticalTabView(
                  tabsWidth: 90,
                  backgroundColor: Colors.transparent,
                  indicatorColor: Colors.white,
                  selectedTabBackgroundColor: buttonPrimary,
                  tabBackgroundColor: deepPurple,
                  tabs: getTabs(),
                  contents: generateTabs(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
