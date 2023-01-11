// ignore_for_file: prefer_const_constructors

import 'package:betting_app_1/constants/colors.dart';
import 'package:betting_app_1/screens/auth/otp_verification.dart';
import 'package:betting_app_1/widgets/primary_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class LoginPage extends StatefulWidget {
  static String routeName = '/login';
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.4,
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
                            "assets/pin.png",
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Text(
                  "Login using OTP",
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
                          text: "We will send you an ",
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: textGrey,
                          ),
                        ),
                        TextSpan(
                          text: "One Time Password ",
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: btBlack,
                          ),
                        ),
                        TextSpan(
                          text: "on this number",
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
                  height: 70,
                ),
                Text(
                  "Enter mobile number",
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: textGrey,
                  ),
                ),
                SizedBox(
                  height: 100,
                  width: 250,
                  child: TextField(
                    maxLength: 10,
                    // textAlign: TextAlign.center,
                    controller: phoneController,
                    keyboardType: TextInputType.number,
                    cursorColor: textGrey,
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: btBlack,
                    ),
                    decoration: InputDecoration(
                      counterText: "",
                      contentPadding: EdgeInsets.zero,
                      prefix: Text("+91 - "),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: textGrey,
                          width: 1,
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: textGrey,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                ),
                PrimaryButton(
                  onpressed: () async {
                    if (phoneController.text.length == 10) {
                      EasyLoading.show(
                          status: "Sending OTP",
                          dismissOnTap: false,
                          maskType: EasyLoadingMaskType.black);
                      await FirebaseAuth.instance.verifyPhoneNumber(
                        phoneNumber: "+91${phoneController.text}",
                        verificationCompleted:
                            (PhoneAuthCredential credential) async {},
                        verificationFailed: (FirebaseAuthException e) {},
                        codeSent: (String verificationId, int? resendToken) {
                          EasyLoading.dismiss();
                          context.push(OTPVerificationScreen.routeName, extra: {
                            "verification_id": verificationId,
                            "phone": phoneController.text
                          });
                        },
                        codeAutoRetrievalTimeout: (String verificationId) {},
                      );
                    }
                  },
                  title: "GET OTP",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
