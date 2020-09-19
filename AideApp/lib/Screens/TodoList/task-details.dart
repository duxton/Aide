import 'package:AideApp/Model/notification_helper.dart';
import 'package:AideApp/Widgets/Re-usable/header.dart';
import 'package:AideApp/Widgets/Re-usable/progress.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

import 'package:flutter/material.dart';

import '../../main.dart';
import '../Home.dart';

class TaskDetails extends StatefulWidget {
  final String tasksId;
  final String description;
  final String color;
  final String name;
  final bool isCompleted;

  final Timestamp time;
  final String subTaskCreatedId;
  final String subTaskName;
  final String location;
  final bool notifyMe;

  TaskDetails({
    this.tasksId,
    this.description,
    this.color,
    this.name,
    this.isCompleted,
    this.time,
    this.subTaskCreatedId,
    this.subTaskName,
    this.location,
    this.notifyMe,
  });

  factory TaskDetails.fromDocument(DocumentSnapshot doc) {
    return TaskDetails(
      tasksId: doc.data()['tasksId'],
      description: doc.data()['description'],
      color: doc.data()['colour'],
      name: doc.data()['name'],
      isCompleted: doc.data()['isCompleted'],
      time: doc.data()['time'],
      location: doc.data()['location'],
      subTaskName: doc.data()['subTaskName'],
      subTaskCreatedId: doc.data()['subTaskId'],
      notifyMe: doc.data()['notifyMe'],
    );
  }
  @override
  _TaskDetailsState createState() => _TaskDetailsState(
        tasksId: this.tasksId,
        description: this.description,
        color: this.color,
        name: this.name,
        isCompleted: this.isCompleted,
        time: this.time,
        location: this.location,
        subTaskName: this.subTaskName,
        subTaskCreatedId: this.subTaskCreatedId,
        notifyMe: this.notifyMe,
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
  bool isCompleted;
  final String location;
  final Timestamp date;
  final Timestamp time;
  final String subTaskName;
  final String subTaskCreatedId;
  bool notifyMe;
  _TaskDetailsState({
    this.ownerId,
    this.tasksId,
    this.description,
    this.color,
    this.location,
    this.name,
    this.isCompleted,
    this.date,
    this.time,
    this.subTaskName,
    this.subTaskCreatedId,
    this.notifyMe,
  });
  TabController _tabController;

  @override
  void initState() {
    _tabController = new TabController(length: 3, vsync: this);
    descriptionController = TextEditingController(text: description);
    super.initState();
  }

  TextEditingController descriptionController = TextEditingController();
  TextEditingController colourController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  TextEditingController subtaskController = TextEditingController();
  bool isUploading = false;
  String subTaskId = Uuid().v4();
  bool isSwitched = false;
  bool _isEditingText = false;

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void dispose() {
    descriptionController.dispose();
    colourController.dispose();
    noteController.dispose();
    subtaskController.dispose();
    super.dispose();
  }

  customTextField(String text, sideIcon, controller, keyboardType) {
    if (_isEditingText) {
      return ListTile(
        leading: sideIcon,
        title: Container(
          height: 50,
          width: 250.0,
          child: TextField(
            keyboardType: keyboardType,
            style: TextStyle(color: Theme.of(context).primaryColor),
            controller: controller,
            onChanged: (value) {
              handleUpdateSubmit();
            },
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
    return InkWell(
      onTap: () {
        setState(() {
          _isEditingText = true;
        });
      },
      child: ListTile(
        leading: sideIcon,
        title: Text(
          text,
          style: TextStyle(
            color: Colors.black,
            fontSize: 18.0,
          ),
        ),
      ),
    );
  }

  Color pickerColor =
      Color.fromRGBO(126, 25, 27, 0.5); // Change color "new color"
  Color currentColor = Color.fromRGBO(126, 25, 27, 0.5);
// ValueChanged<Color> callback
  void changeColor(Color color) {
    setState(() => pickerColor = color);
  }

  handleColorPicker() {
    showDialog(
      context: context,
      child: AlertDialog(
        title: const Text('Pick a color!'),
        content: SingleChildScrollView(
          child: BlockPicker(
            pickerColor: currentColor,
            onColorChanged: changeColor,
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: const Text('Got it'),
            onPressed: () {
              setState(() => currentColor = pickerColor);
              handleUpdateSubmit();
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  Future<String> colorPicker() async {
    print(currentColor);
    return currentColor.toString();
  }

  handleUpdateSubmit() async {
    setState(() {
      isUploading = true;
    });
    String color = await colorPicker();
    updateTaskData(
      color: color,
      description: descriptionController.text,
      isCompleted: isCompleted,
    );
    colourController.clear();
    setState(() {
      isUploading = false;
      // Navigator.pop(context);
    });
  }

  updateTaskData({
    String color,
    String description,
    bool isCompleted,
  }) {
    tasksRef
        .doc(currentUser.id)
        .collection("userTasks")
        .doc(tasksId)
        .update({
      "colour": color,
      "description": description,
      "isCompleted": isCompleted,
    });
  }

  customButton(text, function, icon) {
    String valueString = color.split('(0x')[1].split(')')[0]; // kind of hacky..
    int value = int.parse(valueString, radix: 16);
    Color otherColor = new Color(value);

    setState(() {
      otherColor = pickerColor;
    });
    if (_isEditingText) {
      return Container(
        // Button for current location
        alignment: Alignment.center,
        child: ButtonTheme(
          minWidth: MediaQuery.of(context).size.width * 0.6,
          height: 45,
          child: RaisedButton.icon(
            label: Text(
              text,
              style: TextStyle(color: Colors.white),
            ),
            color: otherColor,
            onPressed: function,
            icon: Icon(icon, color: Colors.white),
          ),
        ),
      );
    }
    return InkWell(
      onTap: () {
        setState(() {
          _isEditingText = true;
        });
      },
      child: Container(
        // Button for current location
        alignment: Alignment.center,
        child: ButtonTheme(
          minWidth: MediaQuery.of(context).size.width * 0.6,
          height: 45,
          child: RaisedButton.icon(
            label: Text(
              text,
              style: TextStyle(color: Colors.white),
            ),
            color: otherColor,
            onPressed: function,
            icon: Icon(icon, color: Colors.white),
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
                TextInputType.multiline),
            customButton(
              'Change Color',
              handleColorPicker,
              Icons.history,
            ),
            SizedBox(
              height: 50,
            ),
            Text(DateFormat.Hm().format(time.toDate())),
          ],
        )
      ],
    );
  }

  handleSubmitCompleteTask() async {
    setState(() {
      isUploading = true;
    });
    updateIsCompletedTask(
      isCompleted: isCompleted,
    );
    setState(() {
      isUploading = false;
      // Navigator.pop(context);
    });
  }

  updateIsCompletedTask({
    bool isCompleted,
  }) {
    tasksRef
        .doc(currentUser.id)
        .collection("userTasks")
        .doc(tasksId)
        .update({
      "isCompleted": isCompleted,
    });
  }

  Future<dynamic> checkIsCompletedStatus() async {
    DocumentSnapshot snapshot = await tasksRef
        .doc(currentUser.id)
        .collection('userTasks')
        .doc(tasksId)
        .get();
    return snapshot.data()['isCompleted']; 
  }

  changeItToFalse() {
    handleSubmitCompleteTask();
  }

  void configureIsCompleted(bool value) {
    if (value) {
      handleSubmitCompleteTask();
    } else {
      changeItToFalse();
    }
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
                    DateFormat.MMM().format(time.toDate()),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                  Text(
                    DateFormat.d().format(time.toDate()),
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
                  location,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            Expanded(
              child: Container(
                child: FutureBuilder(
                  future: checkIsCompletedStatus(),
                  builder: (context, snapshot) {
                    return CheckboxListTile(
                      value: isCompleted,
                      onChanged: (bool value) {
                        setState(() {
                          isCompleted = value;
                        });
                        configureIsCompleted(isCompleted);
                      },
                    );
                  },
                ),
              ),
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
        .doc(currentUser.id)
        .collection(tasksId)
        .doc(subTaskId)
        .set({
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
            .doc(currentUser.id)
            .collection(tasksId)
            .orderBy("timestamp", descending: true)
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
                    color: Colors.brown[200],
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

  handleSubmitNotifyMe() {
    setState(() {
      isUploading = true;
    });
    createNotifyMeData(
      notifyMe: isSwitched,
    );
    setState(() {
      isUploading = false;
    });
  }

  createNotifyMeData({
    bool notifyMe,
  }) {
    notifyMeRef
        .doc(currentUser.id)
        .collection(tasksId)
        .doc('Notify Me reminder')
        .set({
      "notifyMe": notifyMe,
      "tasksId": tasksId,
      "ownerId": currentUser.id,
      "username": currentUser.username,
      "timestamp": timestamp,
    });
  }

  deleteNotifyMeDocument() {
    notifyMeRef
        .doc(currentUser.id)
        .collection(tasksId)
        .doc('Notify Me reminder')
        .get()
        .then((value) => {
              if (value.exists)
                {
                  value.reference.delete(),
                }
            });
  }

  Future<dynamic> checkNotifyMeStatus() async {
    DocumentSnapshot snapshot = await notifyMeRef
        .doc(currentUser.id)
        .collection(tasksId)
        .doc('Notify Me reminder')
        .get();
    return snapshot.data()['notifyMe']; 
  }

  toggleButtonReminder() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      child: FutureBuilder(
          future: checkNotifyMeStatus(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done &&
                snapshot.hasData) {
              bool isSwitched = snapshot.data;
              return SwitchListTile.adaptive(
                title: Text('Notify Me'),
                value: isSwitched,
                onChanged: (bool value) {
                  setState(() {
                    isSwitched = value;
                  });
                  configureNotifyMe(value);
                },
                secondary: const Icon(Icons.lightbulb_outline),
              );
            } else if (snapshot.data == null) {
              return SwitchListTile.adaptive(
                title: Text('Notify Me'),
                value: isSwitched,
                onChanged: (bool value) {
                  setState(() {
                    isSwitched = value;
                  });
                  configureNotifyMe(value);
                },
                secondary: const Icon(Icons.lightbulb_outline),
              );
            } else {
              return Center(child: circularProgress());
            }
          }),
    );
  }

  void configureNotifyMe(bool value) {
    DateTime notifyMeTime = time.toDate().subtract(Duration(minutes: 30));
    // DateTime notifyMeTime = DateTime.now().add(Duration(seconds: 5));
    if (value) {
      handleSubmitNotifyMe();
      scheduleNotification(
          flutterLocalNotificationsPlugin, '1', name, notifyMeTime);
    } else {
      deleteNotifyMeDocument();
      turnOffNotificationById(flutterLocalNotificationsPlugin, 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: header(context,
          titleText: 'Task Details',
          backgroundColor: Theme.of(context).primaryColor,
          icons: IconButton(
            icon: Icon(Icons.check),
            onPressed: isUploading ? null : () => handleUpdateSubmit(),
          )),
      body: Container(
        decoration: BoxDecoration(color: Colors.grey[200]),
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
      subTaskId: doc.data()['subTaskId'],
      subTaskName: doc.data()['subTaskName'],
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
