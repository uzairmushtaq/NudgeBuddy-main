import 'package:NudgeBuddy/constants/colors.dart';
import 'package:NudgeBuddy/constants/icons.dart';
import 'package:NudgeBuddy/utils/size_config.dart';
import 'package:flutter/material.dart';

// RENDERS THE LAST PAGE OF THE SIGN UP FLOW
// ================================================================================================================
class SubmitPage extends StatelessWidget {
  const SubmitPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Image.asset(IconsConstants.congratulations),
          Text(
            'Done',
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: SizeConfig.textMultiplier * 2.5,
                color: ColorConstants.primaryColor),
          ),
          Center(
            child: SizedBox(
              width: SizeConfig.widthMultiplier * 70,
              child: Text(
                "You've taken the first step towards a healthier life, and now your journey begins.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                  fontSize: SizeConfig.textMultiplier * 1.8,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
