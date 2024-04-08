
// STORES DATA FOR INITIAL APP SCREEN, FOR NEW USERS
// ================================================================================================================

class OnboardingModel {
  String title, subtitle, image;
  OnboardingModel({required this.image,required this.subtitle,required this.title});
  static List<OnboardingModel> data=  [
    OnboardingModel(
      title: 'Healthy Eating',
      subtitle: 'Maintaining good health should be the primary focus of everyone.',
      image: 'assets/images/onboarding1.png'
    ),
    OnboardingModel(
      title: 'Calorie Tracking',
      subtitle: 'Thanks to integrated tools you can track your progress.',
      image: 'assets/images/onboarding2.png'
    ),
  ];
}

