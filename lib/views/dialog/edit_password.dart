import 'package:NudgeBuddy/controllers/auth.dart';
import 'package:NudgeBuddy/utils/size_config.dart';
import 'package:NudgeBuddy/views/widgets/custom_button.dart';
import 'package:NudgeBuddy/views/widgets/custom_inputfield.dart';
import 'package:NudgeBuddy/views/widgets/show_loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// RENDERS DIALOG BOX ON SCREEN TO CHANGE THE USER'S PASSWORD WITHIN PROFILE PAGE
// ================================================================================================================
class EditPasswordDialog extends GetWidget<AuthController> {
  EditPasswordDialog({super.key});

  TextEditingController oldPassCont = TextEditingController();
  TextEditingController passCont = TextEditingController();
  TextEditingController confirmPasscont = TextEditingController();

  @override
  Widget build(BuildContext context) { // Builds the dialog box widget to change the user's password | [ The user does not need to enter their old password to change their password ]
    return Material(
        color: Colors.transparent,
        child: Obx(
          () => ShowLoading(
            inAsyncCall: controller.isLoading.value,
            child: Center(
              child: Container(
                height: SizeConfig.heightMultiplier * 32,
                width: SizeConfig.widthMultiplier * 85,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8)),
                padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.widthMultiplier * 5,
                    vertical: SizeConfig.heightMultiplier * 2),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(width: SizeConfig.widthMultiplier * 6),
                        Text(
                          'Change password',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: SizeConfig.textMultiplier * 2),
                        ),
                        InkWell(
                            onTap: () => Get.back(),
                            child: const Icon(Icons.cancel_outlined))
                      ],
                    ),
                    SizedBox(height: SizeConfig.heightMultiplier * 2),
                   
                    CustomInputField(
                        controller: passCont,
                        hintText: 'Your new password',
                        keyboardType: TextInputType.text),
                    SizedBox(height: SizeConfig.heightMultiplier * 2),
                    CustomInputField(
                        controller: confirmPasscont,
                        hintText: 'Confirm new password',
                        keyboardType: TextInputType.text),
                    SizedBox(height: SizeConfig.heightMultiplier * 2),
                    CustomButton(
                        onTap: () => controller.onChangePassword(
                            passCont.text, confirmPasscont.text),
                        text: 'Change Password',
                        width: SizeConfig.widthMultiplier * 90)
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
