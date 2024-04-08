import 'package:cloud_firestore/cloud_firestore.dart';

// CONSTRUCTOR FOR NOTIFICATION MODEL - USED TO STORE NOTIFICATION DATA
class NotificationModel{
  String? id,title,body,scheduleTime;
  int? notifyID;
  List? deletedDates;
  NotificationModel({
    this.body,
    this.deletedDates,
    this.id,
    this.scheduleTime,
    this.title
  });
  // This method extracts the data from the database and sets the values for the variables.
  NotificationModel.fromDocumentSnapshot(DocumentSnapshot doc){
    id=doc.id;
    title=doc['Title'];
    body=doc['Body'];
    scheduleTime=doc['ScheduleTime'];
   deletedDates=doc['DeleteDay'];
    notifyID=doc['NotifyID'];
  }
}