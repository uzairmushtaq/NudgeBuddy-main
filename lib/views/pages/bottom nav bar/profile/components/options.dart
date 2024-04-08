import 'package:NudgeBuddy/constants/colors.dart';
import 'package:NudgeBuddy/utils/size_config.dart';
import 'package:flutter/material.dart';

// PROFILE OPTIONS CLASS - USED TO SHOW THE OPTIONS IN THE PROFILE PAGE - NAME, EMAIL
// ================================================================================================================
class ProfileOptions extends StatelessWidget {
  const ProfileOptions({
    Key? key,
    required this.title,
    required this.onTap, required this.subtitle,
  }) : super(key: key);
  final String title,subtitle;
 
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.widthMultiplier * 100,
      margin: EdgeInsets.symmetric(horizontal: SizeConfig.widthMultiplier*5),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
         
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                        fontSize: SizeConfig.textMultiplier * 1.8,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(
                        fontSize: SizeConfig.textMultiplier * 1.8,
                        color: Colors.grey.shade400,
                        fontWeight: FontWeight.w600),
                  )
                ],
              ),
              const Spacer(),
              title == "Email"
                  ? const SizedBox()
                  : InkWell(
                      onTap: onTap,
                      child: SizedBox(
                        height: SizeConfig.heightMultiplier * 4,
                        width: SizeConfig.widthMultiplier * 10,
                        child: Center(
                            child: Icon(
                          Icons.edit,
                          color: ColorConstants.primaryColor,
                          size: SizeConfig.heightMultiplier * 2.2,
                        )),
                      ),
                    )
            ],
          ),
          
           title == "Name"
              ? const SizedBox()
              : Divider(
                  color: Colors.grey.shade200,
                  thickness: 1, 
                  height: SizeConfig.heightMultiplier * 4,
                ),
        ],
      ),
    );
  }
}