// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_unnecessary_containers

import 'package:betting_app_1/constants/colors.dart';
import 'package:betting_app_1/widgets/header.dart';
import 'package:flutter/material.dart';
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
    for (var i = 0; i < 6; i++) {
      widgets.add(
        Container(
          child: Column(
            children: [
              Text(
                "Select Ticket",
                style: GoogleFonts.montserrat(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Color.fromARGB(255, 249, 208, 154),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
            ),
            Expanded(
              child: TabContainer(
                radius: 20,
                tabEdge: TabEdge.left,
                tabCurve: Curves.easeIn,
                tabExtent: 75,
                childPadding: EdgeInsets.all(16),
                transitionBuilder: (child, animation) {
                  animation =
                      CurvedAnimation(curve: Curves.easeIn, parent: animation);
                  return SlideTransition(
                    position: Tween(
                      begin: const Offset(0.2, 0.0),
                      end: const Offset(0.0, 0.0),
                    ).animate(animation),
                    child: FadeTransition(
                      opacity: animation,
                      child: child,
                    ),
                  );
                },
                selectedTextStyle: GoogleFonts.montserrat(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
                unselectedTextStyle: GoogleFonts.montserrat(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: deepPurple,
                ),
                tabs: [
                  '5 Sem',
                  '10 Sem',
                  '25 Sem',
                  '50 Sem',
                  '150 Sem',
                  '200 Sem',
                ],
                colors: <Color>[
                  Color(0xff8A7DFD),
                  Color(0xFF6B5DFC),
                  Color(0xff8A7DFD),
                  Color(0xFF6B5DFC),
                  Color(0xff8A7DFD),
                  Color(0xFF6B5DFC),
                ],
                children: generateTabs(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
