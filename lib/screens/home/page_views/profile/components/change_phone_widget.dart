// ignore_for_file: use_build_context_synchronously

import 'package:betting_app_1/app/app_data.dart';
import 'package:betting_app_1/constants/colors.dart';
import 'package:betting_app_1/screens/home/page_views/profile/controller.dart';
import 'package:betting_app_1/widgets/header.dart';
import 'package:betting_app_1/widgets/primary_button.dart';
import 'package:betting_app_1/widgets/textfield_form.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';

class ChangePhoneWidget extends StatefulWidget {
  const ChangePhoneWidget({super.key});

  @override
  State<ChangePhoneWidget> createState() => _ChangePhoneWidgetState();
}

class _ChangePhoneWidgetState extends State<ChangePhoneWidget> {
  TextEditingController phoneController = TextEditingController();
  bool otpRecieved = false;
  String verificationIdRecieved = "";
  String enteredOtp = "";
  bool processing = false;

  final defaultPinTheme = const PinTheme(
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

  @override
  void initState() {
    focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: const Border(
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
    super.initState();
  }

  inputPage() {
    return [
      Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            alignment: Alignment.center,
            height: 50,
            child: Text(
              "Enter New Number",
              style: GoogleFonts.montserrat(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: deepPurple,
              ),
            ),
          ),
          UnderlineTextfield(
            title: "New Number",
            controller: phoneController,
            keyboardType: TextInputType.phone,
          ),
        ],
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        child: PrimaryButton(
          title: processing ? "PROCESSING" : "SEND OTP",
          onpressed: () async {
            if (phoneController.text != "" &&
                phoneController.text.length >= 10 &&
                processing == false) {
              setState(() {
                processing = true;
              });
              FirebaseAuth auth = FirebaseAuth.instance;
              auth.verifyPhoneNumber(
                phoneNumber: "+91${phoneController.text}",
                timeout: const Duration(minutes: 2),
                verificationCompleted: (credential) async {},
                verificationFailed: (FirebaseAuthException e) {},
                codeSent: (verificationId, [forceResendingToken]) async {
                  setState(() {
                    verificationIdRecieved = verificationId;
                    otpRecieved = true;
                    processing = false;
                  });
                },
                codeAutoRetrievalTimeout: (String verificationId) {},
              );
            }
          },
        ),
      ),
    ];
  }

  otpPage() {
    return [
      Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            alignment: Alignment.center,
            height: 50,
            child: Text(
              "Enter OTP",
              style: GoogleFonts.montserrat(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: deepPurple,
              ),
            ),
          ),
          SizedBox(
            width: 250,
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
        ],
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        child: PrimaryButton(
          title: "SUBMIT",
          onpressed: () async {
            if (enteredOtp != "" &&
                enteredOtp.length == 6 &&
                processing == false) {
              FirebaseAuth auth = FirebaseAuth.instance;
              PhoneAuthCredential credential = PhoneAuthProvider.credential(
                  verificationId: verificationIdRecieved, smsCode: enteredOtp);
              await auth.currentUser!
                  .updatePhoneNumber(credential)
                  .then((value) async {
                await updateData({
                  "phone": phoneController.text,
                }, context);
              });
              SessionManager().userInfo = auth.currentUser;
              context.pop();
            }
          },
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      width: MediaQuery.of(context).size.width * 0.8,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.white,
            buttonPrimary.withOpacity(0.2),
          ],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: otpRecieved ? otpPage() : inputPage(),
      ),
    );
  }
}
