import 'package:NudgeBuddy/controllers/auth.dart';
import 'package:NudgeBuddy/controllers/meal.dart';
import 'package:NudgeBuddy/controllers/stats.dart';
import 'package:NudgeBuddy/views/pages/auth%20flow/onboarding/onboarding.dart';
import 'package:NudgeBuddy/views/pages/bottom%20nav%20bar/bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// SETUP THE BASIC LAYOUT OF THE APP - THIS IS THE FIRST PAGE THAT IS RENDERED WHEN THE APP IS OPENED - THIS PAGE CHECKS IF THE USER IS LOGGED IN OR NOT AND THEN DECIDES WHICH PAGE TO RENDER
// ================================================================================================================
class Root extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Get.put(AuthController(), permanent: true);
    Get.put(StatsCont());
    Get.put(MealCont());
    return GetX<AuthController>(initState: (_) async {
      Get.put<AuthController>(AuthController());
    }, builder: (_) {
      if (_.userss != null) {
        return CustomBottomNavBar();
      } else {
        return OnBoardingPage();
      }
    });
  }
}
