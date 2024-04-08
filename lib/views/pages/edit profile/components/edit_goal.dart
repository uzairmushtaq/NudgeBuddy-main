import 'package:NudgeBuddy/controllers/auth.dart';
import 'package:NudgeBuddy/utils/size_config.dart';
import 'package:NudgeBuddy/views/pages/auth%20flow/activity%20level/activity_level.dart';
import 'package:NudgeBuddy/views/pages/auth%20flow/select%20goals/select_goals.dart';
import 'package:NudgeBuddy/views/widgets/custom_button.dart';
import 'package:NudgeBuddy/views/widgets/show_loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// EDIT GOAL BOTTOM SHEET CLASS - SHOWS THE WIDGET THAT ALLOWS THE USER TO EDIT THEIR GOAL
// ================================================================================================================
class EditGoalBS extends StatelessWidget {
  EditGoalBS({super.key, required this.isGoal});
  final bool isGoal;
  final cont = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        height: isGoal
            ? SizeConfig.heightMultiplier * 75
            : SizeConfig.heightMultiplier * 80,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(16)),
        child: ShowLoading(
          inAsyncCall: cont.isLoading.value,
          child: Column(
            children: [
              SizedBox(height: SizeConfig.heightMultiplier * 4),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.widthMultiplier * 5),
                child: Text(
                  isGoal ? "Select Goal" : "Select your activity level",
                  style: TextStyle(
                      fontSize: SizeConfig.textMultiplier * 2,
                      fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(height: SizeConfig.heightMultiplier * 2),
              SizedBox(
                  height: !isGoal
                      ? SizeConfig.heightMultiplier * 58
                      : SizeConfig.heightMultiplier * 55,
                  width: SizeConfig.widthMultiplier * 100,
                  child: isGoal ? SelectGoals() : SelectActivity()),
              SizedBox(height: SizeConfig.heightMultiplier * 2),
              CustomButton(
                  onTap: () {
                    if (isGoal) {
                      cont.changeGoalIndex();
                    } else {
                      cont.changeActivityIndex();
                    }
                  },
                  text: 'Save',
                  width: SizeConfig.widthMultiplier * 80)
            ],
          ),
        ),
      ),
    );
  }
}
