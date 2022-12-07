import 'package:argon_flutter/constants/Theme.dart';

import 'package:argon_flutter/screens/profiles.dart';
import 'package:argon_flutter/widgets/drawer.dart';
import 'package:argon_flutter/widgets/navbar.dart';
import 'package:flutter/material.dart';
import 'responsiveController.dart';

// ignore: must_be_immutable
class WidgetTreeProfiles extends StatefulWidget {
  final index;
  var mainState;
  WidgetTreeProfiles({this.index, this.mainState});
  @override
  _WidgetTreeProfiles createState() => _WidgetTreeProfiles();
}

class _WidgetTreeProfiles extends State<WidgetTreeProfiles> {
  _WidgetTreeProfiles();
  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    Size _size = MediaQuery.of(context).size;
    return SafeArea(
      child: ResponsiveLayout(
        phone: Profiles(mainState: widget.mainState),
        tablet: Row(
          children: [
            Expanded(
              flex: 9,
              child: Profiles(
                  mainState: widget.mainState,
                  cardMargin: EdgeInsets.only(
                      left: (MediaQuery.of(context).size.width - 600) / 2,
                      right: (MediaQuery.of(context).size.width - 600) / 2,
                      top: 5)),
            )
          ],
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
                    Expanded(
                        child: Profiles(
                            mainState: widget.mainState,
                            cardMargin: EdgeInsets.only(
                                left: (MediaQuery.of(context).size.width - 600) / 2,
                                right: (MediaQuery.of(context).size.width - 600) / 2,
                                top: 5))),
                  ])),
            )
          ],
        ),
      ),
    );
  }
}
