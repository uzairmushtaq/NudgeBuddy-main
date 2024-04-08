import 'package:NudgeBuddy/models/diet_advice.dart';
import 'package:NudgeBuddy/utils/size_config.dart';
import 'package:NudgeBuddy/views/pages/diet%20detail/diet_detail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// RENDERS THE DIET ADVICE TILES - DIFFERENT POSTS
// ================================================================================================================
class DietAdviceTile extends StatelessWidget {
  const DietAdviceTile({
    Key? key,
    required this.i,
  }) : super(key: key);
  final int i;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.to(() => DietDetailPage(data: dietAvices[i])),
      child: Container(
        width: SizeConfig.widthMultiplier * 90,
        margin: EdgeInsets.only(bottom: SizeConfig.heightMultiplier * 2),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [BoxShadow(color: Colors.grey.shade300, blurRadius: 6)]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //IMAGE
            Hero(
              tag: dietAvices[i].title,
              child: Container(
                height: SizeConfig.heightMultiplier * 20,
                width: SizeConfig.widthMultiplier * 90,
                decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    image: DecorationImage(
                        image: AssetImage(dietAvices[i].image),
                        fit: BoxFit.cover),
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
              ),
            ),
            SizedBox(height: SizeConfig.heightMultiplier * 2),
            //NAME
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.widthMultiplier * 5),
              child: Text(
                dietAvices[i].title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: SizeConfig.textMultiplier * 2),
              ),
            ),
            SizedBox(height: SizeConfig.heightMultiplier * 1),
            //DESCRIPTION
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.widthMultiplier * 5),
              child: Text(
                dietAvices[i].desciption,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: SizeConfig.textMultiplier * 1.8,
                    color: Colors.grey),
              ),
            ),
            SizedBox(height: SizeConfig.heightMultiplier * 3),
          ],
        ),
      ),
    );
  }
}
