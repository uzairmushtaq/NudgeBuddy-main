import 'package:NudgeBuddy/constants/colors.dart';
import 'package:NudgeBuddy/controllers/auth.dart';
import 'package:NudgeBuddy/services/notifications.dart';
import 'package:NudgeBuddy/utils/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// SETTINGS PAGE CLASS - USED TO SHOW THE SETTINGS PAGE OF THE APP
// ================================================================================================================
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('SETTINGS'),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(
              vertical: SizeConfig.heightMultiplier * 2,
              horizontal: SizeConfig.widthMultiplier * 5),
          child: Row(
            children: [
              Text(
                'Notifications',
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: SizeConfig.textMultiplier * 2),
              ),
              const Spacer(),
              Obx(
                ()=> Transform.scale(
                    scale: 0.8,
                    child: CupertinoSwitch(
                        value:
                            Get.find<AuthController>().allowNotifications.value,
                        activeColor: ColorConstants.primaryColor,
                        onChanged: (val) =>
                            NotificationService.notificationSwitch(val))),
              )
            ],
          ),
        ));
  }
}
