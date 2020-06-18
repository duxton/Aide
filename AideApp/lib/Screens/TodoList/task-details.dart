import 'package:AideApp/Model/tasks.dart';

import 'package:AideApp/Widgets/Re-usable/header.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

import '../Home.dart';

class TaskDetails extends StatefulWidget {
  final String tasksId;
  final String description;
  final String color;
  final String name;
  final Timestamp date;
  final Timestamp time;

  TaskDetails({
    this.tasksId,
    this.description,
    this.color,
    this.name,
    this.date,
    this.time,
  });

  factory TaskDetails.fromDocument(DocumentSnapshot doc) {
    return TaskDetails(
      tasksId: doc['tasksId'],
      description: doc['description'],
      color: doc['colour'],
      name: doc['name'],
      date: doc['date'],
      time: doc['time'],
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

  _TaskDetailsState({
    this.ownerId,
    this.tasksId,
    this.description,
    this.color,
    this.name,
    this.date,
    this.time,
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
  TextEditingController sub_taskController = TextEditingController();
  bool isUploading = false;

  bool isSwitched = false;
  Tasks tasks;
  bool _isChecked = false;

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

  buildCheckBoxListTile(String name) {
    return StreamBuilder<Object>( // TODO:: snapshot the data here from firestore 
      stream: null,
      builder: (context, snapshot) {
        return Center(
          child: CheckboxListTile(
            title: Text(name),
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
    );
  }

  handleSubmitTask() {
    //TODO:: Refer to edit-task.dart 
  }

  createSubQueryMap() {
    //TODO:: Refer to likes from Fluttershare
  }

  addCheckBox(String text, sideIcon, controller) {
    return GestureDetector(
      onTap: () {},// TODO:: On Tap to put save the task if cant put a trailing icon to save the data to firestore 
      child: ListTile(
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
    ),
    );
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
                addCheckBox('Add task' , Icon(Icons.add),sub_taskController ),
                buildCheckBoxListTile('name'),
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
