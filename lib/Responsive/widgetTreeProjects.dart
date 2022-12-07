import 'package:argon_flutter/constants/Theme.dart';
import 'package:argon_flutter/models/projectProvider.dart';
import 'package:argon_flutter/screens/projects.dart';
import 'package:argon_flutter/widgets/drawer.dart';
import 'package:argon_flutter/widgets/navbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'responsiveController.dart';

class WidgetTreeProjects extends StatefulWidget {
  final index;
  WidgetTreeProjects({this.index});
  @override
  _WidgetTreeProjects createState() => _WidgetTreeProjects();
}

class _WidgetTreeProjects extends State<WidgetTreeProjects> {
  _WidgetTreeProjects();

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;

    return SafeArea(
      child: ResponsiveLayout(
        phone: Projects(),
        tablet: Scaffold(
          backgroundColor: ArgonColors.bgColorScreen,
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
            Expanded(flex: 2, child: Projects()),
            Expanded(flex: 2, child: Provider.of<ProjectsProvider>(context).projectCurrentWidget)
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
                    Expanded(flex: 2, child: Projects()),
                    Expanded(flex: 2, child: Provider.of<ProjectsProvider>(context).projectCurrentWidget)
                  ])),
            )
          ],
        ),
      ),
    );
  }
}
