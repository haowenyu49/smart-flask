import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'authentication.dart';

String collection = 'AthleteFuel';

Future<Map<String, dynamic>?> getUserInfo() async {
  Map<String, dynamic>? data;
  String uid = AuthenticationHelper().uid;

  try {
    await FirebaseFirestore.instance
        .collection(collection)
        .doc(uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        data = documentSnapshot.data() as Map<String, dynamic>?;
        debugPrint('Document data: ${documentSnapshot.data()}');
      } else {
        debugPrint('Document does not exist on the database');
      }
    });
  } catch (e) {
    debugPrint('$e');
  }
  return data;
}

Future<bool> editUserInfo(Map<String, dynamic> data) async {
  String uid = AuthenticationHelper().uid;

  FirebaseFirestore.instance
      .collection(collection)
      .doc(uid)
      .set(data, SetOptions(merge: true));
  return true;
}

Future<Map<String, dynamic>> getCaloriesConsumptionLog() async {
  Map<String, dynamic> log = {};
  await getUserInfo().then((data) {
    try {
      Map<String, dynamic>? tempMap = data!['caloriesConsumptionLog'];
      if (tempMap != null) {
        log = tempMap;
      }
    } catch (_) {
      print('The date does not have event');
    }
  });
  return log;
}

Future<bool> addCaloriesConsumptionLog(Map<String, dynamic> data) async {
  String uid = AuthenticationHelper().uid;
  Map<String, dynamic> caloriesConsumptionLog =
  await getCaloriesConsumptionLog();
  caloriesConsumptionLog.addAll(data);
  FirebaseFirestore.instance.collection(collection).doc(uid).set(
      {'caloriesConsumptionLog': caloriesConsumptionLog},
      SetOptions(merge: true));
  return true;
}