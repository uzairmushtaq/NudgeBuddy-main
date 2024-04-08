import 'package:NudgeBuddy/constants/colors.dart';
import 'package:NudgeBuddy/controllers/onboarding.dart';
import 'package:NudgeBuddy/models/onboarding.dart';
import 'package:NudgeBuddy/utils/size_config.dart';
import 'package:NudgeBuddy/views/pages/auth%20flow/login/login.dart';
import 'package:NudgeBuddy/views/pages/auth%20flow/signup/signup.dart';
import 'package:NudgeBuddy/views/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import 'components/indicator.dart';

// RENDERS INITIAL ONBOARDING PAGE
// ================================================================================================================
class OnBoardingPage extends StatelessWidget {
  OnBoardingPage({super.key});
  final cont = Get.put(OnboardingCont());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => Column(
          children: [
            SizedBox(height: SizeConfig.heightMultiplier * 20),
            //ONBOARDING IMAGE
            SizedBox(
              height: SizeConfig.heightMultiplier * 35,
              child: PageView.builder(
                  itemCount: 2,
                  onPageChanged: (val) => cont.currentPage.value = val,
                  itemBuilder: (_, index) => Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: SizeConfig.widthMultiplier * 5),
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                    OnboardingModel.data[index].image))),
                      )),
            ),
            SizedBox(height: SizeConfig.heightMultiplier * 5),
            //TITLE
            Text(
              OnboardingModel.data[cont.currentPage.value].title,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: SizeConfig.textMultiplier * 2.2,
              ),
            ),
            SizedBox(height: SizeConfig.heightMultiplier * 1),
            //SUBTITLE
            SizedBox(
              width: SizeConfig.widthMultiplier * 80,
              child: Text(
                OnboardingModel.data[cont.currentPage.value].subtitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: SizeConfig.textMultiplier * 1.8,
                    color: Colors.grey),
              ),
            ),
            SizedBox(height: SizeConfig.heightMultiplier * 3),
            //INIDICATOR
            PageIndicator(cont: cont),
            SizedBox(height: SizeConfig.heightMultiplier * 5),
            //BUTTON
            CustomButton(
                onTap: () =>Get.to(()=> SignupPage()),
                text: 'Get Started',
                width: SizeConfig.widthMultiplier * 70),
            SizedBox(height: SizeConfig.heightMultiplier * 5),

            //TEXT IF ACCOUNT HAVE
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Already have an account?',
                  style: TextStyle(
                      fontSize: SizeConfig.textMultiplier * 1.7,
                      color: Colors.grey.shade700),
                ),
                TextButton(
                    onPressed: ()=>Get.to(()=> LoginPage()),
                    child: Text(
                      'Log In',
                      style: TextStyle(
                          fontSize: SizeConfig.textMultiplier * 1.7,
                          color: ColorConstants.primaryColor),
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
