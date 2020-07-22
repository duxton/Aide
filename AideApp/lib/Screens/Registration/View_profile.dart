import 'package:AideApp/Screens/Registration/edit_profile.dart';
import 'package:AideApp/Widgets/Re-usable/header.dart';
import 'package:flutter/material.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';

class ViewProfile extends StatefulWidget {
  @override
  _ViewProfileState createState() => _ViewProfileState();
}

class _ViewProfileState extends State<ViewProfile> {
  customTextField(String text, sideIcon, controller) {
    return ListTile(
      // ListTile for input where was the photo was taken
      leading: sideIcon,
      title: Container(
        width: 250.0,
        child: TextField(
          style: TextStyle(color: Colors.grey),
          controller: controller,
          decoration: InputDecoration(
            hintText: text,
            border: InputBorder.none,
            hintStyle: TextStyle(color: Colors.blueGrey),
          ),
        ),
      ),
    );
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController dateOfBirthController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController jobTitleController = TextEditingController();

  Color colorsIcon = Colors.blueGrey;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.edit),
          onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfile()));
          },
        ),
        backgroundColor: Colors.transparent,
        flexibleSpace: Image(
          image: AssetImage('assets/images/macbookProductive.jpeg'),
          fit: BoxFit.cover,
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.center_focus_strong),
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height * 0.80,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: ListTile(
                      title: Text('Duxton Lim Yee Cheng'),
                      subtitle: Text('duxtonlim2000@gmail.com'),
                    ),
                  ),
                  CircularProfileAvatar(
                    'https://avatars0.githubusercontent.com/u/8264639?s=460&v=4', //sets image path, it should be a URL string. default value is empty string, if path is empty it will display only initials
                    radius: 70, // sets radius, default 50.0
                    backgroundColor: Colors
                        .transparent, // sets background color, default Colors.white
                    borderWidth: 10, // sets border, default 0.0
                    initialsText: Text(
                      "DL",
                      style: TextStyle(fontSize: 40, color: Colors.white),
                    ), // sets initials text, set your own style, default Text('')
                    borderColor:
                        Colors.grey, // sets border color, default Colors.white
                    elevation:
                        5.0, // sets elevation (shadow of the profile picture), default value is 0.0
                    foregroundColor: Colors.grey.withOpacity(
                        0.5), //sets foreground colour, it works if showInitialTextAbovePicture = true , default Colors.transparent
                    cacheImage:
                        true, // allow widget to cache image against provided url
                    onTap: () {
                      print('Duxton');
                    }, // sets on tap
                    showInitialTextAbovePicture:
                        true, // setting it true will show initials text above profile picture, default false
                  ),
                ],
              ),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      customTextField(
                          "Name",
                          Icon(
                            Icons.people,
                            color: colorsIcon,
                            size: 35,
                          ),
                          nameController),
                      customTextField(
                          "Date of birth",
                          Icon(
                            Icons.date_range,
                            color: colorsIcon,
                            size: 35,
                          ),
                          dateOfBirthController),
                      customTextField(
                          "Phone number",
                          Icon(
                            Icons.phone,
                            color: colorsIcon,
                            size: 35,
                          ),
                          phoneNumberController),
                      customTextField(
                          "Job Title",
                          Icon(
                            Icons.work,
                            color: colorsIcon,
                            size: 35,
                          ),
                          jobTitleController),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
