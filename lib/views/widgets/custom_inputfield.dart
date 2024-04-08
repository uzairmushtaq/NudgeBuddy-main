import 'package:NudgeBuddy/constants/colors.dart';
import 'package:NudgeBuddy/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// CUSTOM INPUT FIELD CLASS - USED TO CREATE INPUT FIELDS THROUGHOUT THE APP
// ================================================================================================================
class CustomInputField extends StatelessWidget {
  CustomInputField({
    Key? key,
    required this.controller,
    required this.hintText,
    this.textAlign = TextAlign.center,
    this.validator,
    this.isBig = false,
    required this.keyboardType,
    this.suffixIcon,
  }) : super(key: key);
  final TextEditingController controller;
  final String hintText;
  final String? Function(String?)? validator;
  final TextAlign textAlign;
  final TextInputType keyboardType;
  final IconData? suffixIcon;
  final bool isBig;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      // textAlign: textAlign,
    obscureText: hintText=='Password'?true:false,
      validator: validator,
      keyboardType: keyboardType,
      maxLines: isBig ? 5 : 1,
      decoration: InputDecoration(
          isCollapsed: true,
          suffixIcon: suffixIcon == null ? null : Icon(suffixIcon),
          hintText: hintText,
          hintStyle: TextStyle(fontSize: SizeConfig.textMultiplier * 1.8),
          contentPadding: EdgeInsets.symmetric(
              horizontal: SizeConfig.widthMultiplier * 2,
              vertical: SizeConfig.heightMultiplier * 1.5),
          focusColor: ColorConstants.primaryColor,
          errorStyle: TextStyle(fontSize: SizeConfig.textMultiplier * 1.5),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(width: 1.5, color: Colors.red)),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(width: 1.5, color: Colors.red)),
          disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(width: 1.5, color: Colors.black)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide:
                  BorderSide(width: 1.5, color: ColorConstants.primaryColor)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(width: 1.5, color: Colors.grey))),
    );
  }
}
