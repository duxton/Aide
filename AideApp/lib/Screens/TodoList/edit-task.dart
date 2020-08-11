import 'package:AideApp/Model/user.dart';
import 'package:AideApp/Screens/Home.dart';
import 'package:AideApp/Widgets/Re-usable/header.dart';
import 'package:AideApp/Widgets/Re-usable/progress.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_rounded_date_picker/rounded_picker.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
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
  TextEditingController locationController = TextEditingController();
  bool isUploading = false;
  DateTime dateTime;
  DateTime newDateTime;
  TimeOfDay newTime;
  String tasksId = Uuid().v4();
  bool expanded = false;

  Color pickerColor = Color(0xff443a49);
  Color currentColor = Color(0xff443a49);

  Color backgroundColorPicker = Color(0xffF5F5DC);

// ValueChanged<Color> callback
  void changeColor(Color color) {
    setState(() => pickerColor = color);
  }

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
          style: TextStyle(color: Colors.black),
          controller: controller,
          decoration: InputDecoration(
            hintText: text,
            border: InputBorder.none,
            hintStyle: TextStyle(color: Colors.black),
          ),
        ),
      ),
    );
  }

  handlesSubmit() async {
    setState(() {
      isUploading = true;
    });
    DateTime date = await datePicker();
    String time = await timePicker();
    String color = await colorPicker();
    bool isCompleted = false;
    createPostInFirestore(
      name: nameController.text,
      notes: noteController.text,
      description: descriptionController.text,
      color: color,
      newDateTime: date,
      newTime: time,
      isCompleted: isCompleted,
      location: locationController.text,
    );
    nameController.clear();
    noteController.clear();
    descriptionController.clear();
    colourController.clear();
    locationController.clear();
    setState(() {
      isUploading = false;
      tasksId = Uuid().v4();
      Navigator.pop(context);
    });
  }

  createPostInFirestore({
    String name,
    String notes,
    String description,
    DateTime newDateTime,
    String location,
    String newTime,
    String color,
    bool isCompleted,
  }) {
    tasksRef
        .document(widget.currentUser.id)
        .collection("userTasks")
        .document(tasksId)
        .setData({
      "name": name,
      "tasksId": tasksId,
      "ownerId": widget.currentUser.id,
      "username": widget.currentUser.username,
      "date": newDateTime,
      "time": dateTime,
      "colour": color,
      "location": location,
      "notes": notes,
      "description": description,
      "timestamp": timestamp,
      "isCompleted": isCompleted,
    });
  }

  handleDatePicker() async {
    DateTime newDateTime = await showRoundedDatePicker(
      context: context,
      initialDatePickerMode: DatePickerMode.day,
      theme: ThemeData(primaryColor:backgroundColorPicker ),
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

  handleTimePicker() async {
    TimeOfDay newTime = await showRoundedTimePicker(
        context: context,
        theme: ThemeData(primaryColor: backgroundColorPicker),
        initialTime: TimeOfDay.now(),
        leftBtn: "NOW",
        onLeftBtn: () {
          Navigator.of(context).pop(TimeOfDay.now());
        });
    if (newTime != null) {
      setState(() {
        dateTime = DateTime(
          newDateTime.year,
          newDateTime.month,
          newDateTime.day,
          newTime.hour,
          newTime.minute,
        );
      });
    }
  }

  Future<String> timePicker() async {
    print(dateTime);
    return dateTime.toString();
  }

  customButton(text, function, icon) {
    return Container(
      alignment: Alignment.center,
      child: ButtonTheme(
        minWidth: MediaQuery.of(context).size.width * 0.6,
        height: 45,
        child: RaisedButton.icon(
          label: Text(
            text,
            style: TextStyle(color: Colors.white),
          ),
          color: Theme.of(context).accentColor,
          onPressed: function,
          icon: Icon(icon, color: Colors.white),
        ),
      ),
    );
  }

  dropdownContainer() {
    return Column(
      children: <Widget>[
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: expanded ? 150 : 0,
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: customButton(
                  'Add location',
                  getUserLocation,
                  Icons.my_location,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Expanded(
                flex: 1,
                child: customButton(
                  'Add color',
                  handleColorPicker,
                  Icons.add,
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
      ],
    );
  }

  addTask() {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 15,
        ),
        Center(
            child: CircleAvatar(
                maxRadius: 50,
                backgroundColor: Colors.grey[350],
                child: CircleAvatar(
                  maxRadius: 50,
                  child: Icon(
                    Icons.add_to_photos,
                    size: 50,
                    color: Colors.white,
                  ),
                  backgroundColor:Colors.grey[350],
                ))),
        SizedBox(
          height: 30,
        ),
        Column(
          children: <Widget>[
            customTextField(
                "Name",
                Icon(
                  Icons.work,
                  color: Colors.brown[200],
                  size: 35,
                ),
                nameController),
            customTextField(
              "Description",
              Icon(
                Icons.description,
                 color: Colors.brown[200],
                size: 35,
              ),
              descriptionController,
            ),
            customTextField(
              "Location",
              Icon(
                Icons.location_on,
                 color: Colors.brown[200],
                size: 35,
              ),
              locationController,
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
              height: 15,
            ),
            customButton(
              'Add time',
              handleTimePicker,
              Icons.timer,
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
        dropdownContainer(),
        SizedBox(
          height: 15,
        ),
        Container(
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
    );
  }

  getUserLocation() async {
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    List<Placemark> placemarks = await Geolocator()
        .placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark placemark = placemarks[0];
    String completeAddress =
        '${placemark.subThoroughfare} ${placemark.thoroughfare}, ${placemark.subLocality} ${placemark.locality}, ${placemark.subAdministrativeArea}, ${placemark.administrativeArea} ${placemark.postalCode}, ${placemark.country}';
    print(completeAddress);
    String formattedAddress = "${placemark.locality}, ${placemark.country}";
    locationController.text = formattedAddress;
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
           color: Colors.white),
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