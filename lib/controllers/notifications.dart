import 'package:NudgeBuddy/models/notification_model.dart';
import 'package:NudgeBuddy/services/notifications.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

// STORES DATA FOR THE NOTIFICATIONS SCREEN
// ===========================================================================================
class NotificationCont extends GetxController {
  RxBool isLoading = false.obs;
  TextEditingController titleCont = TextEditingController();
  TextEditingController bodyCont = TextEditingController();
  RxString selectedDate = DateTime.now().toString().obs;
  Rxn<List<NotificationModel>> notifications = Rxn<List<NotificationModel>>();
  List<NotificationModel>? get getNotifies => notifications.value;
 
}
