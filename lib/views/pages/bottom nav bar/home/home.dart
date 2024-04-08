import 'package:NudgeBuddy/constants/colors.dart';
import 'package:NudgeBuddy/controllers/auth.dart';
import 'package:NudgeBuddy/controllers/meal.dart';
import 'package:NudgeBuddy/utils/size_config.dart';
import 'package:NudgeBuddy/views/dialog/add_meal.dart';
import 'package:NudgeBuddy/views/pages/bottom%20nav%20bar/home/components/upper_container.dart';
import 'package:NudgeBuddy/views/widgets/custom_calendar_appbar.dart';
import 'package:NudgeBuddy/views/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'components/meal_widget.dart';
import 'components/row_info.dart';

// HOMEPAGE CLASS - RENDERS HOMEPAGE OF THE APP
// ==============================================
class HomePage extends StatelessWidget {
  HomePage({super.key});
  final authCont = Get.find<AuthController>();
  final cont = Get.find<MealCont>();
  final dateFormat = DateFormat('MMMM dd, yyyy');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomCalendarAppBar(isStats: false),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: SizeConfig.heightMultiplier * 1),
            Padding(
              padding: EdgeInsets.only(
                  left: SizeConfig.widthMultiplier * 5,
                  bottom: SizeConfig.heightMultiplier * 1),
              child: Obx(
                () => Text(
                  'Welcome ${authCont.userInfo.username} !',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: SizeConfig.textMultiplier * 1.9),
                ),
              ),
            ),
            NutrientsUpperBody(),
            SizedBox(height: SizeConfig.heightMultiplier * 1),
            Padding(
              padding: EdgeInsets.only(left: SizeConfig.widthMultiplier * 5),
              child: Row(
                children: [
                  Text(
                    'DAILY MEALS',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: SizeConfig.textMultiplier * 1.9),
                  ),
                  const Spacer(),
                  IconButton(
                      onPressed: () => Get.dialog(AddMealDialog(isEdit: false)),
                      icon: CircleAvatar(
                          backgroundColor: Colors.grey.shade200,
                          child: const Icon(
                            Icons.add,
                            color: Colors.black,
                          ))),
                  SizedBox(width: SizeConfig.widthMultiplier * 2)
                ],
              ),
            ),
            Obx(
              () {
                return cont.getBreakFast == null ||
                        cont.getDinner == null && cont.getLunch == null ||
                        cont.getOther == null
                    ? LoadingWidget(height: SizeConfig.heightMultiplier * 30)
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MealWidget(
                              kcalVal: cont.breakFastKCAL.value,
                              title: 'Breakfast',
                              data: cont.getBreakFast!,
                              color: ColorConstants.breakfast),
                          MealWidget(
                              kcalVal: cont.lunchKCAL.value,
                              title: 'Lunch',
                              data: cont.getLunch!,
                              color: ColorConstants.lunch),
                          MealWidget(
                              kcalVal: cont.dinnerKCAL.value,
                              title: 'Dinner',
                              data: cont.getDinner!,
                              color: ColorConstants.dinner),
                          MealWidget(
                              kcalVal: cont.otherKCAL.value,
                              title: 'Other',
                              data: cont.getOther!,
                              color: ColorConstants.snack),
                        ],
                      );
              },
            ),
            SizedBox(height: SizeConfig.heightMultiplier * 2),
            Obx(() {
              authCont.homeTableKcalList
                  .sort((a, b) => a['Date'].compareTo(b['Date']));
                 
              return cont.selectedDate.value !=
                      DateTime.now().toString().split(' ')[0]
                  ? const SizedBox()
                  : Center(
                      child: Container(
                        height: SizeConfig.heightMultiplier * 20,
                        width: SizeConfig.widthMultiplier * 80,
                        decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(20)),
                        padding: EdgeInsets.symmetric(
                            horizontal: SizeConfig.widthMultiplier * 6,
                            vertical: SizeConfig.heightMultiplier * 2),
                        child: ListView.builder(
                          itemCount: authCont.homeTableKcalList.length,
                          reverse: true,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          itemBuilder: (_, i) => RowInfo(
                            title: i == authCont.homeTableKcalList.length - 1
                                ? 'Today'
                                : dateFormat.format(DateTime.parse(
                                    authCont.homeTableKcalList[i]['Date'])),
                            subtitle:
                                "${authCont.homeTableKcalList[i]['Value']} kcal",
                          ),
                        ),
                      ),
                    );
            }),
            SizedBox(height: SizeConfig.heightMultiplier * 15)
          ],
        ),
      ),
    );
  }
}
