import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

// STORES DATA FOR THE ONBOARDING SCREENS
// ===========================================================================================
class OnboardingCont extends GetxController {
  RxInt currentPage = 0.obs;
  Rxn<PageController> pageCont = Rxn<PageController>();

  @override
  void onInit() {
    super.onInit();
    pageCont.value = PageController(initialPage: 0);
  }

  @override
  void onClose() {
    super.onClose();
    pageCont.value!.dispose();
  }
}
