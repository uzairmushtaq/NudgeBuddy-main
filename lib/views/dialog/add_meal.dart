import 'package:NudgeBuddy/constants/colors.dart';
import 'package:NudgeBuddy/constants/meal_type.dart';
import 'package:NudgeBuddy/controllers/auth.dart';
import 'package:NudgeBuddy/controllers/meal.dart';
import 'package:NudgeBuddy/models/meal_model.dart';
import 'package:NudgeBuddy/services/meal.dart';
import 'package:NudgeBuddy/utils/size_config.dart';
import 'package:NudgeBuddy/views/widgets/custom_button.dart';
import 'package:NudgeBuddy/views/widgets/custom_inputfield.dart';
import 'package:NudgeBuddy/views/widgets/custom_snackbar.dart';
import 'package:NudgeBuddy/views/widgets/show_loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// CHECKS IF THE USER IS EDITING AN EXISTING MEAL OR ADDING A NEW MEAL. THEN DISPLAYS THE APPROPRIATE DIALOG BOX
// ================================================================================================================
class AddMealDialog extends StatefulWidget {
  AddMealDialog({super.key, required this.isEdit, this.meal});
  final bool isEdit;
  final MealModel? meal;

  @override
  State<AddMealDialog> createState() => _AddMealDialogState();
}
// Creates the dialog box that will be displayed on the screen to track new food instances
class _AddMealDialogState extends State<AddMealDialog> {
  TextEditingController title = TextEditingController();
  TextEditingController quantity = TextEditingController();
  TextEditingController carbs = TextEditingController();
  TextEditingController protein = TextEditingController();
  TextEditingController fats = TextEditingController();

  final cont = Get.find<MealCont>();

  @override
  void initState() {
    super.initState();
    if(widget.isEdit){ // If the user is editing an existing meal, the dialog box will be pre-filled with the existing data
      title.text=widget.meal!.title!;
      quantity.text=widget.meal!.quantity!;
      carbs.text=widget.meal!.carbs!.toString();
      protein.text=widget.meal!.proteins!.toString();
      fats.text=widget.meal!.fats!.toString();
      cont.selectedMealType.value=widget.meal!.type!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
          color: Colors.transparent,
          child: Obx(
            () => ShowLoading(
              inAsyncCall: Get.find<AuthController>().isLoading.value,
              child: Center(
                child: Container(
                  height: SizeConfig.heightMultiplier * 60,
                  width: SizeConfig.widthMultiplier * 85,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12)),
                  padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.widthMultiplier * 4,
                      vertical: SizeConfig.heightMultiplier * 2),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(width: SizeConfig.widthMultiplier * 6),
                          Text(
                            'Your Meal',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: SizeConfig.textMultiplier * 2),
                          ),
                          InkWell(
                              onTap: () => Get.back(),
                              child: const Icon(Icons.cancel_outlined))
                        ],
                      ),
                      SizedBox(height: SizeConfig.heightMultiplier * 2),
                      CustomInputField(
                        controller: title,
                        hintText: 'Title',
                        keyboardType: TextInputType.text,
                      ),
                      SizedBox(height: SizeConfig.heightMultiplier * 1),
                      CustomInputField(
                        controller: quantity,
                        hintText: 'Quantity',
                        keyboardType: TextInputType.text,
                      ),
                     
                      SizedBox(height: SizeConfig.heightMultiplier * 1),
                      CustomInputField(
                        controller: carbs,
                        hintText: 'Carbs',
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(height: SizeConfig.heightMultiplier * 1),
                      CustomInputField(
                        controller: protein,
                        hintText: 'Protein',
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(height: SizeConfig.heightMultiplier * 1),
                      CustomInputField(
                        controller: fats,
                        hintText: 'Fats',
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      ),

                      ChooseMealType(),
                      SizedBox(height: SizeConfig.heightMultiplier * 3),
                      CustomButton(
                          onTap: () => _onSave(),
                          text: 'Save',
                          width: SizeConfig.widthMultiplier * 80),
                    ],
                  ),
                ),
              ),
            ),
          )),
    );
  }
   //Save meal logic
  _onSave() async {
    if (_validate()) {
      MealModel meal = MealModel(
          id: widget.meal?.id??'',
          carbs: num.parse(carbs.text),
          createdAt: DateTime.now().toString().split(' ')[0],
          fats: num.parse(fats.text),
          type: cont.selectedMealType.value,
          proteins: num.parse(protein.text),
          quantity: quantity.text,
          title: title.text);
      if(widget.isEdit){
        await MealService().editMeal(meal);
      }else{
        await MealService().addMeal(meal);
      _clearingValues();
      }
    } else {
      CustomSnackbar.showCustomSnackbar(true, 'Provide all accurate data'); // Displays a snackbar if the input fields are not valid
    }
  }
  
  // Validates the input fields
  bool _validate() {
    return title.text.isNotEmpty &&
        quantity.text.isNum &&
        carbs.text.isNum &&
        protein.text.isNum &&
        fats.text.isNum &&
        cont.selectedMealType.value != '';
  }

// Clears the values after saving
  _clearingValues() {
    cont.selectedMealType.value = '';
    title.clear();
    quantity.clear();
    carbs.clear();
    protein.clear();
    fats.clear();
  }
}

// Selecting the meal type
class ChooseMealType extends StatelessWidget {
  ChooseMealType({
    Key? key,
  }) : super(key: key);
  final cont = Get.find<MealCont>();
  List<String> types = [
    MealType.breakFast,
    MealType.lunch,
    MealType.dinner,
    MealType.other,
  ];
  @override
  Widget build(BuildContext context) { // Builds the widget that displays the meal types
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Wrap(
            children: [
              ...List.generate(
                types.length,
                (index) => GestureDetector(
                  onTap: () => cont.selectedMealType.value = types[index],
                  child: Obx(
                    () => AnimatedContainer(
                      duration: const Duration(milliseconds: 400),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: cont.selectedMealType.value == types[index]
                            ? ColorConstants.primaryColor
                            : ColorConstants.primaryColor.withOpacity(0.2),
                      ),
                      margin: EdgeInsets.only(
                          top: SizeConfig.heightMultiplier * 1,
                          right: SizeConfig.widthMultiplier * 1),
                      padding: EdgeInsets.only(
                          bottom: SizeConfig.heightMultiplier * 0.5,
                          top: SizeConfig.heightMultiplier * 0.5,
                          right: SizeConfig.widthMultiplier * 3,
                          left: SizeConfig.widthMultiplier * 3),
                      child: Text(
                        types[index],
                        style: TextStyle(
                            color: cont.selectedMealType.value == types[index]
                                ? Colors.white
                                : Colors.black),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
