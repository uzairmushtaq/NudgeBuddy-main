import 'package:NudgeBuddy/controllers/auth.dart';
import 'package:NudgeBuddy/utils/size_config.dart';
import 'package:NudgeBuddy/views/widgets/custom_backbutton.dart';
import 'package:NudgeBuddy/views/widgets/custom_button.dart';
import 'package:NudgeBuddy/views/widgets/custom_inputfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// RENDER THE FORGOT PASSWORD PAGE - ALLOWS USER TO ENTER EMAIL ADDRESS TO RECEIVE RESET PASSWORD LINK
// ================================================================================================================
class ForgotPasswordPage extends StatelessWidget {
  ForgotPasswordPage({super.key});
  TextEditingController emailCont = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: SizeConfig.widthMultiplier * 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: SizeConfig.heightMultiplier * 7),
            const CustomBackButton(),
            SizedBox(height: SizeConfig.heightMultiplier * 7),
            Text(
              "Let's find your password",
              style: TextStyle(
                fontSize: SizeConfig.textMultiplier * 3,
              ),
            ),
            SizedBox(height: SizeConfig.heightMultiplier * 2),
            CustomInputField(
                controller: emailCont,
                hintText: 'Email',
                keyboardType: TextInputType.emailAddress,
                suffixIcon: Icons.email),
            SizedBox(height: SizeConfig.heightMultiplier * 1),
            Text(
              'Upon providing your email address, you will receive a link to reset your password in your digital mailbox.',
              style: TextStyle(
                  fontSize: SizeConfig.textMultiplier * 1.4,
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(height: SizeConfig.heightMultiplier * 6),
            Center(
                child: CustomButton(
                    onTap: () => Get.find<AuthController>()
                        .onForgetPassword(emailCont.text),
                    text: 'Send Reset Link',
                    width: SizeConfig.widthMultiplier * 50))
          ],
        ),
      ),
    );
  }
}
