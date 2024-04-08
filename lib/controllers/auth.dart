// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:NudgeBuddy/constants/units.dart';
import 'package:NudgeBuddy/models/user_model.dart';
import 'package:NudgeBuddy/utils/root.dart';
import 'package:NudgeBuddy/views/widgets/custom_snackbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:get/get.dart';

// Auth.dart is the controller for the authentication process. It handles the login, signup, and logout process. It also handles the user's data and the user settings.
// The controller is initialized in the main.dart file and is used from all the following files: auth.dart, auth_view.dart, login.dart, signup.dart, home.dart, settings.dart, and profile.dart and is used in the following files: meal.dart, notifications.dart, and nutrients.dart.
//====================================================================================================================================================================================================================
class AuthController extends GetxController {
  //TEXTEDITING CONTROLLERS
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController loginEmail = TextEditingController();
  TextEditingController loginPass = TextEditingController();

  //OBSERVABLE VARIABLES 
  Rxn<PageController> pageController = Rxn<PageController>();
  RxBool isLoading = false.obs;
  RxList homeTableKcalList = [].obs;
  RxBool allowNotifications = true.obs;
  RxInt goalKcal = 0.obs;
  RxInt goalFats = 0.obs;
  RxInt goalProtein = 0.obs;
  RxInt goalCarbs = 0.obs;
  RxInt selectedGoalIndex = (-1).obs;
  RxInt selectedActivityIndex = (-1).obs;
  RxInt currentSection = 0.obs;
  RxInt selectedGender = (-1).obs;
  RxInt bnbSelectedIndex = 0.obs;
  RxInt weightVal = 55.obs;
  RxInt heightFeetVal = 5.obs;
  RxInt heightInchesVal = 8.obs;
  RxInt age = 20.obs;
  RxString weightUnit = UnitConstants.kg.obs;
  RxString heightUnit = UnitConstants.feet.obs;
  RxString defaultTimeZone = ''.obs;
  Rx<UserModel> userModel = UserModel().obs;
  UserModel get userInfo => userModel.value;
  set userInfo(UserModel value) => userModel.value = value;
  final Rxn<User> _firebaseUser = Rxn<User>();
  User? get userss => _firebaseUser.value;

  //INSTANCES
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  @override
  onInit() {
    _firebaseUser.bindStream(_auth.authStateChanges());
    pageController.value = PageController(initialPage: 0);
    getDeviceTimeZone();
    super.onInit();
  }

  getDeviceTimeZone() async {
    defaultTimeZone.value = await FlutterNativeTimezone.getLocalTimezone();
    print('TIMEZONE ${defaultTimeZone.value}');
  }

  //AUTHENTICATION

  Future<void> onLogin() async {
    try {
      if (loginEmail.text.isNotEmpty && loginPass.text.isNotEmpty) {
        isLoading.value = true;
        await _auth.signInWithEmailAndPassword(
            email: loginEmail.text, password: loginPass.text);
        await getUser();

        Navigator.pushAndRemoveUntil<dynamic>(
          Get.overlayContext!,
          MaterialPageRoute<dynamic>(
            builder: (BuildContext context) => Root(),
          ),
          (route) => false,
        );
        isLoading.value = false;
      } else {
        CustomSnackbar.showCustomSnackbar(true, 'Please provide all data');
      }
    } catch (e) {
      isLoading.value = false;
      print(e);
      CustomSnackbar.showCustomSnackbar(true, "$e".split("]")[1]);
    }
  }
  // This function is used to validate the user's data before creating an account.
  Future<void> onSignup() async {
    try {
      if (_isAuthValidate()) {
        if (currentSection.value == 2) {
          pageController.value!.nextPage(
              duration: const Duration(microseconds: 300),
              curve: Curves.easeInBack);
        } else {
          UserModel user = UserModel(
            username: username.text,
            email: email.text,
            age: age.value,
            genderIndex: selectedGender.value,
            goalIndex: selectedGoalIndex.value,
            activityLevelIndex: selectedActivityIndex.value,
            weight: weightVal.value.toInt(),
            height: heightUnit.value == UnitConstants.pounds
                ? heightFeetVal.value
                : num.parse('${heightFeetVal.value}.${heightInchesVal.value}'),
            weightUnit: weightUnit.value,
            heightUnit: heightUnit.value,
          );
          isLoading.value = true;
          final authenticatedUser = await _auth.createUserWithEmailAndPassword(
              email: user.email!, password: password.text);
          await createUserInFirestore(user, authenticatedUser.user!.uid);
          await getUser();
          Navigator.pushAndRemoveUntil<dynamic>(
            Get.overlayContext!,
            MaterialPageRoute<dynamic>(
              builder: (BuildContext context) => Root(),
            ),
            (route) => false,
          );
        }
      } else {
        CustomSnackbar.showCustomSnackbar(true, 'Please provide all data');
      }
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      print(e);
      CustomSnackbar.showCustomSnackbar(true, "$e".split("]")[1]);
    }
  }
  // This function creates a user in the firestore database.
  Future<void> createUserInFirestore(UserModel user, String userId) async {
    try {
      await _firestore.collection('Users').doc(userId).set({
        'GoalIndex': user.goalIndex,
        'ActivityLevelIndex': user.activityLevelIndex,
        'Username': user.username,
        'Email': user.email,
        'Age': user.age,
        'GenderIndex': user.genderIndex,
        'Weight': user.weight,
        'WeightUnit': user.weightUnit,
        'Height': user.height,
        'WeightGoal': 0,
        'AllowNotifications': true,
        'HeightUnit': user.heightUnit,
        'CreatedAt': DateTime.now().toString()
      });
    } catch (e) {
      print(e);
    }
  }
  // This function fetches the user's data from the firestore database.
  Future<void> getUser() async {
    try {
      print('THIS IS THE USER ${userss!.email}');
      final DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection('Users')
          .doc(userss!.uid)
          .get();
      userInfo = UserModel.fromDocumentSnapshot(doc);
      selectedGoalIndex.value = userInfo.goalIndex!;
      selectedActivityIndex.value = userInfo.activityLevelIndex!;
      selectedGender.value = userInfo.genderIndex!;
      allowNotifications.value = userInfo.allowNotifications!;
      heightFeetVal.value =
          int.parse(userInfo.height!.toDouble().toString().split('.')[0]);
      heightInchesVal.value =
          int.parse(userInfo.height!.toDouble().toString().split('.')[1]);
      heightUnit.value = userInfo.heightUnit!;
      weightVal.value = userInfo.weight! as int;
      weightUnit.value = userInfo.weightUnit!;
    } catch (e) {
      print(e);
    }
  }
  
  bool _isAuthValidate() { // This function validates the user's data.
    return selectedActivityIndex.value != -1 &&
        selectedGender.value != -1 &&
        selectedGoalIndex.value != -1 &&
        username.text.isNotEmpty &&
        email.text.isEmail &&
        password.text.isNotEmpty;
  }
  // This function is used to sign out the user.
  Future<void> onSignout() async {
    try {
      await _auth.signOut();
      Navigator.pushAndRemoveUntil<dynamic>(
        Get.overlayContext!,
        MaterialPageRoute<dynamic>(
          builder: (BuildContext context) => Root(),
        ),
        (route) => false,
      );
      clearValues();
    } catch (e) {
      print(e);
    }
  }

  //CHANGE PASSWORD QUERY
  Future<void> onChangePassword(String newPass, String confirmNewPass) async {
    try {
      if (newPass.isNotEmpty && confirmNewPass.isNotEmpty) {
        if (newPass == confirmNewPass) {
          isLoading.value = true;
          userss!.updatePassword(newPass).then((value) async {
            await _firestore
                .collection("Users")
                .doc(userss!.uid)
                .update({"Password": newPass});
            await getUser();
          }).then((value) {
            isLoading.value = false;
            Get.back();
            CustomSnackbar.showCustomSnackbar(
                false, 'Your password is successfully changed');
          });
        } else {
          CustomSnackbar.showCustomSnackbar(
              true, "Your new and confirm password doesn't match");
        }
      } else {
        CustomSnackbar.showCustomSnackbar(true, 'Please provide all data');
      }
    } catch (e) {
      isLoading.value = false;
      CustomSnackbar.showCustomSnackbar(true, "$e".split("]")[1]);
    }
  }

  //CHANGE GENDER
  Future<void> changeGender() async {
    try {
      isLoading.value = true;
      await _firestore
          .collection('Users')
          .doc(userss!.uid)
          .update({'GenderIndex': selectedGender.value});
      await getUser();
      Get.back();
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      print(e);
      CustomSnackbar.showCustomSnackbar(true, "$e".split("]")[1]);
    }
  }

  //CHANGE HEIGHT
  Future<void> changeHeight() async {
    try {
      isLoading.value = true;
      await _firestore.collection('Users').doc(userss!.uid).update({
        'Height': heightUnit.value == UnitConstants.centimeter
            ? heightFeetVal.value
            : heightFeetVal.value + (heightInchesVal.value * 0.1),
        'HeightUnit': heightUnit.value
      });
      await getUser();
      Get.back();
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      print(e);
      CustomSnackbar.showCustomSnackbar(true, "$e".split("]")[1]);
    }
  }

  //CHANGE WEIGHT
  Future<void> changeWeight() async {
    try {
      isLoading.value = true;
      await _firestore
          .collection('Users')
          .doc(userss!.uid)
          .update({'Weight': weightVal.value, 'WeightUnit': weightUnit.value});
      await getUser();
      Get.back();
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      print(e);
      CustomSnackbar.showCustomSnackbar(true, "$e".split("]")[1]);
    }
  }

  //CHANGE GOAL INDEX
  Future<void> changeGoalIndex() async {
    try {
      isLoading.value = true;
      await _firestore
          .collection('Users')
          .doc(userss!.uid)
          .update({'GoalIndex': selectedGoalIndex.value});
      await getUser();
      Get.back();
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      print(e);
      CustomSnackbar.showCustomSnackbar(true, "$e".split("]")[1]);
    }
  }

  //CHANGE ACTIVITY LEVEL
  Future<void> changeActivityIndex() async {
    try {
      isLoading.value = true;
      await _firestore
          .collection('Users')
          .doc(userss!.uid)
          .update({'ActivityLevelIndex': selectedActivityIndex.value});
      await getUser();
      Get.back();
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      print(e);
      CustomSnackbar.showCustomSnackbar(true, "$e".split("]")[1]);
    }
  }

  //CHANGE WEIGHT GOAL
  Future<void> changeWeightGoal() async {
    try {
      isLoading.value = true;
      await _firestore
          .collection('Users')
          .doc(userss!.uid)
          .update({'WeightGoal': weightVal.value});
      await getUser();
      Get.back();
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      print(e);
      CustomSnackbar.showCustomSnackbar(true, "$e".split("]")[1]);
    }
  }

  //CHANGE AGE
  Future<void> changeAge() async {
    try {
      isLoading.value = true;
      await _firestore
          .collection('Users')
          .doc(userss!.uid)
          .update({'Age': age.value});
      await getUser();
      Get.back();
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      print(e);
      CustomSnackbar.showCustomSnackbar(true, "$e".split("]")[1]);
    }
  }

  //DELETE YOUR ACCOUNT
   Future<void> deleteAccount(String id) async {
    try {
      isLoading.value = true;

      await userss!.delete();
      FirebaseFirestore.instance.collection('Users').doc(id).delete();
      clearValues();
      Get.back();
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
    CustomSnackbar.showCustomSnackbar(true, "$e".split("]")[1]);
      print(e);
    }
  }

  //Forgot Password
  Future<void> onForgetPassword(String email) async {
    try {
      if (email.isNotEmpty) {
        await _auth.sendPasswordResetEmail(email: email);
        CustomSnackbar.showCustomSnackbar(
            false, 'Reset password email successfully sent!');
      } else {
        CustomSnackbar.showCustomSnackbar(true, 'Email is empty');
      }
    } catch (e) {
      print(e);
    }
  }
  // CLEAR ALL INPUT FIELDS
  clearValues() {
    username.clear();
    loginEmail.clear();
    loginPass.clear();
    email.clear();
    password.clear();
    isLoading.value = false;
    homeTableKcalList.value = [];
    allowNotifications.value = true;
    goalKcal.value = 0;
    goalFats.value = 0;
    goalProtein.value = 0;
    goalCarbs.value = 0;
    selectedGoalIndex.value = (-1);
    selectedActivityIndex.value = (-1);
    currentSection.value = 0;
    selectedGender.value = (-1);
    bnbSelectedIndex.value = 0;
    weightVal.value = 55;
    heightFeetVal.value = 5;
    heightInchesVal.value = 8;
    age.value = 20;
    weightUnit.value = UnitConstants.kg;
    heightUnit.value = UnitConstants.feet;
  }
}
