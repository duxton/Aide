import 'package:AideApp/Model/email_authentication.dart';
import 'package:AideApp/Screens/Registration/edit_profile.dart';
import 'package:flutter/material.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:google_sign_in/google_sign_in.dart';

class ViewProfile extends StatefulWidget {
  ViewProfile({Key key, this.auth, this.userId, this.onSignedOut})
      : super(key: key);

  final BaseAuth auth;
  final VoidCallback onSignedOut;
  final String userId;
  @override
  _ViewProfileState createState() => _ViewProfileState();
}

class _ViewProfileState extends State<ViewProfile> {


  customDisplayText(sideIcon, String text) {
    return ListTile(
      // ListTile for input where was the photo was taken
      leading: sideIcon,
      title: Container(
        width: 250.0,
        child: Text(
          text,
          style: TextStyle(color: Colors.blueGrey),
        ),
      ),
    );
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController dateOfBirthController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController jobTitleController = TextEditingController();
  final GoogleSignIn googleSignIn = GoogleSignIn();

  Color colorsIcon = Colors.blueGrey;


  _signOut() async {
    try {
      await widget.auth.signOut();
      widget.onSignedOut();
    } catch (e) {
      print(e);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: new Text(
            'Aide',
            style: TextStyle(color: Colors.black),
          ),
          actions: <Widget>[
            new IconButton(
              color: Colors.black,
              icon: Icon(Icons.exit_to_app),
              onPressed: _signOut,
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
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              EditProfile(auth: widget.auth)));
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
                      customDisplayText(
                          Icon(
                            Icons.people,
                            color: colorsIcon,
                            size: 35,
                          ),
                        "Duxton"),
                      customDisplayText(
                          Icon(
                            Icons.date_range,
                            color: colorsIcon,
                            size: 35,
                          ),
                          "09-07-2000"),
                      customDisplayText(
                          Icon(
                            Icons.phone,
                            color: colorsIcon,
                            size: 35,
                          ),
                          "0192269129"),
                      customDisplayText(
                          Icon(
                            Icons.work,
                            color: colorsIcon,
                            size: 35,
                          ),
                          "Software Engineer"),
                     
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
