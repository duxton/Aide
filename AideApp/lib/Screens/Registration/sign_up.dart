import 'package:AideApp/Widgets/Re-usable/header.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  customTextField(String text, sideIcon, controller, inputType, obscureText) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: ListTile(
        // ListTile for input where was the photo was taken
        leading: sideIcon,
        title: Container(
          width: 250.0,
          child: TextField(
            obscureText: obscureText,
            style: TextStyle(color: Colors.grey),
            controller: controller,
            keyboardType: inputType,
            decoration: InputDecoration(
              hintText: text,
              border: InputBorder.none,
              hintStyle: TextStyle(color: Colors.grey),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(context, titleText: 'Sign Up'),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          CircleAvatar( // TODO:: Logo
            radius: 100,
          ),
          SizedBox(
            height: 50,
          ),
          customTextField(
            'Email',
            Icon(Icons.email),
            emailController,
            TextInputType.emailAddress,
            false,
          ),
          customTextField(
            'Password',
            Icon(Icons.security),
            passwordController,
            TextInputType.visiblePassword,
            true,
          ),
          customTextField(
            'Repeat Password',
            Icon(Icons.security),
            passwordController,
            TextInputType.visiblePassword,
            true,
          ),
          Container(
            alignment: Alignment.center,
            child: ButtonTheme(
              minWidth: MediaQuery.of(context).size.width * 0.8,
              height: 50,
              child: RaisedButton.icon(
                label: Text(
                  "Sign Up",
                  style: TextStyle(color: Colors.white),
                ),
                color: Theme.of(context).accentColor,
                onPressed: () {},
                icon: Icon(Icons.email, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
