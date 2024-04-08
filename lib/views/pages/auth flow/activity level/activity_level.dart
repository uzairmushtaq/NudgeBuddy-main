import 'package:NudgeBuddy/models/activity.dart';
import 'package:NudgeBuddy/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'components/tile.dart';

// RENDERS THE LIST OF ACTIVITY TILES FOR USER TO SELECT ACTIVITY LEVEL
// ================================================================================================================
class SelectActivity extends StatelessWidget {
  SelectActivity({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: ListView.builder(
        itemCount: ActivityModel.data.length,
        padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.widthMultiplier * 10,
            vertical: SizeConfig.heightMultiplier * 1),
        shrinkWrap: true,
        itemBuilder: (_, index) {
          return ActivityTile(index: index);
        },
      ),
    );
  }
}
