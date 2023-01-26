// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:betting_app_1/app/app_data.dart';
import 'package:betting_app_1/constants/colors.dart';
import 'package:betting_app_1/screens/home/page_views/profile/controller.dart';
import 'package:betting_app_1/widgets/primary_button.dart';
import 'package:betting_app_1/widgets/textfield_form.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class EditProfileBottomSheet extends StatefulWidget {
  final bool isPersonal;
  const EditProfileBottomSheet({this.isPersonal = true, super.key});

  @override
  State<EditProfileBottomSheet> createState() => _EditProfileBottomSheetState();
}

class _EditProfileBottomSheetState extends State<EditProfileBottomSheet> {
  final _formKey = GlobalKey<FormState>();

  Map<String, String> dataMap = {};

  String submitBtnTitle = "SAVE CHANGES";

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
      UnderlineTextfield(
        title: "Name",
        keyboardType: TextInputType.name,
        validator: (value) {
          if (value!.isNotEmpty && value.length < 3) {
            return 'Name should be greater than 3 characters';
          }
          return null;
        },
        onSaved: (value) {
          if (value!.isNotEmpty) dataMap["full_name"] = value;
        },
      ),
      UnderlineTextfield(
        title: "Email",
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          if (value!.isNotEmpty && !EmailValidator.validate(value)) {
            return 'Enter a valid email';
          }
          return null;
        },
        onSaved: (value) {
          if (value!.isNotEmpty) dataMap["email"] = value;
        },
      ),
      SizedBox(
        height: 30,
      ),
      PrimaryButton(
        title: submitBtnTitle,
        onpressed: () async {
          if (_formKey.currentState!.validate()) {
            _formKey.currentState!.save();
            setState(() {
              submitBtnTitle = "UPDATING...";
            });

            FirebaseAuth auth = FirebaseAuth.instance;
            if (dataMap["email"] != null) {
              await auth.currentUser!.updateEmail(dataMap["email"]!);
            }
            if (dataMap["full_name"] != null) {
              await auth.currentUser!.updateDisplayName(dataMap["full_name"]);
            }
            SessionManager().userInfo = auth.currentUser;
            bool res = await updateData(dataMap, context);
            context.pop();
          }
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
      UnderlineTextfield(
        title: "PAN",
        validator: (value) {
          if (value!.isNotEmpty && value.length < 3) {
            return 'Name should be greater than 3 characters';
          }
          return null;
        },
        onSaved: (value) {
          if (value!.isNotEmpty) {
            dataMap["pan"] = value;
          }
        },
      ),
      UnderlineTextfield(
        title: "Account Number",
        keyboardType: TextInputType.number,
        validator: (value) {
          if (value!.isNotEmpty && value.length < 9) {
            return 'Enter a valid account number';
          }
          return null;
        },
        onSaved: (value) {
          if (value!.isNotEmpty) {
            dataMap["account_number"] = value;
          }
        },
      ),
      UnderlineTextfield(
        title: "IFSC Code",
        validator: (value) {
          if (value!.isNotEmpty && value.length < 10) {
            return 'Name should be greater than 3 characters';
          }
          return null;
        },
        onSaved: (value) {
          if (value!.isNotEmpty) {
            dataMap["ifsc_code"] = value;
          }
        },
      ),
      SizedBox(
        height: 30,
      ),
      PrimaryButton(
        title: submitBtnTitle,
        onpressed: () async {
          if (_formKey.currentState!.validate() &&
              submitBtnTitle == "SAVE CHANGES") {
            _formKey.currentState!.save();
            setState(() {
              submitBtnTitle = "UPDATING...";
            });
            await updateAccountData(dataMap, context);
            context.pop();
          }
        },
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
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
              Column(
                children: widget.isPersonal
                    ? editPersonalDetails()
                    : editKYCDetails(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
