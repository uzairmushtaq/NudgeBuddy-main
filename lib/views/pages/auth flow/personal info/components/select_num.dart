import 'package:NudgeBuddy/utils/size_config.dart';
import 'package:flutter/material.dart';

// RENDERS THE NUMBER VALUE SELECTION WIDGET FOR USER TO SELECT THEIR AGE, WEIGHT, HEIGHT, ETC.
// ================================================================================================================
class SelectNumVal extends StatelessWidget {
  const SelectNumVal({
    Key? key,
    required this.value,
    required this.unit,
    required this.title,
    required this.onTap,
  }) : super(key: key);
  final num value;
  final String unit;
  final String title;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: SizeConfig.textMultiplier * 2),
        ),
        SizedBox(height: SizeConfig.heightMultiplier * 1),
        GestureDetector(
          onTap: onTap,
          child: Container(
            height: SizeConfig.heightMultiplier * 5,
            width: SizeConfig.widthMultiplier * 35,
            decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(8)),
            padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.widthMultiplier * 3),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '$value $unit',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: SizeConfig.textMultiplier * 1.8),
                ),
                const Icon(Icons.arrow_drop_down)
              ],
            ),
          ),
        ),
      ],
    );
  }
}
