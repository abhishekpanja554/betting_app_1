import 'package:betting_app_1/constants/colors.dart' show btBlack, buttonPrimary, textGrey;
import "package:flutter/material.dart";
import 'package:google_fonts/google_fonts.dart';

class UnderlineTextfield extends StatelessWidget {
  final String title;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool isPassword;
  final String? Function(String?)? validator;
  const UnderlineTextfield(
      {required this.title,
      this.controller,
      this.keyboardType,
      this.isPassword = false,
      this.validator,
      super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
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
        floatingLabelStyle: const TextStyle(
          color: buttonPrimary,
        ),
        contentPadding: EdgeInsets.zero,
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: textGrey,
            width: 1,
          ),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: buttonPrimary,
            width: 2,
          ),
        ),
      ),
    );
  }
}
