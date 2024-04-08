import 'package:NudgeBuddy/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// CUSTOM BACK BUTTON CLASS - USED TO NAVIGATE BACK TO THE PREVIOUS SCREEN
// ================================================================================================================
class CustomBackButton extends StatelessWidget {
  const CustomBackButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=>Get.back(),
      child: CircleAvatar(
        radius: SizeConfig.widthMultiplier * 6,
        backgroundColor: Colors.grey.shade200,
        child:const Icon(
          Icons.arrow_back_ios_new_rounded,
          color: Colors.black,
          size: 18,
        ),
      ),
    );
  }
}
