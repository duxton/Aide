import 'package:cloud_firestore/cloud_firestore.dart';

class Task {
  final String tasksId;
  final String description;
  final String color;
  final String name;
  final bool isCompleted;
  final Timestamp date;
  final Timestamp time;
  final String subTaskCreatedId;
  final String subTaskName;
  final String location;
  final bool notifyMe;

  Task({
    this.tasksId,
    this.description,
    this.color,
    this.name,
    this.isCompleted,
    this.date,
    this.time,
    this.subTaskCreatedId,
    this.subTaskName,
    this.location,
    this.notifyMe,
  });

   factory Task.fromDocument(DocumentSnapshot doc) {
    return Task(
      tasksId: doc.data()['tasksId'],
      description: doc.data()['description'],
      color: doc.data()['color'],
      name: doc.data()['name'],
      time: doc.data()['time'],
     
    );
  }
}
