import 'package:AideApp/Screens/Home.dart';
import 'package:AideApp/Screens/OwnedProduct/AllProduct.dart';
import 'package:AideApp/Screens/OwnedProduct/FinancialAdvisor/Add_Card.dart';
import 'package:AideApp/Screens/OwnedProduct/FinancialAdvisor/Add_Transactions.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:AideApp/Screens/OwnedProduct/FinancialAdvisor/FinancialAdvisor.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import 'Screens/Alarm/enums.dart';
import 'Screens/Alarm/model/menuInfo.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  var initializationSettingsAndroid =
      AndroidInitializationSettings('codex_logo');
  var initializationSettingsIOS = IOSInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification:
          (int id, String title, String body, String payload) async {});
  var initializationSettings = InitializationSettings(
      initializationSettingsAndroid, initializationSettingsIOS);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: (String payload) async {
    if (payload != null) {
      debugPrint('notification payload: ' + payload);
    }
  });
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
          accentColor: Color.fromRGBO(192, 192, 192, 0.5)),
      routes: {
        FinancialAssistance.routeName: (ctx) => FinancialAssistance(),
        AllProduct.routeName: (ctx) => AllProduct(),
        AddCard.routeName: (ctx) => AddCard(),
        AddTransactions.routeName: (ctx) => AddTransactions(),
      },
      home: ChangeNotifierProvider<MenuInfo>(
        create: (context) => MenuInfo(MenuType.clock),
        child: Home(),
      ),
    );
  }
}
