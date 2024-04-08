import 'package:NudgeBuddy/constants/icons.dart';

// STORES DATA FOR GOALS IN THE GOALS SCREENS OF THE ONBOARDING PROCESS
// ===========================================================================================
class GoalsModel {
  String image, title;
  GoalsModel({required this.image, required this.title});
  static List<GoalsModel> data = [
    GoalsModel(image: IconsConstants.weightGain, title: 'Weight gain'),
    GoalsModel(image: IconsConstants.weightLoss, title: 'Weight loss'),
    GoalsModel(image: IconsConstants.weightMaintain, title: 'Maintain weight'),
  ];
}
