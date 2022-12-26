// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:betting_app_1/constants/colors.dart';
import 'package:betting_app_1/screens/home/page_views/profile/components/edit_details_bottomsheet.dart';
import 'package:betting_app_1/widgets/header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:google_fonts/google_fonts.dart';

class MyProfilePage extends StatefulWidget {
  const MyProfilePage({super.key});

  @override
  State<MyProfilePage> createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  Widget profileDataWidget(String title, String value, IconData icon) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      height: 70,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: textGrey),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 50,
            width: 50,
            child: Icon(
              icon,
              color: Colors.blueGrey,
              size: 24,
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.montserrat(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Color.fromARGB(255, 114, 114, 114),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                value,
                style: GoogleFonts.montserrat(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: deepPurple,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  showEditBottomSheet(){
    showModalBottomSheet(
      context: context,
      isDismissible: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(18.0), topRight: Radius.circular(18.0)),
      ),
      backgroundColor: Colors.white,
      isScrollControlled: true,
      builder: (context) {
        return Wrap(
          children: [
            EditProfileBottomSheet(),
          ],
        );
      },
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
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CommonHeader(
              title: "My Profile",
              trailingIcon: FeatherIcons.edit,
              iconAction: () {
                showEditBottomSheet();
              },
            ),
            Container(
              height: 100,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: CircleAvatar(
                backgroundColor: buttonPrimary,
                radius: 50,
                child: Icon(
                  FeatherIcons.user,
                  size: 30,
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Text(
                    "Personal Details",
                    style: GoogleFonts.montserrat(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: buttonPrimary,
                    ),
                  ),
                ],
              ),
            ),
            profileDataWidget("NAME", "Abhishek Panja", FeatherIcons.user),
            profileDataWidget("MOBILE", "9836335391", FeatherIcons.phone),
            SizedBox(
              height: 5,
            ),
            Divider(),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Text(
                    "KYC Details",
                    style: GoogleFonts.montserrat(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: buttonPrimary,
                    ),
                  ),
                ],
              ),
            ),
            profileDataWidget("EMAIL", "abhishek.panja554@gmail.com", FeatherIcons.mail),
            profileDataWidget("PAN", "CWGPP8376O", FeatherIcons.creditCard),
            profileDataWidget("ACCOUNT NUMBER", "9988776655344", Icons.currency_rupee_rounded),
          ],
        ),
      ),
    );
  }
}
