// ignore_for_file: prefer_const_constructors

import 'package:betting_app_1/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CommonHeader extends StatelessWidget {
  final String title;
  final IconData? trailingIcon;
  final Function()? iconAction;
  final Function()? backButtonAction;
  const CommonHeader(
      {required this.title,
      this.trailingIcon,
      this.iconAction,
      this.backButtonAction,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      alignment: Alignment.centerLeft,
      height: 70,
      child: Row(
        children: [
          if (backButtonAction != null) IconButton(
            onPressed: backButtonAction ?? () {},
            icon: Icon(
              Icons.arrow_back_rounded,
              color: buttonPrimary,
            ),
          ),
          Expanded(
            child: Text(
              title,
              style: GoogleFonts.montserrat(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: deepPurple,
              ),
            ),
          ),
          if (trailingIcon != null)
            IconButton(
              onPressed: iconAction ?? () {},
              icon: Icon(
                trailingIcon,
                color: deepPurple,
                size: 20,
              ),
            ),
        ],
      ),
    );
  }
}
