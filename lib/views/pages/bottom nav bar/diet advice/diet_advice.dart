import 'package:NudgeBuddy/models/diet_advice.dart';
import 'package:NudgeBuddy/utils/size_config.dart';
import 'package:NudgeBuddy/views/pages/diet%20detail/diet_detail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';

import 'components/tile.dart';

// DIET ADVICE PAGE CLASS - RENDERS NUTRITION ADVICE PAGE AND LOOPS THROUGH THE LIST OF DIET ADVICE TILES
// ================================================================================================================

class DietAdvicePage extends StatelessWidget {
  const DietAdvicePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
        title: const Text('NUTRITION FACTS'),
      ),
      body: ListView.builder(
          itemCount: dietAvices.length,
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          padding: EdgeInsets.only(
              left: SizeConfig.widthMultiplier * 5,
              right: SizeConfig.widthMultiplier * 5,
              bottom: SizeConfig.heightMultiplier * 12,
              top: SizeConfig.heightMultiplier * 2),
          itemBuilder: (_, i) => DietAdviceTile(i: i)),
    );
  }
}
