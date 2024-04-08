import 'package:NudgeBuddy/constants/colors.dart';
import 'package:NudgeBuddy/controllers/auth.dart';
import 'package:NudgeBuddy/services/local_notifications.dart';
import 'package:NudgeBuddy/services/meal.dart';
import 'package:NudgeBuddy/services/tips.dart';
import 'package:NudgeBuddy/services/weight.dart';
import 'package:NudgeBuddy/utils/size_config.dart';
import 'package:NudgeBuddy/views/pages/bottom%20nav%20bar/diet%20advice/diet_advice.dart';
import 'package:NudgeBuddy/views/pages/bottom%20nav%20bar/home/home.dart';
import 'package:NudgeBuddy/views/pages/bottom%20nav%20bar/notifications/notifications.dart';
import 'package:NudgeBuddy/views/pages/bottom%20nav%20bar/profile/profile.dart';
import 'package:NudgeBuddy/views/pages/bottom%20nav%20bar/stats/stats.dart';
import 'package:NudgeBuddy/views/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';

// BOTTOM NAV BAR CLASS - USED TO SHOW THE BOTTOM NAVIGATION BAR OF THE APP THROUGHOUT THE APP
class CustomBottomNavBar extends StatefulWidget {
  CustomBottomNavBar({super.key});
  @override
  State<CustomBottomNavBar> createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  List<IconData> icons = [
    FeatherIcons.home,
    FeatherIcons.barChart,
    FeatherIcons.bell,
    FeatherIcons.bookOpen,
    FeatherIcons.user,
  ];
  List<Widget> widgets = [
    HomePage(),
    StatsPage(),
    NotificationsPage(),
    const DietAdvicePage(),
    ProfilePage()
  ];
  final authCont = Get.find<AuthController>();
  @override
  void initState() {
    super.initState();
    getUserData();
  }

  getUserData() async {
    await authCont.getUser();
    await MealService().getTakenNutrients();
    LocalNotificationsService().initializeLocalNotifications();
    await WeightService.sendSundayNotification();
    Future.delayed(const Duration(seconds: 5),
        () => TipsService.sendDailyTipNotification());
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        extendBody: true,
        body: authCont.userInfo.username == null
            ? LoadingWidget(height: SizeConfig.heightMultiplier * 100)
            : widgets.elementAt(authCont.bnbSelectedIndex.value),
        bottomNavigationBar: authCont.userInfo.username == null
            ? null
            : Container(
                height: SizeConfig.heightMultiplier * 10,
                width: SizeConfig.widthMultiplier * 100,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(color: Colors.black12, blurRadius: 10)
                    ],
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ...List.generate(
                        icons.length,
                        (index) => InkWell(
                              onTap: () =>
                                  authCont.bnbSelectedIndex.value = index,
                              child: Obx(
                                () => Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    AnimatedContainer(
                                      duration:
                                          const Duration(milliseconds: 400),
                                      height: authCont.bnbSelectedIndex.value ==
                                              index
                                          ? SizeConfig.heightMultiplier * 1
                                          : 0,
                                      width: SizeConfig.widthMultiplier * 12,
                                      decoration: BoxDecoration(
                                          color: ColorConstants.primaryColor,
                                          borderRadius: const BorderRadius.only(
                                              bottomLeft: Radius.circular(16),
                                              bottomRight:
                                                  Radius.circular(16))),
                                    ),
                                    SizedBox(
                                        height: authCont
                                                    .bnbSelectedIndex.value ==
                                                index
                                            ? 0
                                            : SizeConfig.heightMultiplier * 1),
                                    Icon(
                                      icons[index],
                                      color: authCont.bnbSelectedIndex.value ==
                                              index
                                          ? ColorConstants.primaryColor
                                          : Colors.grey.shade500,
                                    ),
                                    SizedBox(
                                        height: SizeConfig.heightMultiplier * 3)
                                  ],
                                ),
                              ),
                            ))
                  ],
                ),
              ),
      ),
    );
  }
}
