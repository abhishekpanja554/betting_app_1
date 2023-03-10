// ignore_for_file: prefer_const_constructors

import 'package:betting_app_1/app/app_data.dart';
import 'package:betting_app_1/constants/colors.dart';
import 'package:betting_app_1/screens/auth/registration.dart';
import 'package:betting_app_1/screens/home/screen.dart';
import 'package:betting_app_1/widgets/primary_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';

class OTPVerificationScreen extends StatefulWidget {
  static String routeName = '/otp_verification';
  final String verificationId;
  final String phone;
  const OTPVerificationScreen(
      {required this.verificationId, required this.phone, super.key});

  @override
  State<OTPVerificationScreen> createState() => _OTPVerificationScreenState();
}

class _OTPVerificationScreenState extends State<OTPVerificationScreen> {
  final auth = FirebaseAuth.instance;
  final defaultPinTheme = PinTheme(
    width: 56,
    height: 56,
    textStyle:
        TextStyle(fontSize: 20, color: btBlack, fontWeight: FontWeight.w600),
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border(
        bottom: BorderSide(
          color: textGrey,
          width: 1.0,
        ),
      ),
    ),
  );

  late final PinTheme focusedPinTheme;
  late final PinTheme submittedPinTheme;

  String enteredOtp = "";

  @override
  void initState() {
    focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border(
        bottom: BorderSide(
          color: buttonPrimary,
          width: 1.0,
        ),
      ),
    );

    submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration!.copyWith(
        color: Colors.white,
      ),
    );
    // otpAuth();
    super.initState();
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
                        height: 250,
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
              Column(
                children: [
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
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Enter the OTP sent to ",
                            style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: textGrey,
                            ),
                          ),
                          TextSpan(
                            text: "+91-${widget.phone}",
                            style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              color: btBlack,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  SizedBox(
                    width: 200,
                    child: Pinput(
                      onCompleted: (String value) {
                        enteredOtp = value;
                      },
                      length: 6,
                      defaultPinTheme: defaultPinTheme,
                      focusedPinTheme: focusedPinTheme,
                      submittedPinTheme: submittedPinTheme,
                      validator: (s) {
                        return s!.length == 6 ? null : 'Pin is incorrect';
                      },
                      pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                      showCursor: true,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "Didn't recieve the OTP? ",
                                style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  color: textGrey,
                                ),
                              ),
                            ],
                          ),
                        ),
                        TextButton(
                          style: ButtonStyle(
                            overlayColor: MaterialStateProperty.all(
                              Colors.orangeAccent.withOpacity(0.3),
                            ),
                          ),
                          child: Text(
                            "RESEND OTP",
                            style: GoogleFonts.montserrat(
                              letterSpacing: 1.25,
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              color: orange,
                            ),
                          ),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  PrimaryButton(
                    onpressed: () async {
                      try {
                        EasyLoading.show(
                            maskType: EasyLoadingMaskType.black,
                            status: "Verifying",
                            dismissOnTap: false);
                        PhoneAuthCredential credential =
                            PhoneAuthProvider.credential(
                                verificationId: widget.verificationId,
                                smsCode: enteredOtp);
                        await auth
                            .signInWithCredential(credential)
                            .then((value) {
                          SessionManager().userInfo = value.user;
                          EasyLoading.dismiss();
                          if (value.additionalUserInfo!.isNewUser) {
                            context.go(RegistrationPage.routeName);
                          } else {
                            context.go(HomeScreen.routeName);
                          }
                        });
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.redAccent,
                            content: Text(
                              "Incorrect OTP",
                              style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        );
                      }
                    },
                    title: "VERIFY & PROCEED",
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
