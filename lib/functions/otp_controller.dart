import 'package:flutter/material.dart';
import 'package:dms_project/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:dms_project/pages/profile.dart';
import 'package:dms_project/pages/home.dart';
import 'package:get/get.dart';
import 'package:dms_project/functions/function.dart';


class OTPController extends GetxController{
  static OTPController get instance => Get.put(OTPController());

  Future<bool> verifyOTP(String otp) async {
    var isVerifed = await Functions.instance.verifyOTP(otp);
    return Future<bool>.value(isVerifed);
  }

}
