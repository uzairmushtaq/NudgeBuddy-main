import 'package:NudgeBuddy/controllers/auth.dart';
import 'package:NudgeBuddy/controllers/stats.dart';
import 'package:NudgeBuddy/services/stats.dart';
import 'package:NudgeBuddy/utils/size_config.dart';
import 'package:NudgeBuddy/views/widgets/custom_calendar_appbar.dart';
import 'package:NudgeBuddy/views/widgets/num_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/percent_indicator.dart';

import 'components/bottom_graph.dart';
import 'components/chart.dart';

// STATS PAGE CLASS - RENDER THE PROGRESS PAGE
// ================================================================================================================
class StatsPage extends StatefulWidget {
  StatsPage({super.key});

  @override
  State<StatsPage> createState() => _StatsPageState();
}

class _StatsPageState extends State<StatsPage> {
  final cont = Get.find<StatsCont>();
  final authCont = Get.find<AuthController>();
  final dateFormat = DateFormat('dd MMMM');

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () =>getStatsData());
  }
  getStatsData(){
    StatsService.getConsumedKcal();
      StatsService.getWeights();
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomCalendarAppBar(isStats: true),
      body: SingleChildScrollView(
        child: Obx(
          () => Padding(
            padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.widthMultiplier * 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //WEIGHT GRAPH
                SizedBox(height: SizeConfig.heightMultiplier * 1),
                Text(
                  'WEIGHT OVERVIEW',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: SizeConfig.textMultiplier * 2),
                ),
                SizedBox(height: SizeConfig.heightMultiplier * 2),
                authCont.userInfo.weightGoal == 0
                    ? SizedBox(
                        height: SizeConfig.heightMultiplier * 30,
                        child: const Center(
                          child: Text('No weight goal added'),
                        ),
                      )
                    : cont.getWeights == null
                        ? SizedBox(
                            height: SizeConfig.heightMultiplier * 30,
                            child: const Center(
                              child: CircularProgressIndicator(
                                color: Color(0xFF9dd02f),
                              ),
                            ),
                          )
                        : Graph(
                            widget.key,
                            const Color(0xFF9dd02f),
                            cont.getWeights!,
                            authCont.userInfo.weightGoal!.toDouble(),
                            authCont.userInfo.weightGoal!as int),

                authCont.userInfo.weightGoal == 0
                    ? const SizedBox()
                    : BottomGraphSlider(
                        goalVal: authCont.userInfo.weightGoal! as int,
                        currentVal: cont.todayWeight.value,
                        isWeight: true,
                      ),
                //CALORIE GRAPH

                Text(
                  'CALORIES OVERVIEW',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: SizeConfig.textMultiplier * 2),
                ),
                SizedBox(height: SizeConfig.heightMultiplier * 2),
                cont.getCalories == null
                    ? SizedBox(
                        height: SizeConfig.heightMultiplier * 30,
                        child: const Center(
                          child: CircularProgressIndicator(
                            color: Colors.deepOrange,
                          ),
                        ),
                      )
                    : cont.highestKcalVal.value == 0
                        ? SizedBox(
                            height: SizeConfig.heightMultiplier * 30,
                            child: const Center(
                              child: Text('No caloric data available'),
                            ),
                          )
                        : Graph(
                            widget.key,
                            Colors.deepOrange,
                            cont.getCalories!,
                            cont.highestKcalVal.value.toDouble(),
                            cont.highestKcalVal.value ~/ 4),

                SizedBox(height: SizeConfig.heightMultiplier * 12),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
