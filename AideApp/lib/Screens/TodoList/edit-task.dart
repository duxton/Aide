import 'package:AideApp/Widgets/Re-usable/header.dart';
import 'package:flutter_rounded_date_picker/rounded_picker.dart';
import 'package:flutter/material.dart';

class EditTask extends StatefulWidget {
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
  handleSubmit() {}
// 2) Create database in firestore 
   createPostInFirestore() {}


  datePicker() async {
    DateTime newDateTime = await showRoundedDatePicker(
      context: context,
      initialDatePickerMode: DatePickerMode.day,
      theme: ThemeData(primarySwatch: Colors.purple),
    );
    if (newDateTime != null) {
      setState(() => dateTime = newDateTime);
    }
    print('${dateTime.year}' + '${dateTime.month}' + '${dateTime.day}');

    return newDateTime;
  }

  timePicker() async {
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
        dateTime = DateTime(
          // Possibly using this to save to firestore
          dateTime.year,
          dateTime.month,
          dateTime.day,
          newTime.hour,
          newTime.minute,
        );
      });
    }
    print(newTime);
    return newTime;
  }

  addTask() {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 50,
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
            GestureDetector(
              onTap: datePicker,
              child: ListTile(
                title: Text(
                  'Choose date',
                  style: TextStyle(color: Colors.white),
                ),
                leading: Icon(
                  Icons.date_range,
                  size: 35,
                  color: Colors.orange,
                ),
              ),
            ),
            GestureDetector(
              onTap: timePicker,
              child: ListTile(
                title: Text(
                  'Choose time',
                  style: TextStyle(color: Colors.white),
                ),
                leading: Icon(
                  Icons.timer,
                  size: 35,
                  color: Colors.orange,
                ),
              ),
            ),
            customTextField(
                "Colour code",
                Icon(
                  Icons.color_lens,
                  color: Colors.orange,
                  size: 35,
                ),
                colourController),
            customTextField(
                'Notes',
                Icon(
                  Icons.note,
                  color: Colors.orange,
                  size: 35,
                ),
                noteController),
            SizedBox(
              height: 50,
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
                  onPressed: () {},
                  icon: Icon(Icons.add_box, color: Colors.white),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(context,
          titleText: 'Add Task',
          backgroundColor: Theme.of(context).primaryColor),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
              Theme.of(context).primaryColor,
              Theme.of(context).accentColor,
            ])),
        child: addTask(),
      ),
    );
  }
}
