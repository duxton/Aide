import 'package:AideApp/Widgets/Re-usable/header.dart';
import 'package:AideApp/Widgets/Re-usable/progress.dart';

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

  addTask() {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 50,
        ),
        Center(
            child: CircleAvatar(
                maxRadius: 50,
                backgroundColor: Colors.white70,
                child: CircleAvatar(
                  maxRadius: 50,
                  child: Icon(
                    Icons.add_to_photos,
                    size: 50,
                  ),
                  backgroundColor: Colors.indigo[700],
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
            customTextField(
              "Date",
              Icon(
                Icons.date_range,
                color: Colors.orange,
                size: 35,
              ),
              dateController,
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
                  color: Colors.blue,
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
      backgroundColor: Colors.indigo[700],
      appBar: header(context,
          titleText: 'Add Task', backgroundColor: Colors.indigo[700]),
      body: addTask(),
    );
  }
}
