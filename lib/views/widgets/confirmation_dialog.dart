import 'package:NudgeBuddy/controllers/auth.dart';
import 'package:NudgeBuddy/utils/size_config.dart';
import 'package:NudgeBuddy/views/widgets/show_loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// CONFIRMATION DIALOG CLASS - USED TO SHOW A CONFIRMATION DIALOG TO THE USER - ALLOWS TO CONFIRM/GO BACK 
// ================================================================================================================
class ConfirmationDialog extends GetWidget<AuthController> {
  const ConfirmationDialog({
    Key? key,
    required this.text,
    this.isNote = false,
    this.note = '',
    required this.onConfirm,
  }) : super(key: key);
  final String text;
  final VoidCallback onConfirm;
  final bool isNote;
  final String note;
  @override
  Widget build(BuildContext context) {
    return MediaQuery(
       data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Obx(
        () => Material(
            color: Colors.transparent,
            child: Center(
              child: Container(
                height: isNote
                    ? SizeConfig.heightMultiplier * 19
                    : SizeConfig.heightMultiplier * 16,
                width: SizeConfig.widthMultiplier * 80,
                decoration: BoxDecoration(
                    color: Colors.white, borderRadius: BorderRadius.circular(8)),
                child: controller.isLoading.value
                    ? const ShowLoading(
                        inAsyncCall: true,
                        opacity: 0,
                        child: SizedBox(),
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: SizeConfig.widthMultiplier * 81,
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: SizeConfig.widthMultiplier * 3,
                                  right: SizeConfig.widthMultiplier * 3,
                                  top: SizeConfig.heightMultiplier * 2),
                              child: Column(
                                children: [
                                  Text(
                                    text,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(
                                            fontSize:
                                                SizeConfig.textMultiplier * 1.7),
                                  ),
                                  SizedBox(
                                      height: SizeConfig.heightMultiplier * 1),
                                  isNote
                                      ? Text('"$note"',
                                          style: Theme.of(context)
                                              .textTheme
                                              .caption!
                                              .copyWith(
                                                  fontSize:
                                                      SizeConfig.textMultiplier *
                                                          1.3))
                                      : const SizedBox(),
                                ],
                              ),
                            ),
                          ),
                          const Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                  onPressed: () => Get.back(),
                                  child: const Text(
                                    'Go back',
                                    style: TextStyle(color: Colors.redAccent),
                                  )),
                              TextButton(
                                  onPressed: onConfirm,
                                  child: const Text('Confirm')),
                              SizedBox(
                                width: SizeConfig.widthMultiplier * 2,
                              )
                            ],
                          )
                        ],
                      ),
              ),
            )),
      ),
    );
  }
}
