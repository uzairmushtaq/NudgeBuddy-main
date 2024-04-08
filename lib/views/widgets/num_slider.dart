import 'package:NudgeBuddy/constants/colors.dart';
import 'package:NudgeBuddy/constants/units.dart';
import 'package:NudgeBuddy/controllers/auth.dart';
import 'package:NudgeBuddy/services/weight.dart';
import 'package:NudgeBuddy/views/widgets/custom_button.dart';
import 'package:NudgeBuddy/views/widgets/show_loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:numberpicker/numberpicker.dart';
import '../../utils/size_config.dart';

// NUM SLIDER WIDGET - CUSTOM SLIDER WIDGET FOR SELECTING WEIGHT, HEIGHT AND AGE WITHIN THE INPUT PAGES
//===============================================================================================================================
class NumSlider extends StatelessWidget {
  NumSlider(
      {Key? key,
      required this.isWeight,
      required this.isEdit,
      this.isAge = false,
      this.isGoalWeight = false,
      this.isAddGoalWeight = false});
  final bool isWeight;
  final bool isEdit;
  final bool isGoalWeight;
  final bool isAddGoalWeight;
  final bool isAge;

  final cont = Get.find<AuthController>(); //CONNECTS TO THE AUTH CONTROLLER FOR GETTING THE VALUES OF THE NUM SLIDER

  @override
  Widget build(BuildContext context) { //BUILDS THE NUM SLIDER WIDGET
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: SizeConfig.heightMultiplier * 50,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(16)),
        child: Obx(
          () => ShowLoading(
            inAsyncCall: cont.isLoading.value,
            child: Column(
              children: [
                SizedBox(height: SizeConfig.heightMultiplier * 4),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.widthMultiplier * 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //WEIGHT VALUE
                      Text(
                        isAge
                            ? 'Select Age'
                            : isWeight
                                ? isGoalWeight
                                    ? 'Select Weight' //IF GOAL WEIGHT IS SELECTED
                                    : "Select Weight"
                                : "Select Height",
                        style: TextStyle(
                            fontSize: SizeConfig.textMultiplier * 2,
                            fontWeight: FontWeight.w600),
                      ),
                      Text(
                        isAge
                            ? '${cont.age.value} years'
                            : isWeight
                                ? isGoalWeight
                                    ? '${cont.weightVal.value} Kgs'
                                    : cont.weightUnit.value == UnitConstants.kg
                                        ? "${cont.weightVal.value} Kgs"
                                        : "${cont.weightVal.value} Pounds"
                                : cont.heightUnit.value == UnitConstants.feet
                                    ? "${cont.heightFeetVal.value}.${cont.heightInchesVal.value} feet"
                                    : "${cont.heightFeetVal.value} cm",
                        style: TextStyle(
                            fontSize: SizeConfig.textMultiplier * 2,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),

                SizedBox(
                  height: isWeight
                      ? SizeConfig.heightMultiplier * 2
                      : SizeConfig.heightMultiplier * 4,
                ),
                SizedBox(
                    height: isWeight
                        ? 0
                        : cont.heightUnit.value != UnitConstants.feet
                            ? SizeConfig.heightMultiplier * 6
                            : 0),
                isWeight
                    ? const SizedBox()
                    : Text(cont.heightUnit.value == UnitConstants.feet
                        ? 'Feet'
                        : 'Centimeters'),
                SizedBox(
                  height: isGoalWeight ? SizeConfig.heightMultiplier * 2 : 0,
                ),
                //NUM PICKER
                SizedBox(
                  child: NumberPicker(
                      value: isAge
                          ? cont.age.value
                          : isWeight
                              ? cont.weightVal.value
                              : cont.heightFeetVal.value,
                      minValue: isWeight ? 0 : 0,
                      maxValue: isAge
                          ? 100
                          : isWeight
                              ? 500
                              : cont.heightUnit.value == UnitConstants.feet
                                  ? 10
                                  : 500,
                      axis: isWeight ? Axis.vertical : Axis.horizontal,
                      textStyle: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: SizeConfig.textMultiplier * 5,
                          color: Colors.grey.shade800),
                      itemHeight: SizeConfig.heightMultiplier * 8,
                      itemWidth: SizeConfig.widthMultiplier * 30,
                      selectedTextStyle: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: SizeConfig.textMultiplier * 5,
                          color: ColorConstants.primaryColor),
                      onChanged: (value) => isAge
                          ? cont.age.value = value
                          : isWeight
                              ? cont.weightVal.value = value
                              : cont.heightFeetVal.value = value),
                ),

                isWeight
                    ? const SizedBox()
                    : cont.heightUnit.value != UnitConstants.feet
                        ? const SizedBox()
                        : const Text('Inches'),

                isWeight
                    ? const SizedBox()
                    : cont.heightUnit.value != UnitConstants.feet
                        ? const SizedBox()
                        : SizedBox(
                            child: NumberPicker(
                                value: cont.heightInchesVal.value,
                                minValue: 0,
                                maxValue: 11,
                                axis:
                                    isWeight ? Axis.vertical : Axis.horizontal,
                                textStyle: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: SizeConfig.textMultiplier * 5,
                                    color: Colors.grey.shade800),
                                itemHeight: SizeConfig.heightMultiplier * 8,
                                itemWidth: SizeConfig.widthMultiplier * 30,
                                selectedTextStyle: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: SizeConfig.textMultiplier * 5,
                                    color: ColorConstants.primaryColor),
                                onChanged: (value) =>
                                    cont.heightInchesVal.value = value),
                          ),
                SizedBox(
                    height: isWeight
                        ? 0
                        : cont.heightUnit.value != UnitConstants.feet
                            ? SizeConfig.heightMultiplier * 4.6
                            : 0),
                //SELECT NUM TYPE
                isGoalWeight || isAge
                    ? SizedBox(
                        height: SizeConfig.heightMultiplier * 4,
                      )
                    : SelectNumType(
                        isHeight: isWeight ? false : true,
                      ),
                SizedBox(
                  height: SizeConfig.heightMultiplier * 2,
                ),
                CustomButton(
                    onTap: () {
                      if (isAge) {
                        if (!isEdit) {
                          Get.back();
                        } else {
                          cont.changeAge();
                        }
                      } else {
                        if (isGoalWeight) {
                          if (isAddGoalWeight) {
                            WeightService.addGoalWeight(cont.weightVal.value);
                          } else {
                            cont.changeWeightGoal();
                          }
                        } else {
                          if (isEdit) {
                            if (isWeight) {
                              cont.changeWeight();
                            } else {
                              cont.changeHeight();
                            }
                          } else {
                            Get.back();
                          }
                        }
                      }
                    },
                    text: 'Done',
                    width: SizeConfig.widthMultiplier * 80)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
// SELECT NUM TYPE WIDGET ALLOWS TO SELECT HEIGHT OR WEIGHT UNIT TYPE LIKE FEET OR CM
class SelectNumType extends StatelessWidget {
  SelectNumType({
    Key? key,
    required this.isHeight,
  }) : super(key: key);
  final bool isHeight;
  List<String> heightUnits = ['Feet', 'cm'];
  List<String> weightUnits = ['Kgs', 'Pounds'];
  final cont = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ...List.generate(isHeight ? heightUnits.length : weightUnits.length,
              (i) {
            bool value = isHeight
                ? cont.heightUnit.value == heightUnits[i]
                : cont.weightUnit.value == weightUnits[i];
            return GestureDetector(
              onTap: () {
                if (isHeight) {
                  cont.heightUnit.value = heightUnits[i];
                  if (cont.heightUnit.value == UnitConstants.centimeter) {
                    cont.heightFeetVal.value = 120;
                  } else {
                    cont.heightFeetVal.value = 5;
                  }
                } else {
                  cont.weightUnit.value = weightUnits[i];
                }
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 400),
                height: SizeConfig.heightMultiplier * 5,
                width: SizeConfig.widthMultiplier * 18,
                decoration: BoxDecoration(
                    color: value
                        ? ColorConstants.primaryColor
                        : Colors.grey.shade200,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(i == 0 ? 25 : 0),
                        bottomLeft: Radius.circular(i == 0 ? 25 : 0),
                        topRight: Radius.circular(i == 1 ? 25 : 0),
                        bottomRight: Radius.circular(i == 1 ? 25 : 0))),
                child: Center(
                    child: Text(
                  isHeight ? heightUnits[i] : weightUnits[i],
                  style: TextStyle(
                      color: value ? Colors.white : Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: SizeConfig.textMultiplier * 1.6),
                )),
              ),
            );
          }),
          SizedBox(width: SizeConfig.widthMultiplier * 5)
        ],
      ),
    );
  }
}
