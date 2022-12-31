// ignore_for_file: prefer_const_constructors, sort_child_properties_last, prefer_const_literals_to_create_immutables

import 'package:betting_app_1/constants/colors.dart';
import 'package:betting_app_1/widgets/header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class MyWalletPage extends StatefulWidget {
  const MyWalletPage({super.key});

  @override
  State<MyWalletPage> createState() => _MyWalletPageState();
}

class _MyWalletPageState extends State<MyWalletPage> {
  Widget walletCard() {
    return Container(
      height: 200,
      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      width: MediaQuery.of(context).size.width - 34,
      decoration: BoxDecoration(
        // color: deepPurple,
        borderRadius: BorderRadius.circular(30),
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            deepPurple,
            buttonPrimary,
          ],
        ),
      ),
      child: Column(
        children: [
          Expanded(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "Your Balance",
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w400,
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "\u{20B9}  678",
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w600,
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(38),
                  child: Container(
                    height: 70,
                    width: 70,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          buttonPrimary,
                          deepPurple,
                        ],
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SvgPicture.asset(
                        width: 50,
                        "assets/rupee-note-icon.svg",
                        semanticsLabel: 'Acme Logo',
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OutlinedButton(
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(EdgeInsets.zero),
                    side: MaterialStateProperty.all(
                      BorderSide(
                        color: Colors.white,
                      ),
                    ),
                    overlayColor: MaterialStateProperty.all(
                        Colors.deepPurpleAccent.shade100),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    fixedSize: MaterialStateProperty.all(
                      Size(100, 40),
                    ),
                  ),
                  onPressed: () {},
                  child: Text(
                    "Withdraw",
                    style: GoogleFonts.montserrat(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
                OutlinedButton(
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(EdgeInsets.zero),
                    side: MaterialStateProperty.all(
                      BorderSide(
                        color: Colors.white,
                      ),
                    ),
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                    overlayColor: MaterialStateProperty.all(
                        Colors.deepPurpleAccent.shade100),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    fixedSize: MaterialStateProperty.all(
                      Size(100, 40),
                    ),
                  ),
                  onPressed: () {},
                  child: Text(
                    "Topup",
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
        ],
      ),
    );
  }

  Widget transactionCard({required String amount, bool insert = true}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      padding: EdgeInsets.symmetric(horizontal: 8),
      height: 50,
      decoration: BoxDecoration(
          color: Colors.deepPurple.shade400,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.white),
          boxShadow: [
            BoxShadow(
              blurRadius: 6,
              color: Colors.black45,
              offset: Offset(2, 2),
            ),
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          RichText(
            text: TextSpan(
              text: '\u{20B9} $amount    ',
              style: GoogleFonts.montserrat(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: insert ? 'TopUp' : "Withdrawl",
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Icon(
                Icons.wallet,
                color: Color.fromARGB(255, 225, 159, 135),
                size: 30,
              ),
              Icon(
                insert ? Icons.arrow_back : Icons.arrow_forward,
                color: insert ? Colors.greenAccent : Colors.redAccent,
                size: 20,
              ),
            ],
          ),
        ],
      ),
    );
  }

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
          walletCard(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Divider(),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: Row(
                      children: [
                        Text(
                          "Past 5 transactions",
                          style: GoogleFonts.montserrat(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: buttonPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        transactionCard(amount: "450"),
                        transactionCard(amount: "1000", insert: false),
                        transactionCard(amount: "1000", insert: false),
                        transactionCard(amount: "1000", insert: false),
                        transactionCard(amount: "1000",),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
