import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:dms_project/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:dms_project/pages/profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

class Functions extends GetxController{
  static Functions get instance => Get.put(Functions());


  final _auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;
  var verificationId = ''.obs;

  void initFirebase() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  }

  @override
  Future<void> phoneAuth(String phone) async {
    initFirebase();

    final FirebaseAuth auth = FirebaseAuth.instance;

    await _auth.verifyPhoneNumber(
      phoneNumber: phone,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await _auth.signInWithCredential(credential);
        FirebaseFirestore.instance.collection("users").add({"uid": auth.currentUser!.uid, "phone": auth.currentUser!.phoneNumber,
          "email": "Введите свой E-mail", "birthday": "01/01/2000", "gender": "Мужчина"});
      },
      verificationFailed: (FirebaseAuthException e) {
        if (e.code == "invalid-phone-number") {
          Get.snackbar("Error", "The provided phone number is not valid");
        } else {
          Get.snackbar("Error", "Something went wrong. Try again.");
        }
      },
      codeSent: (String verificationId, int? resendToken) {
        this.verificationId.value = verificationId;
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        this.verificationId.value = verificationId;
      },
    );
  }

  Future<bool> verifyOTP(String otp) async {
    var credentials = await _auth.signInWithCredential(PhoneAuthProvider.credential(verificationId: verificationId.value, smsCode: otp));
    return credentials.user != null ? true : false;
  }


}
