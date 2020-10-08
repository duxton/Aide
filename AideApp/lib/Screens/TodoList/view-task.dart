import 'package:AideApp/Screens/Home.dart';
import 'package:AideApp/Screens/TodoList/taskDetailsStream.dart';
import 'package:AideApp/Screens/TodoList/edit-task.dart';
import 'package:AideApp/Screens/TodoList/task-details.dart';
import 'package:AideApp/Widgets/Re-usable/header.dart';
import 'package:AideApp/Widgets/Re-usable/progress.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ViewTask extends StatefulWidget {
  static const routeName = '/View_Task';
  @override
  _ViewTaskState createState() => _ViewTaskState();
}

DateTime now = DateTime.now();
String formattedDate = DateFormat('yyyy-MM-dd').format(now);

class _ViewTaskState extends State<ViewTask> {
  final String currentUserId = currentUser?.id;
  final String name;
  final String location;
  final Timestamp timestamp;
  final String ownerId;
  final String taskId;
  final Timestamp date;

  _ViewTaskState({
    this.name,
    this.location,
    this.timestamp,
    this.ownerId,
    this.taskId,
    this.date,
  });

  int totalTask = 0;
  int totalColourTask = 0;
  int totalCompletedTask = 0;
  bool isWaiting = true;

  @override
  void initState() {
    super.initState();
    checkIfCompletedOrNot();
    getTotalTask();
    getCompletedTask();
  }

  getTotalTask() async {
    QuerySnapshot snapshot =
        await tasksRef.doc(currentUser.id).collection('userTasks').get();

    setState(() {
      isWaiting = false;
      totalTask = snapshot.docs.length;
    });
  }

  getCompletedTask() async {
    QuerySnapshot snapshot = await tasksRef
        .doc(currentUser.id)
        .collection('userTasks')
        .where('isCompleted', isEqualTo: true)
        .get();

    setState(() {
      isWaiting = false;
      totalCompletedTask = snapshot.docs.length;
    });
  }

  getTaskByColor() async {
    //* * Think if this is necessaries
    QuerySnapshot snapshot = await tasksRef
        .doc(currentUser.id)
        .collection('userTasks')
        .where("colour",
            isEqualTo: "MaterialColor(primary value: Color(0xff03a9f4))")
        .get();

    setState(() {
      isWaiting = false;
      totalColourTask = snapshot.docs.length;
    });
  }

  progressTrack(context) {
    return new Center(
      child: new Container(
        width: MediaQuery.of(context).size.width * 1,
        height: MediaQuery.of(context).size.height * 0.3,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'assets/images/macbookProductive.jpeg'), // ** Put pictures that looks productive or aesthically pleasing
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
                      formattedDate,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
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
                taskNo(isWaiting ? '??' : totalTask.toString(), 'Total'),
                taskNo(isWaiting ? '??' : totalCompletedTask.toString(),
                    'Completed'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                taskNo(isWaiting ? '??' : totalTask.toString(), 'Work'),
                // TODO:: Figure out a way to seperate task by work and personal categories
                taskNo(isWaiting ? '??' : totalCompletedTask.toString(),
                    'Personal'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  bool isCompleted = false;
  checkIfCompletedOrNot() async {
    DocumentSnapshot ds = await tasksRef
        .doc(currentUser.id)
        .collection("userTasks")
        .doc(this.taskId)
        .get();
    isCompleted = ds.exists;
  }

  buildTaskCard() {
    return StreamBuilder(
        stream: tasksRef
            .doc(currentUserId)
            .collection('userTasks')
      //      .orderBy("date", descending: false) //TODO:: Fix This
            .where("isCompleted", isEqualTo: false)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }
          List<Tasks> tasks = [];
          snapshot.data.docs.forEach((doc) {
            tasks.add(Tasks.fromDocument(doc));
          });
          return ListView(
            children: tasks,
          );
        });
  }

  

  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(context,
          removeBackButton: false,
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
          Text('Tasks'),
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
  final Timestamp time;
  final String tasksId;
  final String color;

  Tasks(
      {this.name,
      this.location,
      this.timestamp,
      this.tasksId,
      this.time,
      this.color,
      this.taskDetails});

  factory Tasks.fromDocument(DocumentSnapshot doc) {
    return Tasks(
      name: doc.data()['name'],
      location: doc.data()['location'],
      timestamp: doc.data()['timestamp'],
      tasksId: doc.data()['tasksId'],
      time: doc.data()['time'],
      color: doc.data()['colour'],
    );
  }

  final TaskDetails taskDetails;

  showTaskDetails(context) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DetailsScreen(
            tasksId: tasksId,
          ),
        ));
  }

  deleteTask() {
    tasksRef
        .doc(currentUser.id)
        .collection('userTasks')
        .doc(tasksId)
        .get()
        .then((value) => {
              if (value.exists)
                {
                  value.reference.delete(),
                }
            });
  }

  completedTask() {
    tasksRef.doc(currentUser.id).collection("userTasks").doc(tasksId).update({
      "isCompleted": true,
    });
  }

  handleDeleteTask(parentContext) {
    return showDialog(
        context: parentContext,
        builder: (context) {
          return SimpleDialog(
            title: Text('Comfirm to delete this task?'),
            children: <Widget>[
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context);
                  deleteTask();
                },
                child: Text(
                  'Delete',
                  style: TextStyle(color: Colors.red),
                ),
              ),
              SimpleDialogOption(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'Cancel',
                ),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    String valueString = color.split('(0x')[1].split(')')[0]; // kind of hacky..
    int value = int.parse(valueString, radix: 16);
    Color otherColor = new Color(value);
    DateTime dateTime = time.toDate();
    String formatDateTime = DateFormat('MMM-dd').format(dateTime);
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      actions: <Widget>[
        // IconSlideAction(
        //   caption: 'Archive',
        //   color: Colors.blue,
        //   icon: Icons.archive,
        //   onTap: () => _showSnackBar(context,'Archive'),
        // ),
        IconSlideAction(
          caption: 'Delete',
          color: Colors.red,
          icon: Icons.delete,
          onTap: () => handleDeleteTask(context),
        ),
      ],
      secondaryActions: <Widget>[
        // IconSlideAction(
        //   caption: 'More',
        //   color: Colors.black45,
        //   icon: Icons.more_horiz,
        //   onTap: () => _showSnackBar(context,'More'),
        // ),
        IconSlideAction(
          caption: 'Done',
          color: Colors.green,
          icon: Icons.check,
          onTap: () => completedTask(),
        ),
      ],
      child: GestureDetector(
        onTap: () => showTaskDetails(context),
        child: Card(
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: otherColor,
            ),
            title: Text(name),
            subtitle: Text(location),
            trailing: Text(
              formatDateTime,
            ),
          ),
        ),
      ),
    );
  }
}
