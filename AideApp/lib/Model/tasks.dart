import 'package:cloud_firestore/cloud_firestore.dart';

class Tasks {
  final String name;
  final String notes;
  final String description;
  final DateTime date;
  final String time;
  final String color;

  Tasks({
    this.name,
    this.notes,
    this.description,
    this.date,
    this.time,
    this.color,
  });

  factory Tasks.fromDocument(DocumentSnapshot doc) {
    return Tasks(
      name: doc['name'],
      notes: doc['notes'],
      description: doc['description'],
      date: doc['date'],
      time: doc['time'],
      color: doc['colour']
    );
  }
}
