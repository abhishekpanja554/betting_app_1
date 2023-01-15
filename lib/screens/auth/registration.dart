// ignore_for_file: prefer_const_constructors
import 'package:betting_app_1/app/app_data.dart';
import 'package:betting_app_1/constants/colors.dart';
import 'package:betting_app_1/screens/home/screen.dart';
import 'package:betting_app_1/widgets/primary_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class RegistrationPage extends StatefulWidget {
  static String routeName = '/registration';
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
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
        validator: validator,
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

  Future<void> addUser() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    await auth.currentUser!.updateEmail(emailController.text);
    await auth.currentUser!.updateDisplayName(nameController.text);
    SessionManager().userInfo = auth.currentUser;
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    await users.doc(SessionManager().userInfo!.uid).set({
      'full_name': nameController.text,
      'email': emailController.text,
      'phone': SessionManager().userInfo!.phoneNumber ?? " - ",
      'uid': SessionManager().userInfo!.uid
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
                    Container(
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
                  ],
                ),
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    Text(
                      "Complete Registration",
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
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || !EmailValidator.validate(value)) {
                          return 'Enter a valid email';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    PrimaryButton(
                      title: "REGISTER",
                      onpressed: () async {
                        if (_formKey.currentState!.validate()) {
                          EasyLoading.show(
                            status: "Registering",
                            dismissOnTap: false,
                            maskType: EasyLoadingMaskType.black,
                          );
                          await addUser().then((value) {
                            EasyLoading.dismiss();
                            context.push(HomeScreen.routeName);
                          });
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
