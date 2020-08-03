// import 'dart:html';

// import 'package:AideApp/Model/email_authentication.dart';
// import 'package:AideApp/Widgets/Re-usable/header.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class LogIn extends StatefulWidget {

//   LogIn({this.auth, this.loginCallback});

//   final BaseAuth auth;
//   final VoidCallback loginCallback;
//   @override
//   _LogInState createState() => _LogInState();
// }

// class _LogInState extends State<LogIn> {
//   @override
//   Widget build(BuildContext context) {
//     TextEditingController emailController = TextEditingController();
//     TextEditingController passwordController = TextEditingController();
//     String _errorMessage;
//     bool _isLoading;

//     customTextField(String text, sideIcon, controller, inputType, obscureText) {
//       return Padding(
//         padding: const EdgeInsets.all(15.0),
//         child: ListTile(
//           // ListTile for input where was the photo was taken
//           leading: sideIcon,
//           title: Container(
//             width: 250.0,
//             child: TextField(
//               obscureText: obscureText,
//               style: TextStyle(color: Colors.grey),
//               controller: controller,
//               keyboardType: inputType,
//               decoration: InputDecoration(
//                 hintText: text,
//                 border: InputBorder.none,
//                 hintStyle: TextStyle(color: Colors.grey),
//               ),
//             ),
//           ),
//         ),
//       );
//     }

//     bool validateAndSave() {
//       final form = 
//     }

//     void validateAndSubmit() async {
//       setState(() {
//         _errorMessage = "";
//         _isLoading = true;
//       });
//       if(validateAndSave()) {}
//     }

//     return Scaffold(
//       appBar: header(context, titleText: 'Log In'),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: <Widget>[
//           SizedBox(height: 20,),
//           CircleAvatar( // TODO:: Logo
//             radius: 100,
//           ),
//           SizedBox(height: 50,),
//           customTextField(
//             'Email',
//             Icon(Icons.email),
//             emailController,
//             TextInputType.emailAddress,
//             false,
//           ),
//           customTextField(
//             'Password',
//             Icon(Icons.lock),
//             passwordController,
//             TextInputType.visiblePassword,
//             true,
//           ),
//           Container(
//             alignment: Alignment.center,
//             child: ButtonTheme(
//               minWidth: MediaQuery.of(context).size.width * 0.8,
//               height: 50,
//               child: RaisedButton.icon(
//                 label: Text(
//                   "Log In",
//                   style: TextStyle(color: Colors.white),
//                 ),
//                 color: Theme.of(context).accentColor,
//                 onPressed: () {},
//                 icon: Icon(Icons.email, color: Colors.white),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
