import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


// CUSTOM SNACKBAR CLASS - USED TO SHOW CUSTOM NOTIFICATIONS TO THE USER THROUGHOUT THE APP THAT DISAPPEAR AFTER A CERTAIN TIME PERIOD OR WHEN THE USER TAPS ON THE NOTIFICATION ITSELF.
//==============================================================================================================================
class CustomSnackbar {
  static showCustomSnackbar(bool isError,String text) {
    return AnimatedSnackBar.material(
      text,
      
      type:isError? AnimatedSnackBarType.error:AnimatedSnackBarType.success
    ).show(Get.overlayContext!);
  }
}
