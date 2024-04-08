import 'dart:math';

import 'package:NudgeBuddy/controllers/auth.dart';
import 'package:NudgeBuddy/controllers/notifications.dart';
import 'package:NudgeBuddy/models/notification_model.dart';
import 'package:NudgeBuddy/services/local_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:timezone/timezone.dart';

// Performs all "crud" operations related to notifications from the database
// ================================================================================================================
class NotificationService {
  static Future<void> addNotification(
      String title, String body, String scheduleTime) async {
    final cont = Get.find<NotificationCont>();
    try {
      final uid = Get.find<AuthController>().userss!.uid;
      String date = '';
      if (DateTime.parse(scheduleTime).isBefore(DateTime.now())) {
        date = DateTime.parse(scheduleTime)
            .add(const Duration(days: 1))
            .toString();
      } else {
        date = scheduleTime;
      }
      Random rand = Random();
      int notifyID = rand.nextInt(9999); //RANDOM ID FOR NOTIFICATION
      if (cont.titleCont.text.isNotEmpty && cont.bodyCont.text.isNotEmpty) {
        cont.isLoading.value = true;
        await FirebaseFirestore.instance
            .collection('Users')
            .doc(uid)
            .collection("Notifications")
            .add({
          'Title': title,
          'Body': body,
          'NotifyID': notifyID,
          'DeleteDay': [],
          'ScheduleTime': date,
          'CreatedAt': DateTime.now().toString()
        });
        //SENDING LOCAL NOTIFICATION
        await LocalNotificationsService().showNotification(
            DateTime.parse(scheduleTime), notifyID, title, body,true);
        //CLEARING VALUES
        cont.titleCont.clear();
        cont.bodyCont.clear();
        cont.selectedDate.value = DateTime.now().toString();
        cont.isLoading.value = false;
      }
    } catch (e) {
      cont.isLoading.value = false;

      //print(e);
    }
  }

  // STREAM FOR NOTIFICATIONS
  Stream<List<NotificationModel>> streamForNotifications() {
    final authCont = Get.find<AuthController>();

    return FirebaseFirestore.instance
        .collection('Users')
        .doc(authCont.userss!.uid)
        .collection('Notifications')
        .orderBy('ScheduleTime')
        .snapshots()
        .map((QuerySnapshot query) {
      List<NotificationModel> notifications = [];
      query.docs.forEach((element) {
        DateTime scheduleDate = DateTime.parse(element.get('ScheduleTime'));

        if (isPast(scheduleDate)) {
          if (scheduleDate.toString().split(' ')[0] ==
              DateTime.now().toString().split(' ')[0]) {
            List deletedDays = element.get('DeleteDay');
            if (!deletedDays
                .contains(DateTime.now().toString().split(' ')[0])) {
              print(DateTime.now().toString().split(' ')[0]);
              notifications
                  .add(NotificationModel.fromDocumentSnapshot(element));
            }
          }
        }
      });
      return notifications;
    });
  }
  //CHECKING IF THE NOTIFICATION IS PAST
  static bool isPast(DateTime scheduleDate) {
    final authCont = Get.find<AuthController>();
    DateTime nowDate =
        TZDateTime.now(getLocation(authCont.defaultTimeZone.value));

    DateTime latestDate = TZDateTime(
        getLocation(authCont.defaultTimeZone.value),
        nowDate.year,
        nowDate.month,
        nowDate.day,
        scheduleDate.hour,
        scheduleDate.minute,
        scheduleDate.second);
    bool isPast = latestDate.isBefore(nowDate);

    return isPast;
  }
  //GETTING THE LATEST DATE
  static DateTime getLatestDate(DateTime scheduleDate) {
    final authCont = Get.find<AuthController>();
    DateTime nowDate =
        TZDateTime.now(getLocation(authCont.defaultTimeZone.value));
    DateTime latestDate = TZDateTime(
        getLocation(authCont.defaultTimeZone.value),
        nowDate.year,
        nowDate.month,
        nowDate.day,
        scheduleDate.hour,
        scheduleDate.minute,
        scheduleDate.second);
    return latestDate;
  }
  // NOTIFICATION SWITCH FOR ALLOWING NOTIFICATIONS
  static Future<void> notificationSwitch(bool val) async {
    final authCont = Get.find<AuthController>();
    authCont.allowNotifications.value = val;
    final notifications = await FirebaseFirestore.instance
        .collection('Users')
        .doc(authCont.userss!.uid)
        .collection('Notifications')
        .get();
    if (val) {
      notifications.docs.forEach((element) async {
        await LocalNotificationsService().showNotification(
            DateTime.parse(element.get('ScheduleTime')),
            element.get('NotifyID'),
            element.get('Title'),
            element.get('Body'),true);
      });
    } else {
      notifications.docs.forEach((element) async {
        await LocalNotificationsService()
            .deleteNotification(element.get('NotifyID'));
      });
    }
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(authCont.userss!.uid)
        .update({'AllowNotifications': val});
    await authCont.getUser();
  }

  //DELETE A NOTIFICATION
  static Future<void> deleteNotification(NotificationModel model) async {
    final authCont = Get.find<AuthController>();

    try {
      authCont.isLoading.value = true;
      final nowDate = DateTime.now().toString().split(' ')[0];
      model.deletedDates!.add(nowDate);
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(authCont.userss!.uid)
          .collection('Notifications')
          .doc(model.id)
          .update({'DeleteDay': model.deletedDates!});
      Get.back();
      authCont.isLoading.value = false;
    } catch (e) {
      authCont.isLoading.value = false;
      print(e);
    }
  }

  //DISABLE NOTIFICATION
  static Future<void> disableNotification(NotificationModel model) async {
    final authCont = Get.find<AuthController>();
    try {
      authCont.isLoading.value = true;
      await LocalNotificationsService().deleteNotification(model.notifyID!);
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(authCont.userss!.uid)
          .collection('Notifications')
          .doc(model.id)
          .delete();
      Get.back();
      authCont.isLoading.value = false;
    } catch (e) {
      authCont.isLoading.value = false;
      print(e);
    }
  }
}
