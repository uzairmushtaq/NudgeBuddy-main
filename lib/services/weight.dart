import 'package:NudgeBuddy/controllers/auth.dart';
import 'package:NudgeBuddy/services/local_notifications.dart';
import 'package:NudgeBuddy/services/stats.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../controllers/stats.dart';

// MANAGES CRUD OPERATIONS RELATED TO WEIGHT - USED ALONG WITH LOCAL NOTIFICATIONS TO REMIND THE USER TO WEIGH THEMSELVES
// ================================================================================================================
class WeightService {
  static Future<void> addGoalWeight(int weight) async {
    final authCont = Get.find<AuthController>();
    try {
      final nowDate = Get.find<StatsCont>().selectedDate.value.split(' ')[0];
      authCont.isLoading.value = true;

      await FirebaseFirestore.instance
          .collection('Users')
          .doc(authCont.userss!.uid)
          .collection('Weight')
          .doc(nowDate.split(' ')[0])
          .set({'CreatedAt': nowDate, 'Value': weight});
      await StatsService.getWeights();
      Get.back();
      authCont.isLoading.value = false;
    } catch (e) {
      authCont.isLoading.value = false;
    }
  }

  //FOR NOTIFICATION
  static Future<void> sendSundayNotification() async {
    try {
      LocalNotificationsService().showNotification(
          DateTime.utc(2023, 04, 16,0,18,0),
          98,
          'Weight Tracker',
          "Hey 👋, remember to weigh yourself today, if you haven't yet",
          true);
    } catch (e) {
      print(e);
    }
  }
}
