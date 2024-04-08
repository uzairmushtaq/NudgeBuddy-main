import 'package:NudgeBuddy/models/meal_model.dart';
import 'package:get/state_manager.dart';

// STORES DATA FOR THE MEAL SCREEN
// ===========================================================================================
class MealCont extends GetxController {
  RxString selectedMealType = ''.obs;
  RxString selectedDate=DateTime.now().toString().split(' ')[0].obs;
  RxInt takenProtein = 0.obs;
  RxInt takenCarbs = 0.obs;
  RxInt takenFats = 0.obs;
  RxInt takenKcal = 0.obs;
  RxInt breakFastKCAL = 0.obs;
  RxInt lunchKCAL = 0.obs;
  RxInt dinnerKCAL = 0.obs;
  RxInt otherKCAL = 0.obs;

  final Rxn<List<MealModel>> breakFast = Rxn<List<MealModel>>();
  List<MealModel>? get getBreakFast => breakFast.value;
  final Rxn<List<MealModel>> lunch = Rxn<List<MealModel>>();
  List<MealModel>? get getLunch => lunch.value;
  final Rxn<List<MealModel>> dinner = Rxn<List<MealModel>>();
  List<MealModel>? get getDinner => dinner.value;
  final Rxn<List<MealModel>> other = Rxn<List<MealModel>>();
  List<MealModel>? get getOther => other.value;
  
}
