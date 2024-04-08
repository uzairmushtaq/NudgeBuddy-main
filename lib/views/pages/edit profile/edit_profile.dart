import 'package:NudgeBuddy/controllers/auth.dart';
import 'package:NudgeBuddy/models/activity.dart';
import 'package:NudgeBuddy/models/goals.dart';
import 'package:NudgeBuddy/utils/size_config.dart';
import 'package:NudgeBuddy/views/dialog/edit_gender.dart';
import 'package:NudgeBuddy/views/dialog/edit_password.dart';
import 'package:NudgeBuddy/views/pages/edit%20profile/components/edit_goal.dart';
import 'package:NudgeBuddy/views/pages/bottom%20nav%20bar/profile/components/options.dart';
import 'package:NudgeBuddy/views/widgets/num_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// EDIT PROFILE CLASS - USED TO SHOW THE EDIT PROFILE PAGE WITHIN THE PROFILE PAGE
// ================================================================================================================
class EditProfile extends GetWidget<AuthController> {
  const EditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('EDIT PROFILE'),
      ),
      body:  Obx(
        ()=> Column(
          children: [
            SizedBox(height: SizeConfig.heightMultiplier * 3),
            ProfileOptions(
                title: 'Gender',
                subtitle:
                    controller.userInfo.genderIndex == 0 ? 'Male' : 'Female',
                onTap: () => Get.dialog(const EditGender())),
            ProfileOptions(
                title: 'Height',
                subtitle:
                    '${controller.userInfo.height} ${controller.userInfo.heightUnit}',
                onTap: () {
                  controller.heightFeetVal.value = int.parse(controller
                      .userInfo.height!
                      .toDouble()
                      .toString()
                      .split('.')[0]);
                  controller.heightInchesVal.value = int.parse(controller
                      .userInfo.height!
                      .toDouble()
                      .toString()
                      .split('.')[1]);
                  controller.heightUnit.value = controller.userInfo.heightUnit!;
                  showModalBottomSheet(
                      backgroundColor: Colors.transparent,
                      context: context,
                      builder: (_) => NumSlider(
                            isWeight: false,
                            isEdit: true,
                          ));
                }),
            ProfileOptions(
                title: 'Weight',
                subtitle:
                    '${controller.userInfo.weight} ${controller.userInfo.weightUnit}',
                onTap: () {
                  controller.weightVal.value = controller.userInfo.weight! as int;
                  controller.weightUnit.value = controller.userInfo.weightUnit!;
                  showModalBottomSheet(
                      backgroundColor: Colors.transparent,
                      context: context,
                      builder: (_) => NumSlider(
                            isWeight: true,
                            isEdit: true,
                          ));
                }),
            ProfileOptions(
                title: 'Age',
                subtitle: '${controller.userInfo.age!} years',
                onTap: () {
                  controller.age.value = controller.userInfo.age!;
                  showModalBottomSheet(
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      context: context,
                      builder: (_) => NumSlider(
                            isWeight: true,
                            isAge: true,
                            isEdit: true,
                          ));
                }),
            ProfileOptions(
                title: 'Goal',
                subtitle: GoalsModel.data[controller.userInfo.goalIndex!].title,
                onTap: () {
                  controller.selectedGoalIndex.value =
                      controller.userInfo.goalIndex!;
                  showModalBottomSheet(
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      context: context,
                      builder: (_) => EditGoalBS(isGoal: true));
                }),
            ProfileOptions(
                title: 'Activity Level',
                subtitle: ActivityModel
                    .data[controller.userInfo.activityLevelIndex!].title,
                onTap: () {
                  controller.selectedActivityIndex.value =
                      controller.userInfo.activityLevelIndex!;
                  showModalBottomSheet(
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      context: context,
                      builder: (_) => EditGoalBS(isGoal: false));
                }),
            ProfileOptions(
                title: 'Weight Goal',
                subtitle: controller.userInfo.weightGoal == 0
                    ? 'No Goal Set'
                    : '${controller.userInfo.weightGoal!} Kgs',
                onTap: () {
                  if(controller.userInfo.weightGoal==0){
                controller.weightVal.value =50;
               }else{
                 controller.weightVal.value =
                    controller.userInfo.weightGoal! as int;
               }
                  showModalBottomSheet(
                      backgroundColor: Colors.transparent,
                      context: context,
                      builder: (_) => NumSlider(
                            isWeight: true,
                            isEdit: true,
                            isGoalWeight: true,
                          ));
                }),
          ],
        ),
      ),
    );
  }
}
