import 'package:betting_app_1/app/app_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

Future<bool> updateData(Map<String, dynamic> dataMap, BuildContext context) async {
  bool status = true;
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  await users
      .doc(SessionManager().userInfo!.uid)
      .update(dataMap)
      .catchError((error) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        error.toString(),
      ),
    ));
    status = false;
  });
  return status;
}

Future<bool> updateAccountData(Map<String, dynamic> dataMap, BuildContext context) async {
  bool status = true;
  CollectionReference users = FirebaseFirestore.instance.collection('account_details');
  await users
      .doc(SessionManager().userInfo!.uid)
      .update(dataMap)
      .catchError((error) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        error.toString(),
      ),
    ));
    status = false;
  });
  return status;
}