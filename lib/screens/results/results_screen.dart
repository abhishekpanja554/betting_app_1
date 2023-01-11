// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:betting_app_1/constants/colors.dart';
import 'package:betting_app_1/widgets/header.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tab_container/tab_container.dart';

class ResultScreen extends StatefulWidget {
  static const String routeName = '/results_page';
  const ResultScreen({super.key});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  List<Widget> generateTabs() {
    List<Widget> widgets = [];
    // for (var i = 0; i < 2; i++) {
      widgets.add(
        Container(
          height: 285,
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.amberAccent,
          ),
          child: Table(
            children: [
              customTableRow("Morning", "50 A 00007"),
              customTableRow("Evening", "50 A 00007"),
              customTableRow("Night", "50 A 00007"),
            ],
          ),
        ),
      );
      widgets.add(
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              Container(
                padding: EdgeInsets.all(8),
                margin: EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.amberAccent,
                ),
                child: Table(
                  children: [
                    customTableRow("Morning", "50 A 00007"),
                    customTableRow("Evening", "50 A 00007"),
                    customTableRow("Night", "50 A 00007"),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.amberAccent,
                ),
                child: Table(
                  children: [
                    customTableRow("Morning", "50 A 00007"),
                    customTableRow("Evening", "50 A 00007"),
                    customTableRow("Night", "50 A 00007"),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.amberAccent,
                ),
                child: Table(
                  children: [
                    customTableRow("Morning", "50 A 00007"),
                    customTableRow("Evening", "50 A 00007"),
                    customTableRow("Night", "50 A 00007"),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    // }
    return widgets;
  }

  TableRow customTableRow(String title, String value) {
    return TableRow(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
      ),
      children: [
        Container(
          height: 80,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(14),
              topLeft: Radius.circular(14),
            ),
            color: deepPurple
          ),
          alignment: Alignment.center,
          margin: EdgeInsets.symmetric(vertical: 5),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: GoogleFonts.montserrat(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color.fromARGB(255, 199, 179, 255),
            ),
          ),
        ),
        Container(
          height: 80,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(14),
              bottomRight: Radius.circular(14),
            ),
            color: deepPurple
          ),
          margin: EdgeInsets.only(top: 5,bottom: 5,left: 2),
          child: Text(
            value,
            textAlign: TextAlign.center,
            style: GoogleFonts.montserrat(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
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
                title: "Results",
                backButtonAction: () => context.pop(),
              ),
              Expanded(
                child: TabContainer(
                  radius: 20,
                  tabEdge: TabEdge.top,
                  tabCurve: Curves.easeIn,
                  tabExtent: 50,
                  childPadding: EdgeInsets.all(16),
                  transitionBuilder: (child, animation) {
                    animation = CurvedAnimation(
                        curve: Curves.easeIn, parent: animation);
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
                    'Today',
                    'Last Results',
                  ],
                  colors: <Color>[
                    Color(0xff8A7DFD),
                    Color(0xFF6B5DFC),
                  ],
                  children: generateTabs(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
