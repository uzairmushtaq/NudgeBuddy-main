import 'package:NudgeBuddy/controllers/auth.dart';
import 'package:NudgeBuddy/controllers/stats.dart';
import 'package:NudgeBuddy/utils/size_config.dart';
import 'package:NudgeBuddy/views/widgets/num_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

// BOTTOM GRAPH SLIDER CLASS - RENDERS THE WIDGET AT THE BOTTOM OF THE FIRST "WEIGHT OVER-TIME GRAPH" THAT ALLOWS THE USER TO CHANGE TRACK THEIR WEIGHT
//=========================================================================================================================
class BottomGraphSlider extends StatelessWidget {
  const BottomGraphSlider({
    Key? key,
    required this.currentVal,
    required this.goalVal,
    this.isWeight = false,
  }) : super(key: key);
  final int currentVal, goalVal;
  final bool isWeight;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: SizeConfig.heightMultiplier * 14,
          width: SizeConfig.widthMultiplier * 90,
          margin:
              EdgeInsets.symmetric(vertical: SizeConfig.heightMultiplier * 2),
          decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(20)),
          padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.widthMultiplier * 8,
              vertical: SizeConfig.heightMultiplier * 2),
          child: Column(
            children: [
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: SizeConfig.heightMultiplier * 1),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '$goalVal',
                            style: TextStyle(
                                height: SizeConfig.heightMultiplier * 0.06,
                                fontSize: SizeConfig.textMultiplier * 3,
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(width: SizeConfig.widthMultiplier * 1),
                          Text(
                            'kg',
                            style: TextStyle(
                                fontSize: SizeConfig.textMultiplier * 1.5,
                                color: Colors.grey,
                                fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                      SizedBox(height: SizeConfig.heightMultiplier * 1),
                      Text(
                        'Goal Weight',
                        style: TextStyle(
                            fontSize: SizeConfig.textMultiplier * 1.5,
                            fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                  const Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: SizeConfig.heightMultiplier * 1),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                          currentVal==0?'N/A':  '$currentVal',
                            style: TextStyle(
                                height: SizeConfig.heightMultiplier * 0.06,
                                fontSize: SizeConfig.textMultiplier * 3,
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(width: SizeConfig.widthMultiplier * 1),
                         currentVal==0?const SizedBox(): Text(
                            'kg',
                            style: TextStyle(
                                fontSize: SizeConfig.textMultiplier * 1.5,
                                color: Colors.grey,
                                fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                      SizedBox(height: SizeConfig.heightMultiplier * 1),
                      Text(
                        'Current Weight',
                        style: TextStyle(
                            fontSize: SizeConfig.textMultiplier * 1.5,
                            fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                ],
              ),
              SizedBox(height: SizeConfig.heightMultiplier * 2),
              LinearPercentIndicator(
                lineHeight: SizeConfig.heightMultiplier * 0.7,
                barRadius: const Radius.circular(100),
                width: SizeConfig.widthMultiplier * 74,
                padding: EdgeInsets.zero,
                backgroundColor: Colors.grey.shade300,
                progressColor: isWeight
                    ? const Color(0xFF9dd02f)
                    : Colors.deepOrangeAccent,
                percent: currentVal / goalVal,
              ),
            ],
          ),
        ),
        Positioned(
          top: SizeConfig.heightMultiplier * 2.5,
          right: SizeConfig.widthMultiplier * 5,
          child: IconButton(
              onPressed: () {
                Get.find<AuthController>().weightVal.value =
                    Get.find<StatsCont>().todayWeight.value;
                showModalBottomSheet(
                    backgroundColor: Colors.transparent,
                    context: context,
                    builder: (_) => NumSlider(
                        isWeight: isWeight,
                        isEdit: false,
                        isAddGoalWeight: true,
                        isGoalWeight: true));
              },
              icon: const CircleAvatar(
                backgroundColor: Color(0xFF9dd02f),
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              )),
        )
      ],
    );
  }
}
