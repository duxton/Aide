import 'package:AideApp/Model/email_authentication.dart';
import 'package:AideApp/Screens/Calendar/TableCalendar.dart';
import 'package:AideApp/Screens/Home.dart';
import 'package:AideApp/Screens/OwnedProduct/AllProduct.dart';
import 'package:AideApp/Screens/OwnedProduct/FinancialAdvisor/Add_Card.dart';
import 'package:AideApp/Screens/OwnedProduct/FinancialAdvisor/Add_Transactions.dart';
import 'package:AideApp/Screens/TodoList/view-task.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:AideApp/Screens/OwnedProduct/FinancialAdvisor/FinancialAdvisor.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import 'Model/notification_helper.dart';
import 'Screens/Alarm/enums.dart';
import 'Screens/Alarm/model/menuInfo.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

  NotificationAppLaunchDetails notificationAppLaunchDetails;


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  notificationAppLaunchDetails =
      await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
  await initNotifications(flutterLocalNotificationsPlugin);
  requestIOSPermissions(flutterLocalNotificationsPlugin);
  
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlutterShare',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: Color.fromRGBO(0, 0, 1, 1),
          accentColor: Color.fromRGBO(105, 105, 105, 1)),
      routes: {
        FinancialAssistance.routeName: (ctx) => FinancialAssistance(),
        AllProduct.routeName: (ctx) => AllProduct(),
        ViewTask.routeName: (ctx) => ViewTask(),
        AddCard.routeName: (ctx) => AddCard(),
        AddTransactions.routeName: (ctx) => AddTransactions(),
        Calendar.routeName: (ctx) => Calendar(),
      },
      home: ChangeNotifierProvider<MenuInfo>(
        create: (context) => MenuInfo(MenuType.clock),
        child: Home( auth: new Auth(),),
      ),
    );
  }
}
