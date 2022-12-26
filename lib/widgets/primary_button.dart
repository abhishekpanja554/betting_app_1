import 'package:betting_app_1/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PrimaryButton extends StatelessWidget {
  final Color? buttonColor;
  final String title;
  final Function() onpressed;
  final double borderRadius;
  const PrimaryButton({
    this.buttonColor,
    required this.title,
    required this.onpressed,
    this.borderRadius = 30,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor:
            MaterialStateProperty.all(buttonColor ?? buttonPrimary),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        fixedSize: MaterialStateProperty.all(
          Size(MediaQuery.of(context).size.width - 64, 60),
        ),
      ),
      onPressed: onpressed,
      child: Text(
        title,
        style: GoogleFonts.montserrat(
          fontWeight: FontWeight.w600,
          fontSize: 18,
          color: Colors.white,
        ),
      ),
    );
  }
}
