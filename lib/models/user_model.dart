import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

// STORES THE USER DATA FOR THE USER PROFILE
// ================================================================================================================
class UserModel {
  int? goalIndex, activityLevelIndex, genderIndex,age;
  num? weight, height,weightGoal;
  bool? allowNotifications;
  String? id, username, email, weightUnit, heightUnit, createdAt;
  UserModel(
      { this.activityLevelIndex,
       this.createdAt,
       this.email,
       this.genderIndex,
       this.goalIndex,
       this.height,
       this.allowNotifications,
       this.weightGoal,
       this.heightUnit,
       this.age,
       this.username,
       this.weight,
       this.id,
       this.weightUnit});

  UserModel.fromDocumentSnapshot(DocumentSnapshot doc) {
    id = doc.id;
    goalIndex = doc['GoalIndex'];
    activityLevelIndex = doc['ActivityLevelIndex'];
    username = doc['Username'];
    email = doc['Email'];
    allowNotifications=doc['AllowNotifications'];
    weightGoal=doc['WeightGoal'];
    genderIndex = doc['GenderIndex'];
    weight = doc['Weight'];
    age=doc['Age'];
    weightUnit = doc['WeightUnit'];
    height = doc['Height'];
    heightUnit = doc['HeightUnit'];
    createdAt = doc['CreatedAt'];
  }
}
