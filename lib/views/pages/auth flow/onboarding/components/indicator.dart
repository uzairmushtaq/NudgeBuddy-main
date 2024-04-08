import 'package:NudgeBuddy/controllers/onboarding.dart';
import 'package:NudgeBuddy/models/onboarding.dart';
import 'package:NudgeBuddy/utils/size_config.dart';
import 'package:flutter/material.dart';

//RENDER THE INDICATOR FOR THE ONBOARDING PAGE - THE 2 BARS AT THE BOTTOM OF THE SCREEN
// ================================================================================================================
class PageIndicator extends StatelessWidget {
  const PageIndicator({
    Key? key,
    required this.cont,
  }) : super(key: key);

  final OnboardingCont cont;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ...List.generate(
          OnboardingModel.data.length,
          (index) => AnimatedContainer(
            duration: const Duration(milliseconds: 400),
            margin: EdgeInsets.only(right: SizeConfig.widthMultiplier * 1.5),
            height: SizeConfig.heightMultiplier * 1.3,
            width: cont.currentPage.value == index
                ? SizeConfig.widthMultiplier * 10
                : SizeConfig.widthMultiplier * 3.5,
            decoration: BoxDecoration(
              color: cont.currentPage.value == index
                  ? Colors.grey.shade600
                  : Colors.grey.shade300,
              borderRadius: cont.currentPage.value == index
                  ? BorderRadius.circular(10)
                  : BorderRadius.circular(50),
            ),
          ),
        ),
      ],
    );
  }
}
