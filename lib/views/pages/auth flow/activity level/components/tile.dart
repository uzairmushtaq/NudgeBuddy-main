import 'package:NudgeBuddy/constants/colors.dart';
import 'package:NudgeBuddy/controllers/auth.dart';
import 'package:NudgeBuddy/models/activity.dart';
import 'package:NudgeBuddy/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fadein/flutter_fadein.dart';
import 'package:get/get.dart';

// RENDERS ANIMATED TILES FOR USER TO SELECT ACTIVITY LEVEL
// ================================================================================================================
class ActivityTile extends StatelessWidget {
  ActivityTile({
    Key? key,
    required this.index,
  }) : super(key: key);
  final cont = Get.find<AuthController>();
  final int index;
  @override
  Widget build(BuildContext context) {
    final data = ActivityModel.data[index];
    return Obx(
      ()=> FadeIn(
          duration: const Duration(milliseconds: 400),

        child: GestureDetector(
          onTap: ()=>cont.selectedActivityIndex.value=index,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: SizeConfig.heightMultiplier * 12,
            width: SizeConfig.widthMultiplier * 20,
            decoration: BoxDecoration(
                color: cont.selectedActivityIndex.value == index
                    ? ColorConstants.tileColor
                    : Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.shade200,
                      blurRadius: 6,
                      offset: const Offset(-1, 1))
                ]),
            margin: EdgeInsets.only(bottom: SizeConfig.heightMultiplier * 2),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  data.title,
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: SizeConfig.textMultiplier * 2),
                ),
                index == 0
                    ? const SizedBox()
                    : SizedBox(
                        width: SizeConfig.widthMultiplier * 55,
                        child: Text(
                          '(${data.subtitle})',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: SizeConfig.textMultiplier * 1.4),
                        ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
