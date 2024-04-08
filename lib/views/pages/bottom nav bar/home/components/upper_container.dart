import 'package:NudgeBuddy/constants/colors.dart';
import 'package:NudgeBuddy/constants/decoration.dart';
import 'package:NudgeBuddy/controllers/meal.dart';
import 'package:NudgeBuddy/services/nutrients.dart';
import 'package:NudgeBuddy/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/percent_indicator.dart';

import 'total_nutrients.dart';

// NUTRIENTS UPPER BODY CLASS - USED TO SHOW THE NUTRIENTS UPPER BODY OF THE APP
// ================================================================================================================
class NutrientsUpperBody extends StatelessWidget {
  NutrientsUpperBody({
    Key? key,
  }) : super(key: key);
  final cont = Get.find<MealCont>();
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: SizeConfig.widthMultiplier * 4),
      padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.widthMultiplier * 4,
          vertical: SizeConfig.heightMultiplier * 2),
      decoration: DecorationConstants.whiteBox,
      child: Obx(
        () => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //CALORIES CONTAINER
            Row(
              children: [
                //CONSUMED
                Container(
                  height: SizeConfig.heightMultiplier * 6,
                  width: SizeConfig.widthMultiplier * 0.8,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: Colors.grey.shade700),
                ),
                SizedBox(width: SizeConfig.widthMultiplier * 2),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Consumed',
                      style: TextStyle(
                          fontSize: SizeConfig.textMultiplier * 1.6,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey.shade800),
                    ),
                    Text(
                      '${cont.takenKcal.value} kcal',
                      style: TextStyle(
                        fontSize: SizeConfig.textMultiplier * 2.5,
                      ),
                    )
                  ],
                ),
                const Spacer(),
                //REMAINING
                CircularPercentIndicator(
                  radius: SizeConfig.widthMultiplier * 20,
                  lineWidth: 10.0,
                  animation: true,
                  percent: cont.takenKcal.value > NutrientService().goalkcal()
                      ? 1
                      : ((cont.takenKcal.value * 100) /
                              NutrientService().goalkcal()) *
                          0.01,
                  circularStrokeCap: CircularStrokeCap.round,
                  progressColor: const Color(0xFF00984F),
                  backgroundColor: Colors.grey.shade200,
                  center: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${NutrientService().goalkcal()}',
                          style: TextStyle(
                              fontSize: SizeConfig.textMultiplier * 2.8,
                              color: const Color(0xFF00984F),
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                          'Remaining kcal',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: SizeConfig.textMultiplier * 1.4,
                              color: Colors.grey.shade600,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(
              height: SizeConfig.heightMultiplier * 2,
            ),
            //OTHER NUTRIENTS
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TotalNutrients(
                  totalAmount: NutrientService().getGoalCrabs(),
                  currentAmount: cont.takenCarbs.value,
                  name: "Carbs",
                  color: ColorConstants.carbs,
                ),
                SizedBox(
                  height: SizeConfig.heightMultiplier * 1,
                ),
                TotalNutrients(
                  totalAmount: NutrientService().getGoalProtein(),
                  currentAmount: cont.takenProtein.value,
                  name: "Protein",
                  color: ColorConstants.protein,
                ),
                SizedBox(
                  height: SizeConfig.heightMultiplier * 1,
                ),
                TotalNutrients(
                  totalAmount: NutrientService().getGoalFats(),
                  currentAmount: cont.takenFats.value,
                  name: "Fats",
                  color: ColorConstants.fats,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
