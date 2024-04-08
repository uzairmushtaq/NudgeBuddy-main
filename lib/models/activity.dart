// STORE USER DATA FOR ACTIVITY LEVEL
// ================================================================================================================

class ActivityModel {
  String title, subtitle;
  ActivityModel({required this.title, required this.subtitle});
  static List<ActivityModel> data = [
    ActivityModel(title: 'Sedentary', subtitle: ''),
    ActivityModel(title: 'Light', subtitle: 'exercise 1-3 times/week'),
    ActivityModel(
        title: 'Moderate',
        subtitle: 'Daily exercise or intense exercise 3-4 times/week'),
    ActivityModel(title: 'High', subtitle: 'exercise 4-5 times/week'),
  ];
}
