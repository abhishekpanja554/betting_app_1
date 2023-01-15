// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:betting_app_1/app/app_data.dart';
import 'package:betting_app_1/constants/colors.dart';
import 'package:betting_app_1/screens/home/page_views/profile/controller.dart';
import 'package:betting_app_1/widgets/primary_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';

class EditProfileBottomSheet extends StatefulWidget {
  const EditProfileBottomSheet({super.key});

  @override
  State<EditProfileBottomSheet> createState() => _EditProfileBottomSheetState();
}

class _EditProfileBottomSheetState extends State<EditProfileBottomSheet> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  List<Widget> editPersonalDetails() {
    return [
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
                color: deepPurple,
              ),
            ),
          ],
        ),
      ),
      SizedBox(
        height: 10,
      ),
      textField(
        title: "Name",
        controller: nameController,
        keyboardType: TextInputType.name,
        validator: (value) {
          if (value == null || value.length < 3) {
            return 'Name should be greater than 3 characters';
          }
          return null;
        },
      ),
      textField(
        title: "Email",
        keyboardType: TextInputType.emailAddress,
        controller: emailController,
        validator: (value) {
          if (value == null || !EmailValidator.validate(value)) {
            return 'Enter a valid email';
          }
          return null;
        },
      ),
      textField(
        title: "Mobile",
        controller: phoneController,
        keyboardType: TextInputType.phone,
        validator: (value) {
          if (value == null || value.length < 3) {
            return 'Name should be greater than 3 characters';
          }
          return null;
        },
      ),
      SizedBox(
        height: 30,
      ),
      PrimaryButton(
        title: "SAVE CHANGES",
        onpressed: () async {
          EasyLoading.show(
            status: "Updating",
            dismissOnTap: false,
          );
          FirebaseAuth auth = FirebaseAuth.instance;
          await auth.currentUser!.updateEmail(emailController.text);
          await auth.currentUser!.updateDisplayName(nameController.text);
          SessionManager().userInfo = auth.currentUser;
          updateData({
            if (nameController.text.isNotEmpty)
              'full_name': nameController.text,
            if (emailController.text.isNotEmpty) 'email': emailController.text,
            if (phoneController.text.isNotEmpty) 'phone': phoneController.text,
          }, context);
        },
      ),
    ];
  }

  List<Widget> editKYCDetails() {
    return [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Edit KYC Details",
              style: GoogleFonts.montserrat(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: deepPurple,
              ),
            ),
          ],
        ),
      ),
      SizedBox(
        height: 10,
      ),
      textField(
        title: "PAN",
        controller: nameController,
        keyboardType: TextInputType.name,
        validator: (value) {
          if (value == null || value.length < 3) {
            return 'Name should be greater than 3 characters';
          }
          return null;
        },
      ),
      textField(
        title: "Account Number",
        keyboardType: TextInputType.number,
        controller: emailController,
        validator: (value) {
          if (value == null || value.length < 9) {
            return 'Enter a valid account number';
          }
          return null;
        },
      ),
      textField(
        title: "IFSC Code",
        controller: phoneController,
        keyboardType: TextInputType.phone,
        validator: (value) {
          if (value == null || value.length < 3) {
            return 'Name should be greater than 3 characters';
          }
          return null;
        },
      ),
      SizedBox(
        height: 30,
      ),
      PrimaryButton(
        title: "SAVE CHANGES",
        onpressed: () async {
          EasyLoading.show(
            status: "Updating",
            dismissOnTap: false,
          );
          FirebaseAuth auth = FirebaseAuth.instance;
          await auth.currentUser!.updateEmail(emailController.text);
          await auth.currentUser!.updateDisplayName(nameController.text);
          SessionManager().userInfo = auth.currentUser;
          updateData({
            if (nameController.text.isNotEmpty)
              'full_name': nameController.text,
            if (emailController.text.isNotEmpty) 'email': emailController.text,
            if (phoneController.text.isNotEmpty) 'phone': phoneController.text,
          }, context);
        },
      ),
    ];
  }

  Widget textField({
    required String title,
    TextEditingController? controller,
    TextInputType? keyboardType,
    bool isPassword = false,
    String? Function(String?)? validator,
  }) {
    return SizedBox(
      height: 70,
      width: 300,
      child: TextFormField(
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

  Future<void> updateUserDetails() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    await auth.currentUser!.updateEmail(emailController.text);
    await auth.currentUser!.updateDisplayName(nameController.text);
    SessionManager().userInfo = auth.currentUser;
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    await users.doc(SessionManager().userInfo!.uid).set({
      'full_name': nameController.text,
      'email': emailController.text,
      'phone': "",
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          error.toString(),
        ),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      height: MediaQuery.of(context).size.height * 0.5,
      child: Form(
        key: _formKey,
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
          ],
        ),
      ),
    );
  }
}
