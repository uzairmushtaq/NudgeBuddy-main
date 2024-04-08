import 'package:NudgeBuddy/controllers/auth.dart';
import 'package:NudgeBuddy/utils/size_config.dart';
import 'package:NudgeBuddy/views/pages/auth%20flow/personal%20info/components/gender_selection.dart';
import 'package:NudgeBuddy/views/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/show_loading.dart';

// RENDERS OPTION TO EDIT GENDER IF INCORRECT - FROM PERSONAL INFO PAGE
// ================================================================================================================
class EditGender extends StatelessWidget {
  const EditGender({super.key});

  @override
  Widget build(BuildContext context) { // Builds the widget to edit said information
    return Material(
        color: Colors.transparent,
        child: Obx(
          ()=> ShowLoading(
            inAsyncCall: Get.find<AuthController>().isLoading.value,
            child: Center(
                child: Container(
              height: SizeConfig.heightMultiplier * 25,
              width: SizeConfig.widthMultiplier * 85,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(8)),
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
                          'Select Gender',
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
                  GenderSelection(isDialog: true),
                  const Spacer(),
                  CustomButton(onTap: ()=>Get.find<AuthController>().changeGender(), text: 'Save', width: SizeConfig.widthMultiplier*40)
                ],
              ),
            )),
          ),
        ));
  }
}
