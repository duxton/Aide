import 'package:AideApp/Model/user.dart';
import 'package:AideApp/Widgets/Re-usable/header.dart';

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class TaskDetails extends StatefulWidget {
  final User currentUser;

  TaskDetails({this.currentUser});
  @override
  _TaskDetailsState createState() => _TaskDetailsState();
}

class _TaskDetailsState extends State<TaskDetails>
    with SingleTickerProviderStateMixin {

      

  TabController _tabController;
  @override
  void initState() {
    _tabController = new TabController(length: 3, vsync: this);
    super.initState();
  }

  TextEditingController descriptionController = TextEditingController();
  TextEditingController colourController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  bool isUploading = false;

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
              "Description",
              Icon(
                Icons.description,
                color: Colors.grey,
                size: 20,
              ),
              descriptionController,
            ),
            customTextField(
                "Colour code",
                Icon(
                  Icons.color_lens,
                  color: Colors.grey,
                  size: 20,
                ),
                colourController),
            SizedBox(
              height: 50,
            ),
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
                    'JAN',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                  Text(
                    '19',
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
                  'Designing consulting',
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                      color: Colors.black),
                ),
                Text(
                  'HQ AideShare',
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
              child: Text(
                'FILENAME',
                style: TextStyle(color: Colors.black),
              ),
            ),
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
                              child: Text("Files"),
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
        title: const Text('Notify Me'),
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
        titleText: 'Details',
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
