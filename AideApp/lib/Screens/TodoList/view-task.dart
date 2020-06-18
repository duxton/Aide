import 'package:AideApp/Screens/Home.dart';
import 'package:AideApp/Screens/TodoList/detailsScreen.dart';
import 'package:AideApp/Screens/TodoList/edit-task.dart';
import 'package:AideApp/Screens/TodoList/task-details.dart';
import 'package:AideApp/Widgets/Re-usable/header.dart';
import 'package:AideApp/Widgets/Re-usable/progress.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

class ViewTask extends StatefulWidget {
  @override
  _ViewTaskState createState() => _ViewTaskState();
}

progressTrack(context) {
  return new Center(
    child: new Container(
      width: MediaQuery.of(context).size.width * 1,
      height: MediaQuery.of(context).size.height * 0.3,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/milky-way.jpg'),
          fit: BoxFit.fill,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Your Things',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 50,
                    ),
                  ),
                  Text(
                    '10-6-2020',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),
          noOfTasks(),
        ],
      ),
    ),
  );
}

taskNo(String numberTask, String taskCat) {
  return Column(
    children: <Widget>[
      Text(
        numberTask,
        style: TextStyle(color: Colors.white, fontSize: 16.0),
      ),
      Text(
        taskCat,
        style: TextStyle(color: Colors.white, fontSize: 10.0),
      ),
    ],
  );
}

noOfTasks() {
  return Expanded(
    flex: 1,
    child: Container(
      decoration: BoxDecoration(color: Colors.black45.withOpacity(0.3)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              taskNo('24', 'personal'),
              taskNo('16', 'business'),
            ],
          ),
          Text(
            'Progress 65% done ',
            style: TextStyle(color: Colors.white, fontSize: 10),
          ),
        ],
      ),
    ),
  );
}

class _ViewTaskState extends State<ViewTask> {
  final String currentUserId = currentUser?.id;
  final String name;
  final String location;
  final Timestamp timestamp;
  final String ownerId;
  final String taskId;

  _ViewTaskState({
    this.name,
    this.location,
    this.timestamp,
    this.ownerId,
    this.taskId,
  });

  buildTaskCard() {
    return StreamBuilder(
        stream: tasksRef
            .document(currentUserId)
            .collection('userTasks')
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return circularProgress();
          }
          List<Tasks> tasks = [];
          snapshot.data.documents.forEach((doc) {
            tasks.add(Tasks.fromDocument(doc));
          });
          return ListView(
            children: tasks,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(context,
          titleText: 'Tasks',
          backgroundColor: Theme.of(context).primaryColor,
          icons: IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => EditTask(
                            currentUser: currentUser,
                          )));
            },
          )),
      body: Column(
        children: <Widget>[
          progressTrack(context),
          Divider(),
          Text('List'),
          Divider(),
          Expanded(child: buildTaskCard()),
        ],
      ),
    );
  }
}

class Tasks extends StatelessWidget {
  final String name;
  final String location;
  final Timestamp timestamp;

  final String tasksId;

  Tasks({this.name, this.location, this.timestamp, this.tasksId, this.taskDetails});

  factory Tasks.fromDocument(DocumentSnapshot doc) {
    return Tasks(
      name: doc['name'],
      location: doc['description'],
      timestamp: doc['timestamp'],
      tasksId: doc['tasksId'],
    );
  }

  final TaskDetails taskDetails;

  showTaskDetails(context) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DetailsScreen(
            tasksId:tasksId,
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showTaskDetails(context),
      child: Card(
        child: ListTile(
          leading: CircleAvatar(),
          title: Text(name),
          subtitle: Text(location),
          trailing: Text(
            timeago.format(timestamp.toDate()),
          ),
        ),
      ),
    );
  }
}
