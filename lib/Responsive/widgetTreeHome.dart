import 'package:argon_flutter/constants/Theme.dart';
import 'package:argon_flutter/models/reportsProvider.dart';
import 'package:argon_flutter/screens/home.dart';
import 'package:argon_flutter/widgets/drawer.dart';
import 'package:argon_flutter/widgets/navbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'responsiveController.dart';

class WidgetTreeHome extends StatefulWidget {
  final index;
  WidgetTreeHome({this.index});
  @override
  _WidgetTreeHome createState() => _WidgetTreeHome();
}

class _WidgetTreeHome extends State<WidgetTreeHome> {
  _WidgetTreeHome();
  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    Size _size = MediaQuery.of(context).size;
    return SafeArea(
      child: ResponsiveLayout(
        phone: Home(),
        tablet: Scaffold(
          backgroundColor: Theme.of(context).primaryColor == Colors.green[500]
              ? Colors.grey[600]
              : Theme.of(context).primaryColor == Colors.indigo[500]
                  ? ArgonColors.white
                  : Colors.blue[800],
          drawer: ArgonDrawer(
            currentPage: "Projects",
          ),
          appBar: Navbar(
            avatar: true,
            rightOptions: false,
            prefferedHeight: 60,
            bgColor: ArgonColors.initial,
          ),
          body: Row(children: [
            Expanded(flex: 2, child: Home()),
            Expanded(
                flex: 2,
                child:
                    Provider.of<ReportsProvider>(context).reportsCurrentWidget)
          ]),
        ),
        desktop: Row(
          children: [
            Expanded(
              flex: _size.width > 999 ? 1 : 3,
              child: ArgonDrawer(),
            ),
            Expanded(
              flex: _size.width > 999 ? 10 : 14,
              child: Scaffold(
                  appBar: Navbar(
                    avatar: true,
                    backPage: "projects",
                    rightOptions: false,
                    bgColor: ArgonColors.initial,
                    prefferedHeight: 60,
                  ),
                  body: Row(children: [
                    Expanded(flex: 2, child: Home()),
                    Expanded(
                        flex: 2,
                        child: Provider.of<ReportsProvider>(context)
                            .reportsCurrentWidget)
                  ])),
            )
          ],
        ),
      ),
    );
  }
}
