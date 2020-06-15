import 'dart:ui';

import 'package:AideApp/Model/user.dart';
import 'package:AideApp/Screens/Home.dart';
import 'package:AideApp/Widgets/Re-usable/header.dart';
import 'package:AideApp/Widgets/Re-usable/progress.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_rounded_date_picker/rounded_picker.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class EditTask extends StatefulWidget {
  final User currentUser;

  EditTask({this.currentUser});

  @override
  _EditTaskState createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController colourController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  bool isUploading = false;
  DateTime dateTime;
  DateTime newDateTime;
  TimeOfDay newTime;
  String tasksId = Uuid().v4();
  bool expanded = false;

  @override
  void initState() {
    dateTime = DateTime.now();
    super.initState();
  }

  customTextField(String text, sideIcon, controller) {
    return ListTile(
      // ListTile for input where was the photo was taken
      leading: sideIcon,
      title: Container(
        width: 250.0,
        child: TextField(
          style: TextStyle(color: Colors.white),
          controller: controller,
          decoration: InputDecoration(
            hintText: text,
            border: InputBorder.none,
            hintStyle: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }

// 1) TODO::Handles submit data
  handlesSubmit() async {
    setState(() {
      isUploading = true;
    });
    DateTime date = await datePicker();
    String time = await timePicker();
    createPostInFirestore(
      notes: noteController.text,
      description: descriptionController.text,
      colour: colourController.text,
      newDateTime: date,
      newTime: time,
    );
    nameController.clear();
    noteController.clear();
    descriptionController.clear();
    colourController.clear();
    setState(() {
      isUploading = false;
      tasksId = Uuid().v4();
      Navigator.pop(context);
    });
  }

// TODO:: Covert string to timestamp https://stackoverflow.com/questions/53382971/how-to-convert-string-to-timeofday-in-flutter
// 2) Create database in firestore
  createPostInFirestore({
    String notes,
    String description,
    DateTime newDateTime,
    String newTime,
    String colour,
  }) {
    tasksRef
        .document(widget.currentUser.id)
        .collection("userTasks")
        .document(tasksId)
        .setData({
      "tasksId": tasksId,
      "ownerId": widget.currentUser.id,
      "username": widget.currentUser.username,
      "date": newDateTime,
      "time": newTime,
      "colour": colour,
      "notes": notes,
      "description": description,
      "timestamp": timestamp,
    });
  }

  handleDatePicker() async {
    DateTime newDateTime = await showRoundedDatePicker(
      context: context,
      initialDatePickerMode: DatePickerMode.day,
      theme: ThemeData(primarySwatch: Colors.purple),
    );
    if (newDateTime != null) {
      setState(() => this.newDateTime = newDateTime);
    }
  }

  Future<DateTime> datePicker() async {
    // future
    print('${dateTime.year}' + '${dateTime.month}' + '${dateTime.day}');
    return newDateTime;
  }

  handleTimePicker() async {
    TimeOfDay newTime = await showRoundedTimePicker(
        context: context,
        theme: ThemeData(primarySwatch: Colors.purple),
        initialTime: TimeOfDay.now(),
        leftBtn: "NOW",
        onLeftBtn: () {
          Navigator.of(context).pop(TimeOfDay.now());
        });
    if (newTime != null) {
      setState(() {
        this.newTime = newTime;
      });
    }
  }

  Future<String> timePicker() async {
    // future
    print(newTime);
    return newTime.toString();
  }

  customButton(text, function, icon) {
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
          color: Theme.of(context).primaryColor,
          onPressed: function,
          icon: Icon(icon, color: Colors.white),
        ),
      ),
    );
  }

  addTask() {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 25,
          ),
          Center(
              child: CircleAvatar(
                  maxRadius: 50,
                  backgroundColor: Theme.of(context).accentColor,
                  child: CircleAvatar(
                    maxRadius: 50,
                    child: Icon(
                      Icons.add_to_photos,
                      size: 50,
                    ),
                    backgroundColor: Theme.of(context).accentColor,
                  ))),
          SizedBox(
            height: 50,
          ),
          Column(
            children: <Widget>[
              customTextField(
                  "Name",
                  Icon(
                    Icons.work,
                    color: Colors.orange,
                    size: 35,
                  ),
                  nameController),
              customTextField(
                "Description",
                Icon(
                  Icons.description,
                  color: Colors.orange,
                  size: 35,
                ),
                descriptionController,
              ),
              SizedBox(
                height: 20,
              ),
              customButton(
                'Add Date',
                handleDatePicker,
                Icons.date_range,
              ),
              SizedBox(
                height: 20,
              ),
              customButton(
                'Add time',
                handleTimePicker,
                Icons.timer,
              ),
              SizedBox(
                height: 20,
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                height: expanded ? 150 : 0,
                child: Column(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: customButton(
                        'Add sub-task',
                        () {},
                        Icons.add,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Expanded(
                      flex: 1,
                      child: customButton(
                        'Add location',
                        () {},
                        Icons.location_on,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FloatingActionButton(
                    child: Icon(
                      expanded ? Icons.arrow_upward : Icons.arrow_downward,
                      color: Colors.white,
                    ),
                    onPressed: () => setState(() {
                      expanded = !expanded;
                    }),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                // Button for current location
                alignment: Alignment.center,
                child: ButtonTheme(
                  minWidth: MediaQuery.of(context).size.width * 0.8,
                  height: 50,
                  child: RaisedButton.icon(
                    label: Text(
                      "Add Task",
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Theme.of(context).accentColor,
                    onPressed: isUploading ? null : () => handlesSubmit(),
                    icon: Icon(Icons.add_box, color: Colors.white),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(
        context,
        titleText: 'Add Task',
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
              Theme.of(context).primaryColor,
              Theme.of(context).accentColor,
            ])),
        child: Column(
          children: <Widget>[
            isUploading ? linearProgress() : Text(""),
            addTask(),
          ],
        ),
      ),
    );
  }
}
