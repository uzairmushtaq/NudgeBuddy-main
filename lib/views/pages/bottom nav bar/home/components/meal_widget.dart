import 'package:NudgeBuddy/constants/decoration.dart';
import 'package:NudgeBuddy/controllers/meal.dart';
import 'package:NudgeBuddy/models/meal_model.dart';
import 'package:NudgeBuddy/services/meal.dart';
import 'package:NudgeBuddy/utils/size_config.dart';
import 'package:NudgeBuddy/views/dialog/add_meal.dart';
import 'package:NudgeBuddy/views/widgets/confirmation_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// RENDERS THE MEAL WIDGET THAT APPEARS BELOWS THE MEAL TITLE OF A MEAL BOX
// CONTAINS THE LIST OF MEALS AND THE TOTAL CALORIES OF THE MEAL, AND A BUTTON TO ADD A NEW MEAL TO THE LIST AND ONE TO DELETE THE MEAL BOX
// ================================================================================================================
class MealWidget extends StatelessWidget {
  const MealWidget({
    Key? key,
    required this.title,
    required this.color,
    required this.data,
    required this.kcalVal,
  }) : super(key: key);
  final String title;
  final Color color;
  final List<MealModel> data;
  final int kcalVal;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Padding(
          padding: EdgeInsets.only(top: SizeConfig.heightMultiplier * 2),
          child: Stack(
            children: [
              Container(
                width: SizeConfig.widthMultiplier * 90,
                decoration: DecorationConstants.whiteBoxLowRadius,
                child: Padding(
                  padding: EdgeInsets.only(
                    top: SizeConfig.heightMultiplier * 2.5,
                    bottom: SizeConfig.heightMultiplier * 2.5,
                    left: SizeConfig.widthMultiplier * 5,
                    right: SizeConfig.widthMultiplier * 1,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //TITLE & SUBTITLE
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                title,
                                style: TextStyle(
                                    fontSize: SizeConfig.textMultiplier * 2.2,
                                    color: color,
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                  width: kcalVal == 0
                                      ? 0
                                      : SizeConfig.widthMultiplier * 2),
                              kcalVal == 0
                                  ? const SizedBox()
                                  : Text(
                                      '$kcalVal Kcal',
                                      style: TextStyle(
                                          fontSize:
                                              SizeConfig.textMultiplier * 2.2,
                                          fontWeight: FontWeight.w500),
                                    ),
                            ],
                          ),
    
                          SizedBox(
                              height: data.isEmpty
                                  ? 0
                                  : SizeConfig.heightMultiplier * 1),
                          //TODAY MEALS
                          ListView.builder(
                              itemCount: data.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              padding: EdgeInsets.zero,
                              itemBuilder: (_, i) => Padding(
                                    padding: EdgeInsets.only(
                                        top: SizeConfig.heightMultiplier * 0.5),
                                    child: Row(
                                      children: [
                                        InkWell(
                                          onTap: () => Get.dialog(AddMealDialog(
                                            isEdit: true,
                                            meal: data[i],
                                          )),
                                          child: SizedBox(
                                            width:
                                                SizeConfig.widthMultiplier * 55,
                                            child: Text(
                                              '${data[i].title} ${data[i].quantity}',
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  color: Colors.blueGrey,
                                                  fontSize:
                                                      SizeConfig.textMultiplier *
                                                          1.5),
                                            ),
                                          ),
                                        ),
                                        const Spacer(),
                                        Text(
                                          '${data[i].kcal! * num.parse(data[i].quantity!)} kcal',
                                          style: TextStyle(
                                              color: Colors.blueGrey,
                                              fontSize:
                                                  SizeConfig.textMultiplier *
                                                      1.5),
                                        ),
                                        InkWell(
                                          onTap: () => Get.dialog(ConfirmationDialog(
                                              text:
                                                  'Do you want to delete ${data[i].title} from your list?',
                                              onConfirm: () => MealService()
                                                  .deleteMeal(data[i].id!))),
                                          child: Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: Icon(
                                              Icons.remove_circle,
                                              color: Colors.grey.shade300,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ))
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                  bottom: 0,
                  top: 0,
                  left: 0,
                  child: Container(
                    width: SizeConfig.widthMultiplier * 2,
                    decoration: BoxDecoration(
                        color: color,
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            bottomLeft: Radius.circular(10))),
                  )),
            ],
          ),
      ),
    );
  }
}
