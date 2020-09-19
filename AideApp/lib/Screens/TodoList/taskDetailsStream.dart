import 'package:AideApp/Screens/Home.dart';
import 'package:AideApp/Screens/TodoList/task-details.dart';
import 'package:AideApp/Widgets/Re-usable/progress.dart';
import 'package:flutter/material.dart';
import '../../Screens/Home.dart';

class DetailsScreen extends StatelessWidget {
  final String tasksId;
  final String ownerId;
  DetailsScreen({this.ownerId, this.tasksId});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: tasksRef
            .doc(currentUser.id)
            .collection('userTasks')
            .doc(tasksId)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return circularProgress();
          }
          TaskDetails taskDetails = TaskDetails.fromDocument(snapshot.data);
          return taskDetails;
        });
  }
}

class NotifyMe extends StatelessWidget {
  final bool notifyMe;
  final String tasksId;
  NotifyMe({this.notifyMe,this.tasksId});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: notifyMeRef
            .doc(currentUser.id)
            .collection(tasksId)
            .doc('Notify Me reminder')
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return circularProgress();
          }
          TaskDetails taskDetails = TaskDetails.fromDocument(snapshot.data);
          return taskDetails;
        });
  }
}

