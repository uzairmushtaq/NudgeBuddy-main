import 'package:NudgeBuddy/constants/meal_type.dart';
import 'package:NudgeBuddy/controllers/auth.dart';
import 'package:NudgeBuddy/controllers/meal.dart';
import 'package:NudgeBuddy/models/meal_model.dart';
import 'package:NudgeBuddy/services/nutrients.dart';
import 'package:NudgeBuddy/views/widgets/custom_snackbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

// Performs all "crud" operations related to meals
// ================================================================================================================
class MealService {
  //ADD MEAL
  Future<void> addMeal(MealModel meal) async {
    final authCont = Get.find<AuthController>();
    final mealCont = Get.find<MealCont>();

    try {
      authCont.isLoading.value = true;
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(authCont.userss!.uid)
          .collection("Meals")
          .add({
        'Title': meal.title,
        'Quantity': meal.quantity,
        'Type': meal.type,
        'Carbs': meal.carbs,
        'Protein': meal.proteins,
        'Fats': meal.fats,
        'Kcal': NutrientService.calculatKCAL(
            meal.fats!.toInt(), meal.carbs!.toInt(), meal.proteins!.toInt()),
        'CreatedAt': mealCont.selectedDate.value.split(' ')[0],
      });
      await getTakenNutrients();
      //await NutrientService.addKcalDatainFirebase(
      CustomSnackbar.showCustomSnackbar(false,
          'Well done on making time to nourish your body with a satisfying ${meal.type}. Keep up the healthy habits!');
      authCont.isLoading.value = false;
    } catch (e) {
      authCont.isLoading.value = false;
      print(e);
    }
  }

  //GET TOTAL MEALS TRACKED TODAY

  static Future<QuerySnapshot?> getAllMeals() async {
    try {
      final uid = Get.find<AuthController>().userss!.uid;

      final cont = Get.find<MealCont>();
      final data = await FirebaseFirestore.instance
          .collection('Users')
          .doc(uid)
          .collection("Meals")
          .where('CreatedAt', isEqualTo: cont.selectedDate.value)
          .get();
      cont.breakFast.value = [];
      cont.lunch.value = [];
      cont.dinner.value = [];
      cont.other.value = [];
      cont.breakFastKCAL.value = 0;
      cont.lunchKCAL.value = 0;
      cont.dinnerKCAL.value = 0;
      cont.otherKCAL.value = 0;

      //ADDING DATA TO THE OBSERVABLE LIST
      for (int i = 0; i < data.docs.length; i++) {
        num quantity = num.parse(data.docs[i].get('Quantity'));
        String type = data.docs[i].get('Type');
        if (type == MealType.breakFast) {
          cont.breakFastKCAL.value +=
              (data.docs[i].get('Kcal') * quantity) as int;
          cont.breakFast.value!
              .add(MealModel.fromDocumentSnapshot(data.docs[i]));
        }
        if (type == MealType.lunch) {
          cont.lunchKCAL.value += (data.docs[i].get('Kcal') * quantity) as int;
          cont.lunch.value!.add(MealModel.fromDocumentSnapshot(data.docs[i]));
        }
        if (type == MealType.dinner) {
          cont.dinnerKCAL.value += (data.docs[i].get('Kcal') * quantity) as int ;
          cont.dinner.value!.add(MealModel.fromDocumentSnapshot(data.docs[i]));
        }
        if (type == MealType.other) {
          cont.otherKCAL.value += (data.docs[i].get('Kcal') * quantity) as int ;
          cont.other.value!.add(MealModel.fromDocumentSnapshot(data.docs[i]));
        }
      }
      return data;
    } catch (e) {
      //print(e);
      return null;
    }
  }

  //GET TOTAL NUTRITIONAL VALUES TRACKED TODAY
  Future<void> getTakenNutrients() async {
    final cont = Get.find<MealCont>();
    final meals = await getAllMeals();
    cont.takenCarbs.value = 0;
    cont.takenFats.value = 0;
    cont.takenKcal.value = 0;
    cont.takenProtein.value = 0;

    for (int i = 0; i < meals!.docs.length; i++) {
      cont.takenProtein.value +=
          (num.parse(meals.docs[i].get('Protein').toString()) *
                  num.parse(meals.docs[i].get('Quantity')))
              .toInt();
      cont.takenCarbs.value +=
          (num.parse(meals.docs[i].get('Carbs').toString()) *
                  num.parse(meals.docs[i].get('Quantity')))
              .toInt();
      cont.takenFats.value += (num.parse(meals.docs[i].get('Fats').toString()) *
              num.parse(meals.docs[i].get('Quantity')))
          .toInt();
      cont.takenKcal.value += (num.parse(meals.docs[i].get('Kcal').toString()) *
              num.parse(meals.docs[i].get('Quantity')))
          .toInt();
    }
    await NutrientService.addKcalDatainFirebase(cont.takenKcal.value);
  }

  //DELETE A MEAL
  Future<void> deleteMeal(String id) async {
    final authCont = Get.find<AuthController>();
    try {
      authCont.isLoading.value = true;
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(authCont.userss!.uid)
          .collection("Meals")
          .doc(id)
          .delete();
      await getAllMeals();
      await getTakenNutrients();
      Get.back();
      authCont.isLoading.value = false;
    } catch (e) {
      print(e);
      authCont.isLoading.value = false;
    }
  }

  //EDIT MEAL
  Future<void> editMeal(MealModel meal) async {
    final authCont = Get.find<AuthController>();
    final mealCont = Get.find<MealCont>();
    try {
      authCont.isLoading.value = true;
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(authCont.userss!.uid)
          .collection("Meals")
          .doc(meal.id)
          .update({
        'Title': meal.title,
        'Quantity': meal.quantity,
        'Type': meal.type,
        'Carbs': meal.carbs,
        'Protein': meal.proteins,
        'Fats': meal.fats,
        'Kcal': NutrientService.calculatKCAL(
            meal.fats!.toInt(), meal.carbs!.toInt(), meal.proteins!.toInt()),
        'CreatedAt': mealCont.selectedDate.value.split(' ')[0],
      });
      await getTakenNutrients();
      authCont.isLoading.value = false;
    } catch (e) {
      authCont.isLoading.value = false;
    }
  }
}
