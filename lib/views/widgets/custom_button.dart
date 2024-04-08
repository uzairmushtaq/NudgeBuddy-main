import 'package:NudgeBuddy/constants/colors.dart';
import 'package:NudgeBuddy/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'loading.dart';

// RENDERS A CUSTOM BUTTON USED THROUGHOUT THE APP -
// ================================================================================================================
class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.onTap,
    required this.text,
    required this.width,
    this.loading = false,
    this.grey = false,
  }) : super(key: key);
  final VoidCallback onTap;
  final String text;
  final double width;
  final bool loading;
  final bool grey;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
            backgroundColor: grey ? Colors.grey.shade300 : ColorConstants.primaryColor,
            disabledBackgroundColor:
                ColorConstants.primaryColor.withOpacity(0.3),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10))),
        child: SizedBox(
          height: SizeConfig.heightMultiplier * 5.5,
          width: width,
          child: loading
              ? LoadingWidget(
                  height: SizeConfig.heightMultiplier * 4, isButton: true)
              : Center(
                  child: Text(
                    text.toUpperCase(),
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: grey ? Colors.black : Colors.white,
                        fontSize: SizeConfig.textMultiplier * 2),
                  ),
                ),
        ));
  }
}
