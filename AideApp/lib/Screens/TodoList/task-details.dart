import 'package:AideApp/Widgets/Re-usable/header.dart';
import 'package:AideApp/Widgets/Re-usable/progress.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

import 'package:flutter/material.dart';

import '../Home.dart';

class TaskDetails extends StatefulWidget {
  final String tasksId;
  final String description;
  final String color;
  final String name;
  final Timestamp date;
  final Timestamp time;
  final String subTaskCreatedId;
  final String subTaskName;

  TaskDetails({
    this.tasksId,
    this.description,
    this.color,
    this.name,
    this.date,
    this.time,
    this.subTaskCreatedId,
    this.subTaskName,
  });

  factory TaskDetails.fromDocument(DocumentSnapshot doc) {
    return TaskDetails(
      tasksId: doc['tasksId'],
      description: doc['description'],
      color: doc['colour'],
      name: doc['name'],
      date: doc['date'],
      time: doc['time'],
      subTaskName: doc['subTaskName'],
      subTaskCreatedId: doc['subTaskId'],
    );
  }
  @override
  _TaskDetailsState createState() => _TaskDetailsState(
        tasksId: this.tasksId,
        description: this.description,
        color: this.color,
        name: this.name,
        date: this.date,
        time: this.time,
        subTaskName: this.subTaskName,
        subTaskCreatedId: this.subTaskCreatedId,
      );
}

class _TaskDetailsState extends State<TaskDetails>
    with SingleTickerProviderStateMixin {
  final String currentUserId = currentUser?.id;
  final String ownerId;
  final String tasksId;
  final String description;
  final String color;
  final String name;
  final Timestamp date;
  final Timestamp time;
  final String subTaskName;
  final String subTaskCreatedId;
  _TaskDetailsState({
    this.ownerId,
    this.tasksId,
    this.description,
    this.color,
    this.name,
    this.date,
    this.time,
    this.subTaskName,
    this.subTaskCreatedId,
  });
  TabController _tabController;
  @override
  void initState() {
    _tabController = new TabController(length: 3, vsync: this);

    super.initState();
  }

  TextEditingController descriptionController = TextEditingController();
  TextEditingController colourController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  TextEditingController subtaskController = TextEditingController();
  bool isUploading = false;
  String subTaskId =Uuid().v4() ;
  bool isSwitched = false;

  customTextField(String text, sideIcon, controller) {
    return ListTile(
      // ListTile for input where was the photo was taken
      leading: sideIcon,
      title: Container(
        height: 50,
        width: 250.0,
        child: TextField(
          style: TextStyle(color: Theme.of(context).primaryColor),
          controller: controller,
          decoration: InputDecoration(
            hintText: text,
            border: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey)),
            hintStyle: TextStyle(color: Theme.of(context).primaryColor),
          ),
        ),
      ),
    );
  }

  addTask() {
    return Column(
      children: <Widget>[
        Column(
          children: <Widget>[
            customTextField(
              description,
              Icon(
                Icons.description,
                color: Colors.grey,
                size: 20,
              ),
              descriptionController,
            ),
            customTextField(
                color,
                Icon(
                  Icons.color_lens,
                  color: Colors.grey,
                  size: 20,
                ),
                colourController),
            SizedBox(
              height: 50,
            ),
            Text(DateFormat.Hm().format(time.toDate())),
          ],
        )
      ],
    );
  }

  buildTaskHeader() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        height: MediaQuery.of(context).size.width * 0.25,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 100,
              width: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(25),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    DateFormat.MMM().format(date.toDate()),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                  Text(
                    DateFormat.d().format(date.toDate()),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 50,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  name,
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                      color: Colors.black),
                ),
                Text(
                  description,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  handleSubmitsubTask() {
    setState(() {
      isUploading = true;
    });
    createSubTaskInFirestore(
      subTaskname: subtaskController.text,
    );
    subtaskController.clear();
    setState(() {
      isUploading = false;
      subTaskId = Uuid().v4();

    });
  }

  createSubTaskInFirestore({
    String subTaskname,
  }) {
    subTasksRef
        .document(currentUser.id)
        .collection(tasksId)
        .document(subTaskId)
        .setData({
      "subTaskName": subTaskname,
      "tasksId": tasksId,
      "subTaskId": subTaskId,
      "ownerId": currentUser.id,
      "username": currentUser.username,
      "timestamp": timestamp,
    });
  }

  addCheckBox(String text, sideIcon, controller) {
    return GestureDetector(
      onTap: () => handleSubmitsubTask(),
      child: ListTile(
        // ListTile for input where was the photo was taken
        leading: sideIcon,
        title: Container(
          height: 50,
          width: 250.0,
          child: TextField(
            style: TextStyle(color: Theme.of(context).primaryColor),
            controller: subtaskController,
            decoration: InputDecoration(
              hintText: text,
              border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey)),
              hintStyle: TextStyle(color: Theme.of(context).primaryColor),
            ),
          ),
        ),
      ),
    );
  }

  buildSubTask() {
    return StreamBuilder(
        stream: subTasksRef
            .document(currentUser.id)
            .collection(tasksId)
            .orderBy("timestamp" , descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return circularProgress();
          }
          List<SubTask> subTasks = [];
          snapshot.data.documents.forEach((doc) {
            subTasks.add(SubTask.fromDocument(doc));
          });
          return ListView(
            shrinkWrap: true,
            children: subTasks,
          );
        });
  }

  buildTabInfo() {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.35,
        child: TabBarView(
          controller: _tabController,
          children: <Widget>[
            SingleChildScrollView(
              child: Container(
                child: addTask(),
              ),
            ),
            Container(
                child: SingleChildScrollView(
              child: Column(children: <Widget>[
                addCheckBox('Add task', Icon(Icons.add), subtaskController),
                buildSubTask(),
              ]),
            )),
            Container(
                child: Text(
              'NOTES',
              style: TextStyle(color: Colors.black),
            )), // Third tab
          ],
        ),
      ),
    );
  }

  buildTaskDetails() {
    return Column(
      children: <Widget>[
        buildTaskHeader(),
        Container(
          height: MediaQuery.of(context).size.height * 0.6,
          width: MediaQuery.of(context).size.width * 0.9,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(25),
            ),
            color: Colors.white,
          ),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(25),
                    ),
                    color: Colors.deepPurple[100],
                  ),
                  child: DefaultTabController(
                    length: 3,
                    child: TabBar(
                        controller: _tabController,
                        unselectedLabelColor: Theme.of(context).primaryColor,
                        indicatorSize: TabBarIndicatorSize.tab,
                        indicator: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Theme.of(context).primaryColor,
                        ),
                        tabs: [
                          Tab(
                            child: Align(
                              alignment: Alignment.center,
                              child: Text("Details"),
                            ),
                          ),
                          Tab(
                            child: Align(
                              alignment: Alignment.center,
                              child: Text("Task"),
                            ),
                          ),
                          Tab(
                            child: Align(
                              alignment: Alignment.center,
                              child: Text("Notes"),
                            ),
                          ),
                        ]),
                  ),
                ),
              ),
              buildTabInfo(),
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
        toggleButtonReminder(),
      ],
    );
  }

  toggleButtonReminder() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      child: SwitchListTile(
        title: Text('Notify Me'),
        value: isSwitched,
        onChanged: (bool value) {
          setState(() {
            isSwitched = value;
          });
        },
        secondary: const Icon(Icons.lightbulb_outline),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(
        context,
        titleText: 'Task Details',
        backgroundColor: Theme.of(context).accentColor,
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
              Theme.of(context).accentColor,
              Theme.of(context).primaryColor,
            ])),
        child: buildTaskDetails(),
      ),
    );
  }
}

class SubTask extends StatefulWidget {
  final String subTaskId;
  final String subTaskName;

  SubTask({this.subTaskId, this.subTaskName});

  factory SubTask.fromDocument(DocumentSnapshot doc) {
    return SubTask(
      subTaskId: doc['subTaskId'],
      subTaskName: doc['subTaskName'],
    );
  }

  @override
  _SubTaskState createState() => _SubTaskState(
        subTaskName: this.subTaskName,
        subTaskId: this.subTaskId,
      );
}

class _SubTaskState extends State<SubTask> {
  final String subTaskId;
  final String subTaskName;
  bool _isChecked = false;
  _SubTaskState({this.subTaskId, this.subTaskName});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CheckboxListTile(
        title: Text(widget.subTaskName),
        value: _isChecked,
        onChanged: (bool value) {
          setState(() {
            _isChecked = value;
          });
        },
        secondary: const Icon(Icons.hourglass_empty),
      ),
    );
  }
}
