import 'package:NudgeBuddy/constants/colors.dart';
import 'package:NudgeBuddy/controllers/auth.dart';
import 'package:NudgeBuddy/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// RENDERS THE OPTION TO SELECT USER GENDER
// ================================================================================================================
class GenderSelection extends StatelessWidget {
  GenderSelection({
    Key? key,
    this.isDialog = false,
  }) : super(key: key);
  final bool isDialog;
  final authCont = Get.find<AuthController>();
  List<String> data = ['Male', 'Female'];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: SizeConfig.heightMultiplier * 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          isDialog
              ? const SizedBox()
              : Text(
                  'Gender',
                  style: TextStyle(fontSize: SizeConfig.textMultiplier * 2),
                ),
          SizedBox(height: isDialog ? 0 : SizeConfig.heightMultiplier * 1),
          Row(
            mainAxisAlignment: isDialog
                ? MainAxisAlignment.spaceEvenly
                : MainAxisAlignment.start,
            children: [
              ...List.generate(
                  data.length,
                  (index) => GestureDetector(
                        onTap: () => authCont.selectedGender.value = index,
                        child: Obx(
                          () => AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            height: SizeConfig.heightMultiplier * 4.7,
                            width: SizeConfig.widthMultiplier * 30,
                            margin: EdgeInsets.only(
                                right: isDialog
                                    ? 0
                                    : SizeConfig.widthMultiplier * 5),
                            decoration: BoxDecoration(
                                color: authCont.selectedGender.value == index
                                    ? ColorConstants.primaryColor
                                    : Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(10)),
                            child: Center(
                              child: Text(
                                data[index],
                                style: TextStyle(
                                    color:
                                        authCont.selectedGender.value == index
                                            ? Colors.white
                                            : Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: SizeConfig.textMultiplier * 1.8),
                              ),
                            ),
                          ),
                        ),
                      ))
            ],
          ),
        ],
      ),
    );
  }
}
