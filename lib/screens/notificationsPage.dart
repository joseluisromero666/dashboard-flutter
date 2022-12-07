import 'package:argon_flutter/Responsive/responsiveController.dart';
import 'package:argon_flutter/constants/Theme.dart';
import 'package:argon_flutter/widgets/drawer.dart';
import 'package:argon_flutter/widgets/navbar.dart';
import 'package:flutter/material.dart';

class NotificationsPage extends StatefulWidget {
  // final GlobalKey _scaffoldKey = new GlobalKey();
  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ResponsiveLayout.isPhone(context)
          ? Navbar(
              avatar: true,
              backPage: "projects",
              rightOptions: false,
              bgColor: ArgonColors.initial,
              prefferedHeight: 60,
            )
          : null,
      backgroundColor: Theme.of(context).primaryColor == Colors.green[500]
          ? Colors.grey[900]
          : Theme.of(context).primaryColor == Colors.indigo[500]
              ? ArgonColors.white
              : Colors.blue[800],
      drawer: ArgonDrawer(
        currentPage: "Projects",
      ),
    );
  }
}
