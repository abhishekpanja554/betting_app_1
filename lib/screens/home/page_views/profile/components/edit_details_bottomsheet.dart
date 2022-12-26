// ignore_for_file: prefer_const_constructors

import 'package:betting_app_1/constants/colors.dart';
import 'package:betting_app_1/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EditProfileBottomSheet extends StatefulWidget {
  const EditProfileBottomSheet({super.key});

  @override
  State<EditProfileBottomSheet> createState() => _EditProfileBottomSheetState();
}

class _EditProfileBottomSheetState extends State<EditProfileBottomSheet> {
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
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      height: MediaQuery.of(context).size.height * 0.4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 5,
            width: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.blueGrey.withOpacity(0.5),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Edit Your Details",
                  style: GoogleFonts.montserrat(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: buttonPrimary,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          textField(title: "Name"),
          textField(title: "Mobile"),
          SizedBox(
            height: 30,
          ),
          PrimaryButton(
            title: "SAVE CHANGE",
            onpressed: () {},
          ),
        ],
      ),
    );
  }
}
