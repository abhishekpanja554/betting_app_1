// ignore_for_file: prefer_const_constructors

import 'package:betting_app_1/constants/colors.dart';
import 'package:betting_app_1/screens/home/screen.dart';
import 'package:betting_app_1/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class RegistrationPage extends StatefulWidget {
  static String routeName = '/registration';
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  Widget textField({
    required String title,
    TextEditingController? controller,
    TextInputType? keyboardType,
    bool isPassword = false,
  }) {
    return SizedBox(
      height: 70,
      width: 300,
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        cursorColor: textGrey,
        style: GoogleFonts.montserrat(
          fontWeight: FontWeight.w600,
          fontSize: 18,
          color: btBlack,
        ),
        obscureText: isPassword,
        decoration: InputDecoration(
          labelText: title,
          labelStyle: GoogleFonts.montserrat(
            fontWeight: FontWeight.w400,
            fontSize: 14,
          ),
          floatingLabelStyle: TextStyle(
            color: buttonPrimary,
          ),
          contentPadding: EdgeInsets.zero,
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: textGrey,
              width: 1,
            ),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: buttonPrimary,
              width: 2,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 200,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Hero(
                      tag: "login_logo",
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        padding: EdgeInsets.only(top: 50),
                        height: 200,
                        width: MediaQuery.of(context).size.width,
                        child: Image.asset(
                          "assets/clipboard.png",
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  Text(
                    "Registration",
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                      color: btBlack,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Register to create your account",
                            style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: textGrey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  textField(title: "Name"),
                  textField(
                      title: "Mobile", keyboardType: TextInputType.number),
                  textField(title: "Password", isPassword: true),
                  textField(title: "Confirm Password", isPassword: true),
                  SizedBox(
                    height: 50,
                  ),
                  PrimaryButton(
                    title: "REGISTER",
                    onpressed: () {
                      context.push(HomeScreen.routeName);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
