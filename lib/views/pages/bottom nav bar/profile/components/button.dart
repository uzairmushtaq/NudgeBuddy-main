import 'package:NudgeBuddy/constants/colors.dart';
import 'package:NudgeBuddy/utils/size_config.dart';
import 'package:flutter/material.dart';

// CUSTOM PROFILE BUTTON CLASS - RENDERS A CUSTOM BUTTON WITH A TEXT AND AN ARROW ICON
// ================================================================================================================
class CustomProfileButton extends StatelessWidget {
  const CustomProfileButton({
    Key? key,
    required this.text,
    required this.onTap,
  }) : super(key: key);
  final String text;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        height: SizeConfig.heightMultiplier * 7,
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: SizeConfig.widthMultiplier * 5),
          child: Column(
            children: [
              SizedBox(height: SizeConfig.heightMultiplier * 0.5),
              Row(
                children: [
                  Text(
                    text,
                    style: TextStyle(
                        fontSize: SizeConfig.textMultiplier * 1.8,
                        fontWeight: FontWeight.w600),
                  ),
                  const Spacer(),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 18,
                    color: ColorConstants.primaryColor,
                  )
                ],
              ),
              const Spacer(),
              Divider(
                color: Colors.grey.shade300,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
