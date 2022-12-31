// ignore_for_file: prefer_const_constructors

import 'package:betting_app_1/constants/colors.dart';
import 'package:betting_app_1/widgets/header.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Widget lotteryBox({required String title, Color backgroundColor = orange}) {
    return Container(
      height: 100,
      alignment: Alignment.centerLeft,
      width: MediaQuery.of(context).size.width/3,
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 10,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              overlayColor: MaterialStateProperty.all(
                Colors.white.withOpacity(0.5),
              ),
              onTap: () {},
              child: Container(
                height: 34,
                width: 34,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(
                  Icons.local_attraction,
                  color: Colors.white,
                ),
              ),
            ),
            Expanded(
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: GoogleFonts.montserrat(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
              ),
            ),
            
          ],
        ),
      ),
    );
  }

  Widget customDivider() {
    return Expanded(
      child: Divider(
        height: 10,
        color: deepPurple, //idth space of divider
        thickness: 1, //thickness of divier line
        indent: 16, //Spacing at the top of divider.
        endIndent: 16,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            CommonHeader(title: "Hi Abhishek!"),
            Wrap(
              alignment: WrapAlignment.start,
              children: [
                lotteryBox(title: "Morning Lottery"),
                lotteryBox(title: "Afternoon Lottery", backgroundColor: orange1),
                lotteryBox(title: "Night Lottery", backgroundColor: deepPurple),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              children: [
                customDivider(),
                Icon(
                  Icons.arrow_drop_down,
                  color: deepPurple,
                ),
                customDivider(),
              ],
            ),
            SizedBox(
              height: 35,
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(buttonPrimary),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                fixedSize: MaterialStateProperty.all(
                  Size(MediaQuery.of(context).size.width - 64, 60),
                ),
              ),
              onPressed: (){},
              child: Text(
                "Live Result",
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            OutlinedButton(
              style: ButtonStyle(
                padding: MaterialStateProperty.all(EdgeInsets.zero),
                side: MaterialStateProperty.all(
                  BorderSide(color: deepPurple),
                ),
                overlayColor: MaterialStateProperty.all(Colors.deepPurpleAccent.shade100),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                fixedSize: MaterialStateProperty.all(
                  Size(MediaQuery.of(context).size.width - 64, 60),
                ),
              ),
              onPressed: () {},
              child: Text(
                "Show Results",
                style: GoogleFonts.montserrat(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: deepPurple,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
