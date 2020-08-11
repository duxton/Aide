// import 'package:flutter/material.dart';
// TODO:: Fix this with other login functionalities such as fb and google 
// import 'Registration/login_signup_page.dart';

// class UnAuthScreen extends StatefulWidget {
//   @override
//   _UnAuthScreenState createState() => _UnAuthScreenState();
// }

// class _UnAuthScreenState extends State<UnAuthScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: BoxDecoration(
//             gradient: LinearGradient(
//           begin: Alignment.topRight,
//           end: Alignment.bottomLeft,
//           colors: [
//             Theme.of(context).accentColor,
//             Theme.of(context).primaryColor,
//           ],
//         )),
//         alignment: Alignment.center,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: <Widget>[
//             Text('FlutterShare',
//                 style: TextStyle(
//                   fontFamily: "Signatra",
//                   fontSize: 90,
//                   color: Colors.white,
//                 )),
//             // GestureDetector(
//             //   onTap: () {
//             //     login();
//             //   },
//             //   child: Container(
//             //     width: 260.0,
//             //     height: 60.0,
//             //     decoration: BoxDecoration(
//             //       image: DecorationImage(
//             //         image: AssetImage('assets/images/google_signin_button.png'),
//             //         fit: BoxFit.cover,
//             //       ),
//             //     ),
//             //   ),
//             // ),
//             SizedBox(
//               height: 25,
//             ),
//             GestureDetector(
//               onTap: () {
//                 Navigator.push(context,
//                     MaterialPageRoute(builder: (context) => LoginSignUpPage()));
//               },
//               child: Container(
//                 width: 260.0,
//                 height: 60.0,
//                 child: Center(
//                   child: Text(
//                     'Log In with email',
//                     style: TextStyle(fontSize: 25),
//                   ),
//                 ),
//                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(25),
//                     color: Colors.grey),
//               ),
//             ),
//             SizedBox(
//               height: 25,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }