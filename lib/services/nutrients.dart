import 'package:NudgeBuddy/constants/units.dart';
import 'package:NudgeBuddy/controllers/auth.dart';
import 'package:NudgeBuddy/controllers/meal.dart';
import 'package:NudgeBuddy/controllers/stats.dart';
import 'package:NudgeBuddy/views/pages/bottom%20nav%20bar/stats/components/chart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

// Allows to calculate user TDEE and macros based on selected weight goal
//========================================================
class NutrientService {
  //BMR
  static num getBMR() {
    final authCont = Get.find<AuthController>();
    num weight = authCont.userInfo.weight!;
    num height = authCont.userInfo.height!;
    int age = authCont.userInfo.age!;
    num bmr = 0;
    if (authCont.userInfo.weightUnit == UnitConstants.pounds) {
      //CONVERTING POUNDS INTO KGS
      weight = weight * 0.4;
    }
    if (authCont.userInfo.heightUnit == UnitConstants.feet) {
      //CONVERTING FEETS INTO CM
      height = height * 30.48;
    }

    if (authCont.userInfo.genderIndex == 0) {
      bmr = (10 * weight) + (6.25 * height) - (5 * age) + 5;
    } else {
      bmr = (10 * weight) + (6.25 * height) - (5 * age) - 161;
    }
    //print('BMR $bmr');
    return bmr;
  }

  //GET PAL
  double getPAL() {
    final index = Get.find<AuthController>().userInfo.activityLevelIndex;
    if (index == 0) {
      return 1.2;
    }
    if (index == 1) {
      return 1.375;
    }
    if (index == 2) {
      return 1.55;
    } else {
      return 1.725;
    }
  }

  //GET TDEE
  int getTDEE() {
    //print('TDEE ${(getBMR() * getPAL()).toInt()}');
    return (getBMR() * getPAL()).toInt();
  }

  //GET GOAL CALORIES
  int goalkcal() {
    int index = Get.find<AuthController>().userInfo.goalIndex!;
    int tDEE = getTDEE();

    if (index == 0) {
      return tDEE + 500;
    }
    if (index == 1) {
      return tDEE - 500;
    } else {
      return tDEE;
    }
  }

  //GET GOAL PROTEIN

  int getGoalProtein() {
    int index = Get.find<AuthController>().userInfo.goalIndex!;

    if (index == 0) {
      return (getTDEE() * 0.3) ~/ 4;
    }
    if (index == 1) {
      return (getTDEE() * 0.4) ~/ 4;
    } else {
      return (getTDEE() * 0.3) ~/ 4;
    }
  }

  //GET CARBS
  int getGoalCrabs() {
    int index = Get.find<AuthController>().userInfo.goalIndex!;

    if (index == 0) {
      return (getTDEE() * 0.45) ~/ 4;
    }
    if (index == 1) {
      return (getTDEE() * 0.3) ~/ 4;
    } else {
      return (getTDEE() * 0.4) ~/ 4;
    }
  }

  //GET FATS
  int getGoalFats() {
    int index = Get.find<AuthController>().userInfo.goalIndex!;

    if (index == 0) {
      return (getTDEE() * 0.25) ~/ 9;
    }
    if (index == 1) {
      return (getTDEE() * 0.3) ~/ 9;
    } else {
      return (getTDEE() * 0.3) ~/ 9;
    }
  }

  //CALCULATE KCAL OF A MEAL
  static int calculatKCAL(int fats, int carbs, int protein) {
    return (9 * fats) + (4 * carbs) + (4 * protein);
  }

  //SAVE KCAL IN FIREBASE
  static addKcalDatainFirebase(int val) async {
    try {
      final uid = Get.find<AuthController>().userss!.uid;
      final mealCont = Get.find<MealCont>();
      final nowDate = mealCont.selectedDate.value.split(' ') [0];
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(uid)
          .collection('Kcal')
          .doc(nowDate)
          .set({'Value': val, 'CreatedAt': mealCont.selectedDate.value});
      await getLastFourDaysKcal();
    } catch (e) {
      print(e);
    }
  }

  //GET LAST 4 DAYS KCAL
  static Future<void> getLastFourDaysKcal() async { // This function returns last 4 days kcal values
    final authCont = Get.find<AuthController>();
    try {
      authCont.homeTableKcalList.value=[];
      for (int i = 0; i < getLastFourDays().length; i++) {

        final data = await FirebaseFirestore.instance
            .collection('Users')
            .doc(authCont.userss!.uid)
            .collection('Kcal')
            .doc(getLastFourDays()[i])
            .get();
        print(getLastFourDays()[i]);
        if (data.exists) {
         print( data.get('CreatedAt'));
          Map kcalData = {
            'Date': data.get('CreatedAt'),
            'Value': data.get('Value')
          };
          authCont.homeTableKcalList.add(kcalData);
        }else{
          Map kcalData = {
            'Date':getLastFourDays()[i],
            'Value': 0
          };
          authCont.homeTableKcalList.add(kcalData);
        }
      }
    } catch (e) {
      print(e);
    }
  }


 static List<String> getLastFourDays() { // This function returns last 4 days
    List<String> lastFourDates = [];
    DateTime today = DateTime.now();
    for (int i = 0; i <= 3; i++) {
      if (i == 0) {
        lastFourDates.add(today.toString().split(' ')[0]);
      } else {
        DateTime date = today.subtract(Duration(days: i));
        lastFourDates.add(date.toString().split(' ')[0]);
      }
    }
    print(lastFourDates);
    return lastFourDates;
  }
}
