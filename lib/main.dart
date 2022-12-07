import 'package:argon_flutter/Responsive/widgetTreeEditReport.dart';
import 'package:argon_flutter/Responsive/widgetTreeSignin.dart';
import 'package:argon_flutter/Responsive/widgetTreecreateReport.dart';
import 'package:argon_flutter/models/userModel.dart';
import 'package:argon_flutter/screens/Reports.dart';
import 'package:argon_flutter/screens/animationWait.dart';
import 'package:argon_flutter/screens/home.dart';
import 'package:argon_flutter/screens/specificTimeTracking.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:argon_flutter/screens/notificationsPage.dart';
// screens
import 'package:argon_flutter/screens/onboarding.dart';
import 'package:argon_flutter/screens/pro.dart';
//import 'package:argon_flutter/screens/register.dart';
import 'package:argon_flutter/screens/elements.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'Responsive/widgetTreeTimeTracking.dart';
import 'Responsive/widgetTreeSpecificContract.dart';
import 'Responsive/widgetTreeContracts.dart';
import 'Responsive/widgetTreeRegisterProject.dart';
import 'Responsive/widgetTreeRegisterTime.dart';
import 'Responsive/widgetTreeEditTime.dart';
import 'Responsive/widgetTreeHome.dart';
import 'Responsive/widgetTreeModifyContract.dart';
import 'Responsive/widgetTreeModifyProject.dart';
import 'Responsive/widgetTreeProfile.dart';
import 'Responsive/widgetTreeProject.dart';
import 'Responsive/widgetTreeProjects.dart';
import 'Responsive/widgetTreeRegisContract.dart';
import 'Responsive/widgetTreeReport.dart';
import 'models/contractProvider.dart';
import 'models/projectProvider.dart';
import 'models/reportsProvider.dart';
import 'models/timeTrackingProvider.dart';

Future<void> backgroundHandler(RemoteMessage message) async {
  print(message.data.toString());
  print(message.notification.title);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  runApp(MyApp());
}

// ignore: must_be_immutable
class MyApp extends StatefulWidget {
  static bool darkStyle = false;

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();

    FirebaseMessaging.instance.getInitialMessage();

    //forground
    FirebaseMessaging.onMessage.listen((message) {
      if (message.notification != null) {
        print(message.notification.body);
        print(message.notification.title);
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      final routeFromMessage = message.data["route"];
      Navigator.pushNamed(context, routeFromMessage);
    });
  }

  int index = 0;
  @override
  Widget build(BuildContext context) {
    print(index);
    return MaterialApp(
        theme: temas[index],
        title: 'Midna App',
        //theme: ThemeData(fontFamily: 'OpenSans'),
        initialRoute: "/account",
        debugShowCheckedModeBanner: false,
        routes: <String, WidgetBuilder>{
          "/onboarding": (BuildContext context) => new Onboarding(),
          "/home": (BuildContext context) => new ChangeNotifierProvider(
              create: (context) => ProjectsProvider(),
              child: WidgetTreeProjects()),
          "/profiles": (BuildContext context) => new WidgetTreeProfiles(
                mainState: (i) => setState(() {
                  index = i;
                }),
              ),
          "/articles": (BuildContext context) => new Home(),
          "/elements": (BuildContext context) => new Elements(),
          "/account": (BuildContext context) => new SigninTree(),
          "/pro": (BuildContext context) => new Pro(),
          "/contracts": (BuildContext context) => new ChangeNotifierProvider(
              create: (context) => ContractsProvider(),
              child: WidgetTreeContracts()),
          "/RegisterContracts": (BuildContext context) =>
              new WidgetTreeRegisContract(),
          "/projects": (BuildContext context) => new WidgetTreeProjects(),
          "/project": (BuildContext context) => new WidgetTreeProject(),
          "/report": (BuildContext context) => new WidgetTreeReport(),
          "/modifyTimeTracking": (BuildContext context) =>
              new WidgetTreeModifyTimeTracking(),
          "/RegisterTimeTracking": (BuildContext context) =>
              new WidgetTreeRegisterTimeTracking(),
          "/RegisterProject": (BuildContext context) =>
              new WidgetTreeRegisterProject(),
          "/TimeTracking": (BuildContext context) => new ChangeNotifierProvider(
              create: (context) => TimeTrackingProvider(),
              child: WidgetTreeTimeTracking()),
          "/SpecificContract": (BuildContext context) =>
              new WidgetTreeSpecificContract(),
          "/SpecificTimeTracking": (BuildContext context) =>
              new SpecificTimeTracking(),
          "/reports": (BuildContext context) => new Reports(),
          "/TitleScrollScreen": (BuildContext context) =>
              new WidgetTreeProject(),
          "/CreateReports": (BuildContext context) =>
              new WidgetTreeCreateReport(),
          "/editReports": (BuildContext context) => new WidgetTreeEditReport(),
          "/modifyProject": (BuildContext context) =>
              new WidgetTreeModifyProject(),
          "/modifyContract": (BuildContext context) =>
              new WidgetTreeModifyContract(),
          "/TreeHome": (BuildContext context) => new ChangeNotifierProvider(
              create: (context) => ReportsProvider(), child: WidgetTreeHome()),
          "/signin": (BuildContext context) => new SigninTree(),
          "/animation": (BuildContext context) => new AnimationWait(),
          "/notificationsPage": (BuildContext context) =>
              new NotificationsPage(),
        });
  }
}
