import 'package:NudgeBuddy/controllers/auth.dart';
import 'package:NudgeBuddy/controllers/stats.dart';
import 'package:NudgeBuddy/views/pages/bottom%20nav%20bar/stats/components/chart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

// Stats Service allows to get consumed calories and macros for the selected month
// ================================================================================================================
class StatsService {
  //GET FIRST AND LAST DATE OF MONTH
  static List<DateTime> getFirstAndLastDatesOfMonth(DateTime inputDate) {
    DateTime firstDateOfMonth = DateTime(inputDate.year, inputDate.month, 1);
    DateTime lastDateOfMonth = DateTime(inputDate.year, inputDate.month + 1, 0);
    return [firstDateOfMonth, lastDateOfMonth];
  }

  //GET CONSUMED KCAL
  static Future<void> getConsumedKcal() async {
    try {
      final cont = Get.find<StatsCont>();
      final uid = Get.find<AuthController>().userss!.uid;
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(uid)
          .collection('Kcal')
          .where('CreatedAt',
              isGreaterThanOrEqualTo: getFirstAndLastDatesOfMonth(
                      DateTime.parse(cont.selectedDate.value))[0]
                  .toString())
          .where('CreatedAt',
              isLessThanOrEqualTo: getFirstAndLastDatesOfMonth(
                      DateTime.parse(cont.selectedDate.value))[1]
                  .toString())
          .get()
          .then((value) {
        List kcalValues = [];

        cont.calories.value = [];
        value.docs.forEach((element) {
          kcalValues.add(element.get('Value'));
          cont.calories.value!.add(ChartSampleData(
              DateTime.parse(element.get('CreatedAt')).day,
              element.get('Value')));
        });
        int highestValue = kcalValues
            .reduce((value, element) => value > element ? value : element);
        cont.highestKcalVal.value = (highestValue * 1.2).toInt();
        print(cont.calories.value!.length);
      });
    } catch (e) {
      print(e);
    }
  }

  //GET WEIGHTS OF GOAL
  static Future<void> getWeights() async {
    try {
      final cont = Get.find<StatsCont>();
      final uid = Get.find<AuthController>().userss!.uid;
      print(getFirstAndLastDatesOfMonth(
              DateTime.parse(cont.selectedDate.value))[0]
          .toString());
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(uid)
          .collection('Weight')
          .where('CreatedAt',
              isGreaterThanOrEqualTo: getFirstAndLastDatesOfMonth(
                      DateTime.parse(cont.selectedDate.value))[0]
                  .toString())
          .where('CreatedAt',
              isLessThanOrEqualTo: getFirstAndLastDatesOfMonth(
                      DateTime.parse(cont.selectedDate.value))[1]
                  .toString())
          .get()
          .then((value) {
        cont.weights.value = [];
        value.docs.forEach((element) {
          if (todayDate(element.get('CreatedAt'))) {
            cont.todayWeight.value = element.get('Value');
          }
          cont.weights.value!.add(ChartSampleData(
              DateTime.parse(element.get('CreatedAt')).day,
              element.get('Value')));
        });

        print(cont.weights.value!.length);
      });
    } catch (e) {
      print(e);
    }
  }

  static bool todayDate(String date) {
    return date.split(' ')[0] == DateTime.now().toString().split(' ')[0];
    
  }
}
