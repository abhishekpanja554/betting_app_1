// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_unnecessary_containers

import 'package:betting_app_1/constants/colors.dart';
import 'package:betting_app_1/widgets/header.dart';
import 'package:betting_app_1/widgets/vertical_tabs.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class LotteryScreen extends StatefulWidget {
  static String routeName = '/lottery_page';
  final Map<String, dynamic> typeObject;
  const LotteryScreen({required this.typeObject, super.key});

  @override
  State<LotteryScreen> createState() => _LotteryScreenState();
}

class _LotteryScreenState extends State<LotteryScreen> {
  Map<String, dynamic> selectedTickets = {};
  late Stream<QuerySnapshot<Map<String, dynamic>>> _ticketsStream;

  Map<int, String> tabs = {};

  @override
  void initState() {
    var now = DateTime.now();
    var formatterDate = DateFormat('yyyy-MM-dd');
    String formattedDate = formatterDate.format(now);
    _ticketsStream = FirebaseFirestore.instance
        .collection('tickets')
        // .doc("2023-01-25")
        .doc(formattedDate)
        .collection("type_ids")
        .doc(widget.typeObject["type_id"])
        .collection("each_ticket_set")
        .snapshots();
    super.initState();
  }

  Widget myChoiceChip(
      QueryDocumentSnapshot<Map<String, dynamic>> querySnapshot) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
      child: ChoiceChip(
        label: Text("${querySnapshot["data"]["ticket_number"] ?? "-"}"),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
          side: BorderSide(
            color: Colors.white,
          ),
        ),
        elevation: 5,
        pressElevation: 2,
        selected: selectedTickets.containsKey(querySnapshot["ticket_id"]),
        selectedColor: buttonPrimary,
        labelStyle: TextStyle(
          color: selectedTickets.containsKey(querySnapshot["ticket_id"])
              ? Colors.white
              : buttonPrimary,
          fontSize: 13,
          fontWeight: FontWeight.w600,
        ),
        padding: EdgeInsets.all(12),
        labelPadding: EdgeInsets.all(0),
        backgroundColor: Colors.white,
        onSelected: (bool value) {
          setState(() {
            if (value) {
              selectedTickets[querySnapshot["ticket_id"]] = querySnapshot;
            } else {
              selectedTickets.remove(querySnapshot["ticket_id"]);
            }
          });
        },
      ),
    );
  }

  List<Widget> generateTickets(
      List<QueryDocumentSnapshot<Map<String, dynamic>>> snapshot,
      String ticketType) {
    List<Widget> widgets = [];
    for (var i = 0; i < snapshot.length; i++) {
      if (snapshot[i].data()["data"]["batch"] == ticketType) {
        widgets.add(myChoiceChip(snapshot[i]));
      }
    }
    return widgets;
  }

  List<Widget> generateTabViews(
      List<QueryDocumentSnapshot<Map<String, dynamic>>> snapshot) {
    List<Widget> widgets = [];
    for (var i = 0; i < tabs.length; i++) {
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
                    children: generateTickets(snapshot, tabs[i]!),
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
    int i = 0;
    while (c <= end) {
      tabs[i] = String.fromCharCode(c);
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
      i++;
    }
    return tabList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: selectedTickets.isEmpty
          ? null
          : FloatingActionButton(
              backgroundColor: buttonPrimary,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              onPressed: () async {
              },
              child: Text(
                "Buy",
                style: GoogleFonts.montserrat(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
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
                child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: _ticketsStream,
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                          snapshot) {
                    if (snapshot.connectionState != ConnectionState.active) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: deepPurple,
                        ),
                      );
                    } else {
                      return Column(
                        children: [
                          Expanded(
                            child: VerticalTabView(
                              tabsWidth: 90,
                              backgroundColor: Colors.transparent,
                              indicatorColor: Colors.white,
                              selectedTabBackgroundColor: buttonPrimary,
                              tabBackgroundColor: deepPurple,
                              tabs: getTabs(),
                              contents: generateTabViews(snapshot.data!.docs),
                            ),
                          ),
                        ],
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
