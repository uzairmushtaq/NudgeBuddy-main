import 'package:NudgeBuddy/constants/colors.dart';
import 'package:NudgeBuddy/controllers/auth.dart';
import 'package:NudgeBuddy/models/goals.dart';
import 'package:NudgeBuddy/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fadein/flutter_fadein.dart';
import 'package:get/get.dart';

// RENDERS ANIMATED GOALS TILE
// ================================================================================================================
class GoalsTile extends StatelessWidget {
  GoalsTile({
    Key? key,
    required this.index,
  }) : super(key: key);
  final int index;
  final cont = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return FadeIn(
     duration: const Duration(milliseconds: 400),
      child: GestureDetector(
        onTap: () => cont.selectedGoalIndex.value = index,
        child: Obx(
          () => AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: SizeConfig.heightMultiplier * 16,
            width: SizeConfig.widthMultiplier * 20,
            decoration: BoxDecoration(
                color: cont.selectedGoalIndex.value == index
                    ? ColorConstants.tileColor
                    : Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.shade200,
                      blurRadius: 6,
                      offset: const Offset(-1, 1))
                ]),
            margin: EdgeInsets.only(bottom: SizeConfig.heightMultiplier * 2),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Image.asset(GoalsModel.data[index].image,
                  height: SizeConfig.heightMultiplier * 7),
              SizedBox(height: SizeConfig.heightMultiplier * 2),
              Text(
                GoalsModel.data[index].title,
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: SizeConfig.textMultiplier * 1.6),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
