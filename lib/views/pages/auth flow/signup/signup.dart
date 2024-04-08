import 'package:NudgeBuddy/constants/colors.dart';
import 'package:NudgeBuddy/controllers/auth.dart';
import 'package:NudgeBuddy/utils/size_config.dart';
import 'package:NudgeBuddy/views/pages/auth%20flow/activity%20level/activity_level.dart';
import 'package:NudgeBuddy/views/pages/auth%20flow/personal%20info/personal_info.dart';
import 'package:NudgeBuddy/views/pages/auth%20flow/select%20goals/select_goals.dart';
import 'package:NudgeBuddy/views/pages/auth%20flow/submit/submit.dart';
import 'package:NudgeBuddy/views/widgets/custom_button.dart';
import 'package:NudgeBuddy/views/widgets/show_loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'components/indicator.dart';

// RENDER THE SIGNUP PAGE - SHOWS THE WIDGET THAT ALLOWS THE USER TO SIGNUP
// ================================================================================================================
class SignupPage extends GetWidget<AuthController> {
  SignupPage({super.key});
  // final cont = Get.find<AuthController>();
  List<Widget> sections = [
    SelectGoals(),
    SelectActivity(),
    PersonalInfo(),
    const SubmitPage()
  ];
  // THE TITLE OF EACH SECTION
  List<String> sectionsTitle = [
    'Select your goals',
    'Select your activity level',
    'Personal Information',
    ''
  ];
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ShowLoading(
        inAsyncCall: controller.isLoading.value,
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: SizeConfig.heightMultiplier * 15),
                Text(
                  sectionsTitle[controller.currentSection.value],
                  style: TextStyle(
                      fontSize: SizeConfig.textMultiplier * 2.2,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(height: SizeConfig.heightMultiplier * 2),
                SizedBox(
                  height: SizeConfig.heightMultiplier * 60,
                  child: PageView.builder(
                      controller: controller.pageController.value,
                      itemCount: sections.length,
                      onPageChanged: (index) =>
                          controller.currentSection.value = index,
                      itemBuilder: (_, index) => sections[index]),
                ),
                controller.currentSection.value == 3
                    ? const SizedBox()
                    : SignupIndicator(cont: controller),
                SizedBox(height: SizeConfig.heightMultiplier * 4),
                controller.currentSection.value == 2 || controller.currentSection.value==3
                    ? CustomButton(
                        onTap: () => controller.currentSection.value == 2
                            ? controller.pageController.value!.nextPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInBack)
                            : controller.onSignup(),
                        text: controller.currentSection.value == 3
                            ? 'Submit'
                            : 'Next',
                        width: SizeConfig.widthMultiplier * 30)
                    : const SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
