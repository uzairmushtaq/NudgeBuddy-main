import 'package:NudgeBuddy/constants/colors.dart';
import 'package:NudgeBuddy/constants/icons.dart';
import 'package:NudgeBuddy/utils/root.dart';
import 'package:NudgeBuddy/utils/size_config.dart';
import 'package:NudgeBuddy/views/pages/auth%20flow/onboarding/onboarding.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';

// SPLASH PAGE CLASS - USED TO SHOW THE SPLASH SCREEN OF THE APP
// ================================================================================================================
class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1),()=>Get.off(()=>Root()));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Image.asset(IconsConstants.appIcon,height: SizeConfig.heightMultiplier*20,),),
    );
  }
}
