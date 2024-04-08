import 'package:NudgeBuddy/constants/colors.dart';
import 'package:NudgeBuddy/controllers/auth.dart';
import 'package:NudgeBuddy/controllers/meal.dart';
import 'package:NudgeBuddy/controllers/stats.dart';
import 'package:NudgeBuddy/services/meal.dart';
import 'package:NudgeBuddy/services/stats.dart';
import 'package:NudgeBuddy/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

// CUSTOM CALENDAR APPBAR CLASS - USED TO SHOW THE CALENDAR APPBAR IN THE MEAL AND STATS PAGE
// ================================================================================================================
class CustomCalendarAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  CustomCalendarAppBar({
    Key? key,
    required this.isStats,
  }) : super(key: key);
  final bool isStats;
  final DateFormat _dateFormat = DateFormat('MMMM dd yyyy');
  final authCont = Get.find<AuthController>();
  final mealCont = Get.find<MealCont>();
  final statsCont = Get.find<StatsCont>();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      title: SizedBox(
        width: SizeConfig.widthMultiplier * 35,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(
              () => Text(
                _dateFormat.format(DateTime.parse(isStats
                    ? statsCont.selectedDate.value
                    : mealCont.selectedDate.value)),
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: SizeConfig.textMultiplier * 1.7),
              ),
            ),
            const Icon(Icons.arrow_drop_down)
          ],
        ),
      ),
      centerTitle: true,
      actions: [
        Padding(
          padding: EdgeInsets.only(
              left: SizeConfig.widthMultiplier * 5,
              right: SizeConfig.widthMultiplier * 5,
              top: SizeConfig.heightMultiplier * 1),
          child: InkWell(
            onTap: () async {
              final selectedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.parse(isStats
                      ? statsCont.selectedDate.value
                      : mealCont.selectedDate.value),
                  firstDate: DateTime.utc(2020),
                  lastDate: DateTime.now());
              if (selectedDate != null) {
                if (isStats) {
                  statsCont.selectedDate.value =
                      selectedDate.toString().split(' ')[0];
                  await StatsService.getWeights();
                  await StatsService.getConsumedKcal();
                } else {
                  mealCont.selectedDate.value =
                      selectedDate.toString().split(' ')[0];
                  await MealService().getTakenNutrients();
                }
              }
            },
            child: CircleAvatar(
              radius: SizeConfig.widthMultiplier * 6,
              backgroundColor: ColorConstants.primaryColor,
              child: const Icon(FeatherIcons.calendar, color: Colors.white),
            ),
          ),
        )
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(SizeConfig.heightMultiplier *7);
}
