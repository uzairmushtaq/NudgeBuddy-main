import 'package:NudgeBuddy/constants/colors.dart';
import 'package:NudgeBuddy/constants/units.dart';
import 'package:NudgeBuddy/controllers/auth.dart';
import 'package:NudgeBuddy/models/user_model.dart';
import 'package:NudgeBuddy/utils/size_config.dart';
import 'package:NudgeBuddy/views/widgets/num_slider.dart';
import 'package:NudgeBuddy/views/widgets/custom_inputfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'components/gender_selection.dart';
import 'components/select_num.dart';

// RENDERS THE PAGE WHERE THE USER ENTERS THEIR PERSONAL INFORMATION PART OF THE ONBOARDING PROCESS
// ================================================================================================================
class PersonalInfo extends StatelessWidget {
  PersonalInfo({super.key});
  final cont = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: SizeConfig.widthMultiplier * 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomInputField(
                controller: cont.username,
                hintText: 'Username',
                suffixIcon: Icons.person,
                keyboardType: TextInputType.name),
            SizedBox(height: SizeConfig.heightMultiplier * 2),
            CustomInputField(
                controller: cont.email,
                hintText: 'Email',
                suffixIcon: Icons.email,
                keyboardType: TextInputType.emailAddress),
            SizedBox(height: SizeConfig.heightMultiplier * 2),
            CustomInputField(
                controller: cont.password,
                hintText: 'Password',
                suffixIcon: Icons.lock,
                keyboardType: TextInputType.text),
            //GENDER SELECTION
            GenderSelection(),
            //AGE SELECTION
            Obx(
              () => SelectNumVal(
                title: 'Age',
                value: cont.age.value,
                unit: 'years',
                onTap: () => showModalBottomSheet(
                    backgroundColor: Colors.transparent,
                    context: context,
                    builder: (_) =>
                        NumSlider(isWeight: true, isEdit: false, isAge: true)),
              ),
            ),
            SizedBox(height: SizeConfig.heightMultiplier * 2),
            //SELECT WEIGHT
            Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SelectNumVal(
                    title: 'Weight',
                    value: cont.weightVal.value,
                    unit: 'Kg',
                    onTap: () => showModalBottomSheet(
                        backgroundColor: Colors.transparent,
                        context: context,
                        builder: (_) =>
                            NumSlider(isWeight: true, isEdit: false)),
                  ),
                  SelectNumVal(
                    title: 'Height',
                    value: cont.heightUnit.value == UnitConstants.centimeter
                        ? cont.heightFeetVal.value
                        : cont.heightFeetVal.value +
                            cont.heightInchesVal.value * 0.1,
                    unit: cont.heightUnit.value == UnitConstants.centimeter
                        ? 'cm'
                        : 'feet',
                    onTap: () {
                      showModalBottomSheet(
                          backgroundColor: Colors.transparent,
                          context: context,
                          builder: (_) => NumSlider(
                                isWeight: false,
                                isEdit: false,
                              ));
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: SizeConfig.heightMultiplier * 2),
            Center(
              child: Text(
                'This data is necessary to give you accurate results',
                style: TextStyle(
                    fontSize: SizeConfig.textMultiplier * 1.5,
                    color: Colors.grey.shade600),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
