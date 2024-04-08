import 'package:NudgeBuddy/constants/colors.dart';
import 'package:NudgeBuddy/models/notification_model.dart';
import 'package:NudgeBuddy/services/notifications.dart';
import 'package:NudgeBuddy/utils/size_config.dart';
import 'package:NudgeBuddy/views/widgets/confirmation_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timeago/timeago.dart' as timeago;

// RENDERS THE NOTIFICATION TILE THAT IS DISPLAYED IN THE NOTIFICATIONS PAGE
// ================================================================================================================
class NotificationTile extends StatelessWidget {
  const NotificationTile({
    Key? key,
    required this.data,
  }) : super(key: key);

  final NotificationModel data;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          // height: SizeConfig.heightMultiplier * 10,
          width: SizeConfig.widthMultiplier * 90,
          decoration: BoxDecoration(
              color: ColorConstants.primaryColor.withOpacity(0.3),
              borderRadius: BorderRadius.circular(16)),
          margin: EdgeInsets.only(bottom: SizeConfig.heightMultiplier * 2),
          child: Row(children: [
            SizedBox(width: SizeConfig.widthMultiplier * 5),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(height: SizeConfig.heightMultiplier * 2),
                  Text(
                    '${data.title} !',
                    style: TextStyle(
                        fontSize: SizeConfig.textMultiplier * 2,
                        fontWeight: FontWeight.w500),
                  ),
                  Text(
                    '${data.body}',
                    style: TextStyle(
                        fontSize: SizeConfig.textMultiplier * 1.6,
                        color: Colors.grey.shade600),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      '${timeago.format(NotificationService.getLatestDate(DateTime.parse(data.scheduleTime!)))}    ',
                      style: TextStyle(
                          fontSize: SizeConfig.textMultiplier * 1.4,
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 1,
                  )
                ],
              ),
            )
          ]),
        ),
        Positioned(
          right: 0,
          child: PopupMenuButton(
            icon: const Icon(Icons.more_horiz),
            itemBuilder: (_) => const [
              PopupMenuItem(
                value: 0,
                child: Text('Delete'),
              ),
              PopupMenuItem(
                value: 1,
                child: Text('Disable'),
              ),
            ],
            onSelected: (val) {
              if (val == 0) {
                //DELETE
                Get.dialog(ConfirmationDialog(
                    text: 'Are you sure you want to delete the notification?',
                    onConfirm: () =>
                        NotificationService.deleteNotification(data)));
              }
              if (val == 1) {
                //DISABLE
                Get.dialog(ConfirmationDialog(
                    text: 'Are you sure you want to disable the notification?',
                    onConfirm: () =>
                        NotificationService.disableNotification(data)));
              }
            },
          ),
        )
      ],
    );
  }
}
