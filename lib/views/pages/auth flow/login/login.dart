import 'package:NudgeBuddy/constants/colors.dart';
import 'package:NudgeBuddy/controllers/auth.dart';
import 'package:NudgeBuddy/utils/size_config.dart';
import 'package:NudgeBuddy/views/pages/auth%20flow/forgot%20password/forgot_password.dart';
import 'package:NudgeBuddy/views/pages/auth%20flow/signup/signup.dart';
import 'package:NudgeBuddy/views/widgets/custom_backbutton.dart';
import 'package:NudgeBuddy/views/widgets/custom_button.dart';
import 'package:NudgeBuddy/views/widgets/custom_inputfield.dart';
import 'package:NudgeBuddy/views/widgets/show_loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../bottom nav bar/bottom_nav_bar.dart';

// RENDER THE LOGIN PAGE - SHOWS THE WIDGET THAT ALLOWS THE USER TO LOGIN - email and password based-login
class LoginPage extends  GetWidget<AuthController> {
  LoginPage({super.key});
  

  @override
  Widget build(BuildContext context) {
    return Obx(
      ()=> ShowLoading(
        inAsyncCall: controller.isLoading.value,
        child: Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: SizeConfig.widthMultiplier * 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: SizeConfig.heightMultiplier * 10),
                  const CustomBackButton(),
                  SizedBox(height: SizeConfig.heightMultiplier * 12),
                  Text(
                    "Welcome back 👋\nYou've been missed!",
                    style: TextStyle(
                      fontSize: SizeConfig.textMultiplier * 3,
                    ),
                  ),
                  SizedBox(height: SizeConfig.heightMultiplier * 5),
                  CustomInputField(
                      controller: controller.loginEmail,
                      hintText: 'Email',
                      keyboardType: TextInputType.emailAddress,
                      suffixIcon: Icons.email),
                  SizedBox(height: SizeConfig.heightMultiplier * 2),
                  CustomInputField(
                      controller: controller.loginPass,
                      hintText: 'Password',
                      keyboardType: TextInputType.text,
                      suffixIcon: Icons.lock),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                        onPressed: () => Get.to(() => ForgotPasswordPage()),
                        child: const Text('Forgot password?')),
                  ),
                  SizedBox(height: SizeConfig.heightMultiplier * 5),
                  Center(
                    child: CustomButton(
                        onTap: () =>controller.onLogin(),
                        text: 'Login',
                        width: SizeConfig.widthMultiplier * 40),
                  ),
                  SizedBox(height: SizeConfig.heightMultiplier * 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account?",
                        style: TextStyle(
                            fontSize: SizeConfig.textMultiplier * 1.7,
                            color: Colors.grey.shade700),
                      ),
                      TextButton(
                          onPressed: () => Get.to(() => SignupPage()),
                          child: Text(
                            'Sign up',
                            style: TextStyle(
                                fontSize: SizeConfig.textMultiplier * 1.7,
                                color: ColorConstants.primaryColor),
                          ))
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
