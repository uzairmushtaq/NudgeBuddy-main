import 'package:NudgeBuddy/controllers/notifications.dart';
import 'package:NudgeBuddy/services/notifications.dart';
import 'package:NudgeBuddy/utils/size_config.dart';
import 'package:NudgeBuddy/views/dialog/add_notification.dart';
import 'package:NudgeBuddy/views/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'components/tile.dart';

// RENDER THE NOTIFICATIONS PAGE
// ================================================================================================================
class NotificationsPage extends StatefulWidget {
  NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  final cont = Get.put(NotificationCont());
  @override
  void initState() {
    super.initState();
    cont.notifications
        .bindStream(NotificationService().streamForNotifications());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
        title: const Text('NOTIFICATIONS'),
        actions: [
          TextButton(
              onPressed: () => Get.dialog(AddNotificationDialog()),
              child: const Text('SET'))
        ],
      ),
      body: Obx(
        () => cont.getNotifies == null
            ? LoadingWidget(height: SizeConfig.heightMultiplier * 80)
            : cont.getNotifies!.isEmpty
                ? const Center(child: Text('No notifications set'))
                : ListView.builder(
                    itemCount: cont.getNotifies!.length,
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    padding: EdgeInsets.only(
                        left: SizeConfig.widthMultiplier * 5,
                        right: SizeConfig.widthMultiplier * 5,
                        bottom: SizeConfig.heightMultiplier * 15),
                    itemBuilder: (_, index) => NotificationTile(
                          data: cont.getNotifies![index],
                        )),
      ),
    );
  }
}
