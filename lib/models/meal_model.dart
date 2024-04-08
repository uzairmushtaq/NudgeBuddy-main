import 'package:cloud_firestore/cloud_firestore.dart';

// STORE MEAL DATA
// ================================================================================================================
class MealModel {
  String? id, title, quantity, createdAt;
  num? carbs, proteins, fats, kcal;
  String? type;
  MealModel(
      {this.carbs,
      this.createdAt,
      this.fats,
      this.id,
      this.type,
      this.kcal,
      this.proteins,
      this.quantity,
      this.title});
  MealModel.fromDocumentSnapshot(DocumentSnapshot doc) {
    id = doc.id;
    title = doc['Title'];
    type = doc["Type"];
    quantity = doc['Quantity'];
    createdAt = doc['CreatedAt'];
    carbs = doc['Carbs'];
    proteins = doc['Protein'];
    fats = doc['Fats']; 
    kcal = doc['Kcal'];
  }
}
