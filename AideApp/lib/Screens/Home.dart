import 'package:AideApp/Model/email_authentication.dart';
import 'package:AideApp/Model/tasks.dart';
import 'package:AideApp/Model/user.dart';
import 'package:AideApp/Screens/Registration/login_signup_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'AuthScreen.dart';
import 'Registration/create_account.dart';

// final GoogleSignIn googleSignIn = GoogleSignIn();
final StorageReference storageRef = FirebaseStorage.instance.ref();
final usersRef = Firestore.instance.collection('users');
final tasksRef = Firestore.instance.collection('tasks');
final subTasksRef = Firestore.instance.collection('sub-tasks');
final notifyMeRef = Firestore.instance.collection('notify-me');
final notificationTaskRef = Firestore.instance.collection('Notification-tasks');
final DateTime timestamp = DateTime.now();
User currentUser;
Task tasksInfo;

enum AuthStatus {
  NOT_DETERMINED,
  NOT_LOGGED_IN,
  LOGGED_IN,
}

class Home extends StatefulWidget {
  Home({this.auth});

  final BaseAuth auth;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  AuthStatus authStatus = AuthStatus.NOT_DETERMINED;
  String _userId = "";

  @override
  void initState() {
    super.initState();

  
    //Dectects when user sign in
    // googleSignIn.onCurrentUserChanged.listen((account) {
    //   handleSignIn(account);
    // }, onError: (err) {
    //   print('Error Signing in: $err');
    // });
    widget.auth.getCurrentUser().then((user) {
      setState(() {
        if (user != null) {
          _userId = user?.uid;
          print("Current User: " + _userId);
          print("Current email: " + user.email);
  
          createUserInFirestore();
        }
        authStatus =
            user?.uid == null ? AuthStatus.NOT_LOGGED_IN : AuthStatus.LOGGED_IN;
      });
    });
    // Reaauthenticate user when app is opened ( works like token )
    // googleSignIn.signInSilently(suppressErrors: false).then((account) {
    //   handleSignIn(account);
    // }).catchError((err) {
    //   print(err);
    // });
  }

    createUserInFirestore() async { 
    // 1) check if user exist in users collection in database according to their id
    final FirebaseUser user = await FirebaseAuth.instance.currentUser();
   //This is where u get current user using googleSignIn
    DocumentSnapshot doc = await usersRef.document(user.uid).get();

    // 2) if user doesnt exist then take htem to create account page
    if (!doc.exists) {
      final username = await Navigator.push(
          context, MaterialPageRoute(builder: (context) => CreateAccount()));

      // 3) get username from create acccount and use it to make new user document in users collection
      usersRef.document(user.uid).setData({
        "id": user.uid,
        "username": username,
        "photoUrl": user.photoUrl,
        "email": user.email,
        "displayName": user.displayName,
        "bio": "",
        "timestamp": timestamp
      });
      //make new user their own follower (to include their post in their timeline)

      doc = await usersRef.document(user.uid).get();
    }
    currentUser = User.fromDocument(doc);
  }
 

  // @override
  // void dispose() {
  //   pageController.dispose();
  //   super.dispose();
  // }

// ** Temperory disable functions
 // login() {
  //   googleSignIn.signIn();
  // }

  // createUserInFirestore() async { 
  //   // 1) check if user exist in users collection in database according to their id
  //   final GoogleSignInAccount user = googleSignIn
  //       .currentUser; //This is where u get current user using googleSignIn
  //   DocumentSnapshot doc = await usersRef.document(user.id).get();

  //   // 2) if user doesnt exist then take htem to create account page
  //   if (!doc.exists) {
  //     final username = await Navigator.push(
  //         context, MaterialPageRoute(builder: (context) => CreateAccount()));

  //     // 3) get username from create acccount and use it to make new user document in users collection
  //     usersRef.document(user.id).setData({
  //       "id": user.id,
  //       "username": username,
  //       "photoUrl": user.photoUrl,
  //       "email": user.email,
  //       "displayName": user.displayName,
  //       "bio": "",
  //       "timestamp": timestamp
  //     });
  //     //make new user their own follower (to include their post in their timeline)

  //     doc = await usersRef.document(user.id).get();
  //   }
  //   currentUser = User.fromDocument(doc);
  // }


  // handleSignIn(GoogleSignInAccount account) async {
  //   if (account != null) { 
  //     await createUserInFirestore();
  //     print(account);
  //     setState(() {
  //       isAuth = true;
  //     });
  //   } else {
  //     setState(() {
  //       isAuth = false;
  //     });
  //   }
  // }

  // logout() {
  //   googleSignIn.signOut();
  // }


  void _onLoggedIn() {
    widget.auth.getCurrentUser().then((user){
      setState(() {
        _userId = user.uid.toString();
        print("Current User" + _userId);
      });
    });
    setState(() {
      authStatus = AuthStatus.LOGGED_IN;

    });
  }

  void _onSignedOut() {
    setState(() {
      authStatus = AuthStatus.NOT_LOGGED_IN;
      _userId = "";
    });
  }



  Widget _buildWaitingScreen() {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // return isAuth ? buildAuthScreen() : buildUnAuthScreen();
    switch (authStatus) {
      case AuthStatus.NOT_DETERMINED:
        return _buildWaitingScreen();
        break;
      case AuthStatus.NOT_LOGGED_IN:
        return new LoginSignUpPage(
           auth: widget.auth,
          onSignedIn: _onLoggedIn,
        );
        break;
      case AuthStatus.LOGGED_IN:
        if (_userId.length > 0 && _userId != null) {
          return new AuthScreen(
             userId: _userId,
            auth: widget.auth,
            onSignedOut: _onSignedOut,
          );
        } else
          return _buildWaitingScreen();
        break;
      default:
        return _buildWaitingScreen();
    }
  }
}
