import 'package:AideApp/Model/email_authentication.dart';
import 'package:flutter/material.dart';

class EditProfile extends StatefulWidget {
  EditProfile({Key key, this.auth, this.userId, this.onSignedOut})
      : super(key: key);

  final BaseAuth auth;
  final VoidCallback onSignedOut;
  final String userId;
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  // logout() async {
  //   await googleSignIn.signOut();
  //   Navigator.pushReplacement(
  //       context, MaterialPageRoute(builder: (context) => Home()));
  // }

  customTextField(String text, controller, labelText) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: ListTile(
        // ListTile for input where was the photo was taken
        title: Container(
          width: 250.0,
          child: TextField(
            style: TextStyle(color: Colors.black),
            controller: controller,
            decoration: InputDecoration(
              labelText: labelText,
              labelStyle: TextStyle(color: Colors.black),
              hintText: text,
              hintStyle: TextStyle(color: Colors.grey),
            ),
          ),
        ),
      ),
    );
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController dateOfBirthController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController jobTitleController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit profile'),
        flexibleSpace: Image(
          image: AssetImage('assets/images/woodenTexture.jpg'),
          fit: BoxFit.cover,
        ),
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 25,
          ),
          CircleAvatar(
            radius: 75,
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    customTextField("Name", nameController, 'Name'),
                    customTextField("Date of birth", dateOfBirthController,
                        'Date Of Birth'),
                    customTextField(
                        "Phone number", phoneNumberController, 'Phone number'),
                    customTextField(
                        "Job Title", jobTitleController, 'Job Title'),
                  ],
                ),
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: ButtonTheme(
              shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0)),
              minWidth: MediaQuery.of(context).size.width * 0.8,
              height: 50,
              child: RaisedButton.icon(
                label: Text(
                  "Update Profile",
                  style: TextStyle(color: Colors.black),
                ),
                color: Colors.grey[200],
                onPressed: () {},
                icon: Icon(Icons.update, color: Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
