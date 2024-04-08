import 'package:NudgeBuddy/constants/colors.dart';
import 'package:NudgeBuddy/controllers/auth.dart';
import 'package:NudgeBuddy/models/goals.dart';
import 'package:NudgeBuddy/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'components/tile.dart';

// RENDERS THE LIST OF GOALS TILES FOR USER TO SELECT GOALS
// ================================================================================================================
class SelectGoals extends StatelessWidget {
  SelectGoals({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: ListView.builder(
        itemCount: GoalsModel.data.length,
        padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.widthMultiplier * 33,
            vertical: SizeConfig.heightMultiplier * 1),
        shrinkWrap: true,
        itemBuilder: (_, index) {
          return GoalsTile(index: index);
        },
      ),
    );
  }
}
