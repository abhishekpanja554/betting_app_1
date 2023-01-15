import 'package:betting_app_1/app/app_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

Future<void> updateData(Map<String, dynamic> dataMap, BuildContext context) async {
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  await users
      .doc(SessionManager().userInfo!.uid)
      .set(dataMap)
      .catchError((error) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        error.toString(),
      ),
    ));
  });
}
