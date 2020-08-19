import 'package:AideApp/Model/email_authentication.dart';
import 'package:AideApp/Screens/Registration/edit_profileDetails.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  _EditProfileState() {
    _emailFilter.addListener(_emailListen);
    // _passwordFilter.addListener(_passwordListen);
    _resetPasswordEmailFilter.addListener(_resetPasswordEmailListen);
  }
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

  final TextEditingController _emailFilter = new TextEditingController();
  final TextEditingController _resetPasswordEmailFilter =
      new TextEditingController();

  String _email = "";
  String _resetPasswordEmail = "";
  bool _isLoading;
  String _errorMessage;
  bool _isIos;
  bool expanded = false;
  bool emailExpanded = false;
  bool _isEmailVerified = false;

  @override
  void initState() {
    super.initState();
    _loadCurrentUser();
  }

  void _resetPasswordEmailListen() {
    if (_resetPasswordEmailFilter.text.isEmpty) {
      _resetPasswordEmail = "";
    } else {
      _resetPasswordEmail = _resetPasswordEmailFilter.text;
    }
  }

  // void _passwordListen() {
  //   if (_passwordFilter.text.isEmpty) {
  //     _password = "";
  //   } else {
  //     _password = _passwordFilter.text;
  //   }
  // }

  void _emailListen() {
    if (_emailFilter.text.isEmpty) {
      _email = "";
    } else {
      _email = _emailFilter.text;
    }
  }

  _showChangeEmailContainer() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: new BorderRadius.circular(30.0),
        color: Colors.amberAccent,
      ),
      padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
      child: Column(
        children: <Widget>[
          new TextFormField(
            controller: _emailFilter,
            decoration: new InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
              hintText: "Enter New Email",
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(22.0)),
            ),
          ),
          new MaterialButton(
            shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0)),
            onPressed: () {
// widget.auth.changeEmail("abc@gmail.com
              _changeEmail();
            },
            minWidth: MediaQuery.of(context).size.width,
            padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            color: Colors.blueAccent,
            textColor: Colors.white,
            child: Text(
              "Change Email",
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }


  void _changeEmail() { // TODO:: Verify thats its the same as the current user only allow changes
    if (_email != null && _email.isNotEmpty) {
      try {
        print("============>" + _email);
        widget.auth.changeEmail(_email);
      } catch (e) {
        print("============>" + e);
        setState(() {
          _isLoading = false;
          if (_isIos) {
            _errorMessage = e.details;
          } else
            _errorMessage = e.message;
        });
      }
    } else {
      print("email feild empty");
    }
  }

  dropdownEmailContainer() {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              child: ButtonTheme(
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0)),
                minWidth: MediaQuery.of(context).size.width * 0.8,
                height: 50,
                child: RaisedButton.icon(
                  label: Text(
                    "Change email",
                    style: TextStyle(color: Colors.black),
                  ),
                  color: Colors.grey[200],
                  onPressed: () => setState(() {
                    emailExpanded = !emailExpanded;
                  }),
                  icon: Icon(Icons.update, color: Colors.black),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 5,
        ),
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: emailExpanded ? 150 : 0,
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: _showChangeEmailContainer(),
              ),
            ],
          ),
        ),
      ],
    );
  }
FirebaseUser currentUser;

 void _loadCurrentUser() {
   FirebaseAuth.instance.currentUser().then((FirebaseUser user) {
     setState(() {
       currentUser = user;
     });
   });
 }

  void _sendResetPasswordMail() {
    if (_resetPasswordEmail != null && _resetPasswordEmail.isNotEmpty && _resetPasswordEmail == currentUser.email) {
      print("============>" + _resetPasswordEmail);
      widget.auth.sendPasswordResetMail(_resetPasswordEmail);
    } else {
      print("password field empty");
    }
  }

  _showSentResetPasswordEmailContainer() {
    return Column(
      children: <Widget>[
        new Container(
          child: new TextFormField(
            controller: _resetPasswordEmailFilter,
            decoration: new InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
              hintText: "Enter Email",
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(22.0)),
            ),
          ),
        ),
        new MaterialButton(
          shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(30.0)),
          onPressed: () {
            _sendResetPasswordMail();
          },
          minWidth: MediaQuery.of(context).size.width,
          padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          color: Colors.blueAccent,
          textColor: Colors.white,
          child: Text(
            "Send Password Reset Mail",
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  dropdownPasswordContainer() {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              child: ButtonTheme(
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0)),
                minWidth: MediaQuery.of(context).size.width * 0.8,
                height: 50,
                child: RaisedButton.icon(
                  label: Text(
                    "Change password",
                    style: TextStyle(color: Colors.black),
                  ),
                  color: Colors.grey[200],
                  onPressed: () => setState(() {
                    expanded = !expanded;
                  }),
                  icon: Icon(Icons.update, color: Colors.black),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 5,
        ),
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: expanded ? 150 : 0,
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: _showSentResetPasswordEmailContainer(),
              ),
            ],
          ),
        ),
      ],
    );
  }

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
          SizedBox(
            height: 25,
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
                  "Change profile details",
                  style: TextStyle(color: Colors.black),
                ),
                color: Colors.grey[200],
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EditProfileDetails()));
                },
                icon: Icon(Icons.update, color: Colors.black),
              ),
            ),
          ),
          SizedBox(
            height: 25,
          ),
          dropdownEmailContainer(),
          SizedBox(
            height: 25,
          ),
          dropdownPasswordContainer(),
        ],
      ),
    );
  }
}
