import 'package:NudgeBuddy/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

// TOTAL NUTRIENTS CLASS - USED TO SHOW THE TOTAL NUTRIENTS OF THE FOOD ITEM - 
// ================================================================================================================
class TotalNutrients extends StatelessWidget {
  const TotalNutrients({
    Key? key,
    required this.name,
    required this.totalAmount,
    required this.currentAmount,
    required this.color,
  }) : super(key: key);
  final String name;
  final int totalAmount, currentAmount;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          name,
          style: TextStyle(
            fontSize: SizeConfig.textMultiplier * 1.5,
            fontWeight: FontWeight.w600,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: LinearPercentIndicator(
            lineHeight: SizeConfig.heightMultiplier * 0.7,
            barRadius: const Radius.circular(100),
            width: SizeConfig.widthMultiplier * 25,
            padding: EdgeInsets.zero,
            backgroundColor: Colors.grey.shade200,
            progressColor: color,
            percent:
                currentAmount > totalAmount ? 1 : currentAmount / totalAmount,
          ),
        ),
        Text(
          "$currentAmount/$totalAmount g",
          style: TextStyle(
            fontSize: SizeConfig.textMultiplier * 1.6,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
