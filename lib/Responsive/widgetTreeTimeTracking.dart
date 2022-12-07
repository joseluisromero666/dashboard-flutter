import 'package:argon_flutter/constants/Theme.dart';
import 'package:argon_flutter/models/timeTrackingProvider.dart';
import 'package:argon_flutter/screens/timeTracking.dart';
import 'package:argon_flutter/widgets/drawer.dart';
import 'package:argon_flutter/widgets/navbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'responsiveController.dart';

class WidgetTreeTimeTracking extends StatefulWidget {
  final index;
  WidgetTreeTimeTracking({this.index});
  @override
  _WidgetTreeTimeTracking createState() => _WidgetTreeTimeTracking();
}

class _WidgetTreeTimeTracking extends State<WidgetTreeTimeTracking> {
  _WidgetTreeTimeTracking();
  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    Size _size = MediaQuery.of(context).size;
    return SafeArea(
      child: ResponsiveLayout(
        phone: TimeTracking(),
        tablet: Scaffold(
          backgroundColor: ArgonColors.bgColorScreen,
          drawer: ArgonDrawer(
            currentPage: "TimeTracking",
          ),
          appBar: Navbar(
            avatar: true,
            rightOptions: false,
            prefferedHeight: 60,
            bgColor: ArgonColors.initial,
          ),
          body: Row(children: [
            Expanded(flex: 1, child: TimeTracking()),
            Expanded(child: Provider.of<TimeTrackingProvider>(context).timeTrackingCurrentWidget)
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
                    rightOptions: false,
                    bgColor: ArgonColors.initial,
                    prefferedHeight: 60,
                  ),
                  body: Row(children: [
                    Expanded(flex: 2, child: TimeTracking()),
                    Expanded(flex: 2, child: Provider.of<TimeTrackingProvider>(context).timeTrackingCurrentWidget)
                  ])),
            )
          ],
        ),
      ),
    );
  }
}
