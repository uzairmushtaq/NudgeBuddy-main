import 'dart:math';

import 'package:NudgeBuddy/constants/tips.dart';
import 'package:NudgeBuddy/services/local_notifications.dart';

// RANDOMLY SELECTS A TIP FROM THE TIPS DATA AND SENDS A NOTIFICATION TO THE USER WHEN APP IS OPENED
// ================================================================================================================
class TipsService {
  static sendDailyTipNotification() {
    Random rand = Random();
      LocalNotificationsService().showNotification(
          DateTime.now().add(const Duration(seconds: 10)),
          99,
          '🫶 Daily Nutrition Tip',
          tipsData[rand.nextInt(24)],
          false).then((value) => print('TIP NOTIFICATION WILL COME'));
    
  }
  
}
